import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manager/services/local_auth_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:crypto/crypto.dart';

class LocalAuthServiceImpl implements LocalAuthService {
  final _auth = LocalAuthentication();
  final storage = const FlutterSecureStorage();
  static const passwordKeyName = 'password';

  @override
  Future<bool> authenticateWithBiometrics(String reason) async {
    if (!(await hasPassword())) return false;
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<bool> hasBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      return canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    } on PlatformException catch (e) {
      return false;
    }
  }

  @override
  Future<bool> authenticateWithPassword(String password) async {
    if (!(await hasPassword())) return false;
    var inBytes = utf8.encode(password);
    password = sha256.convert(inBytes).toString().substring(0, 16);
    return (await getPassword()) == password;
  }

  @override
  Future<bool> hasPassword() async {
    return (await getPassword()) != null;
  }

  @override
  Future<void> setPassword(String password) async {
    var inBytes = utf8.encode(password);
    password = sha256.convert(inBytes).toString().substring(0, 16);
    await storage.write(key: passwordKeyName, value: password);
  }

  @override
  Future<String?> getPassword() async {
    return await storage.read(key: passwordKeyName);
  }
}
