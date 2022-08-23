import 'package:flutter/material.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/services/impl/navigation_service.dart';
import 'package:password_manager/services/impl/snackbar_service.dart';
import 'package:password_manager/services/local_auth_service.dart';

import '../utils/router/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password = "";
  bool registered = false;
  final LocalAuthService _localAuthService = getIt<LocalAuthService>();
  final NavigationService _navigationService = getIt<NavigationService>();
  final SnackbarService _snackbarService = getIt<SnackbarService>();

  @override
  void initState() {
    super.initState();
    _tryBiometrics();
    _checkIfRegistered();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login screen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(registered
                  ? 'Please enter your password:'
                  : 'Please create your password'),
              password.isEmpty
                  ? const Text(
                      "",
                      style: TextStyle(fontSize: 40.0),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Text>.generate(
                        password.length,
                        (i) => const Text(
                          "*",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ),
            ],
          ),
          Column(children: [
            ...List<Row>.generate(3, (i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List<OutlinedButton>.generate(3, (j) {
                  String value = (3 * i + j + 1).toString();
                  return OutlinedButton(
                      onPressed: () => _appendToPassword(value),
                      child: Text(value));
                }),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    onPressed: _handleLoginClick, child: const Text('OK')),
                OutlinedButton(
                    onPressed: () => _appendToPassword("0"),
                    child: const Text('0')),
                OutlinedButton(
                  onPressed: _removeLastCharFromPassword,
                  child: const Icon(Icons.backspace),
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }

  void _appendToPassword(String char) {
    setState(() {
      password = password + char;
    });
  }

  void _removeLastCharFromPassword() {
    setState(() {
      password = password.substring(0, password.length - 1);
    });
  }

  void _tryBiometrics() async {
    bool authenticated = await _localAuthService
        .authenticateWithBiometrics("Please authenticate");
    if (authenticated) {
      _navigationService.navigateToAndRemove(home);
    }
  }

  Future<void> _handleLoginClick() async {
    if (password.length < 4) {
      _snackbarService.show('Please enter a password with more than 3 digits');
      return;
    }
    if (await _localAuthService.hasPassword()) {
      await _login();
      _snackbarService.show("Your password is correct");
    } else {
      await _register();
      _snackbarService.show("You successfully created a password");
    }
  }

  Future<void> _login() async {
    bool authenticated =
        await _localAuthService.authenticateWithPassword(password);
    if (authenticated) {
      _navigationService.navigateToAndRemove(home);
    }
  }

  Future<void> _register() async {
    await _localAuthService.setPassword(password);
    _navigationService.navigateToAndRemove(home);
  }

  void _checkIfRegistered() async {
    setState(() async {
      registered = await _localAuthService.hasPassword();
    });
  }
}
