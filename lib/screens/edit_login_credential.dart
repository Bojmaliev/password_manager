import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/providers/login_credential_provider.dart';
import 'package:password_manager/services/impl/login_credentials_service.dart';
import 'package:password_manager/services/impl/navigation_service.dart';
import 'package:password_manager/services/impl/snackbar_service.dart';

class EditLoginCredential extends StatefulWidget {
  final int id;

  const EditLoginCredential({Key? key, required this.id}) : super(key: key);

  @override
  State<EditLoginCredential> createState() => _EditLoginCredentialState();
}

class _EditLoginCredentialState extends State<EditLoginCredential> {
  final _formKey = GlobalKey<FormState>();
  final NavigationService _navigationService = getIt<NavigationService>();
  final SnackbarService _snackbarService = getIt<SnackbarService>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginCredentialService _loginCredentialService =
      getIt<LoginCredentialService>();
  final LoginCredentialProvider _loginCredentialProvider =
      getIt<LoginCredentialProvider>();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loadData();
  }

  Future<void> loadData() async {
    LoginCredential credential =
        await _loginCredentialService.getOne(widget.id);
    _nameController.text = credential.name;
    _usernameController.text = credential.username;
    _passwordController.text = credential.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit credential'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _editLoginCredential, icon: const Icon(Icons.save))
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

  Future<void> _editLoginCredential() async {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final entity = LoginCredential(
        id: widget.id,
        name: _nameController.text,
        username: _usernameController.text,
        password: _passwordController.text,
      );
      await _loginCredentialProvider.updateLoginCredential(entity);
      _snackbarService.show("Your login credential was edited");
      _navigationService.goBack();
    }
  }
}
