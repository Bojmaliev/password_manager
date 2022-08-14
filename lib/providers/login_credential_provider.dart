import 'package:flutter/material.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/services/impl/login_credentials_service.dart';
import 'package:collection/collection.dart';

class LoginCredentialProvider extends ChangeNotifier {
  final LoginCredentialService _loginCredentialService =
      getIt<LoginCredentialService>();

  List<LoginCredential> _loginCredentialListFuture = [];

  List<LoginCredential> get loginCredentialListFuture =>
      _loginCredentialListFuture;

  int? id;

  LoginCredential? get loginCredential =>
      loginCredentialListFuture.firstWhereOrNull((element) => element.id == id);

  Future<void> getLoginCredentialsFuture() async {
    _loginCredentialListFuture = await _loginCredentialService.getAll();
    notifyListeners();
  }

  Future<void> getLoginCredential(int id) async {
    this.id = id;
  }

  Future<void> insertLoginCredential(LoginCredential entity) async {
    await _loginCredentialService.insert(entity);
    await getLoginCredentialsFuture();
    notifyListeners();
  }

  Future<void> updateLoginCredential(LoginCredential entity) async {
    await _loginCredentialService.update(entity);
    await getLoginCredentialsFuture();
    notifyListeners();
  }

  Future<void> deleteLoginCredential(int id) async {
    await _loginCredentialService.delete(id);
    await getLoginCredentialsFuture();
    notifyListeners();
  }
}
