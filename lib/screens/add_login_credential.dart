import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/providers/login_credential_provider.dart';
import 'package:password_manager/services/impl/login_credentials_service.dart';
import 'package:password_manager/services/impl/navigation_service.dart';
import 'package:password_manager/services/impl/snackbar_service.dart';

class AddLoginCredential extends StatefulWidget {
  const AddLoginCredential({Key? key}) : super(key: key);

  @override
  State<AddLoginCredential> createState() => _AddLoginCredentialState();
}

class _AddLoginCredentialState extends State<AddLoginCredential> {
  final _formKey = GlobalKey<FormState>();
  final NavigationService _navigationService = getIt<NavigationService>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginCredentialProvider _loginCredentialProvider =
      getIt<LoginCredentialProvider>();
  final SnackbarService _snackbarService = getIt<SnackbarService>();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add credential'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _addLoginCredential, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: ValidationBuilder().required().build(),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: ValidationBuilder().required().build(),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: ValidationBuilder().required().build(),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addLoginCredential() async {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final entity = LoginCredential(
        name: _nameController.text,
        username: _usernameController.text,
        password: _passwordController.text,
      );
      await _loginCredentialProvider.insertLoginCredential(entity);
      _snackbarService.show("Your login credential was saved");
      _navigationService.goBack();
    }
  }
}
