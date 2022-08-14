import 'package:flutter/material.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/providers/login_credential_provider.dart';
import 'package:password_manager/services/impl/login_credentials_service.dart';
import 'package:password_manager/services/impl/navigation_service.dart';
import 'package:password_manager/services/impl/snackbar_service.dart';
import 'package:password_manager/utils/router/routes.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ShowLoginCredential extends StatefulWidget {
  final int id;

  const ShowLoginCredential({Key? key, required this.id}) : super(key: key);

  @override
  State<ShowLoginCredential> createState() => _ShowLoginCredentialState();
}

class _ShowLoginCredentialState extends State<ShowLoginCredential> {
  final NavigationService _navigationService = getIt<NavigationService>();
  final SnackbarService _snackbarService = getIt<SnackbarService>();
  final LoginCredentialProvider _loginCredentialProvider =
      getIt<LoginCredentialProvider>();
  bool _showPassword = false;

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Future<void> _deleteLoginCredential() async {
    await _loginCredentialProvider.deleteLoginCredential(widget.id);
    _snackbarService.show('You successfully deleted selected login credential');
    _navigationService.goBack();
  }

  void _saveToClipboard(String message) {
    Clipboard.setData(ClipboardData(text: message));
    _snackbarService.show('Your clipboard contains new text');
  }

  @override
  void initState() {
    super.initState();
    _loginCredentialProvider.getLoginCredential(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show credential'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _navigationService
                  .navigateTo(editLoginCredential, args: {'id': widget.id});
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: _deleteLoginCredential,
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Consumer<LoginCredentialProvider>(
        builder: (_, instance, child) {
          final LoginCredential? item = instance.loginCredential;
          if (item == null) {
            return const Center(
              child: Text('Not found'),
            );
          }
          return Column(
            children: [
              Card(
                child: ListTile(
                  title: const Text('Name:'),
                  subtitle: Text(item.name),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Username:'),
                  subtitle: Text(item.username),
                  trailing: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () => _saveToClipboard(item.username),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Password:'),
                  subtitle: Text(
                    _showPassword
                        ? item.password
                        : item.password.replaceAll(RegExp('.'), '*'),
                  ),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye_outlined),
                        onPressed: _toggleShowPassword,
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () => _saveToClipboard(item.password),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
