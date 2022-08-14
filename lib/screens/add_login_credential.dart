import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:password_manager/database/db/app_db.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/services/navigation_service.dart';


class AddLoginCredential extends StatefulWidget {
  const AddLoginCredential({Key? key}) : super(key: key);

  @override
  State<AddLoginCredential> createState() => _AddLoginCredentialState();
}

class _AddLoginCredentialState extends State<AddLoginCredential> {
  final NavigationService _navigationService = getIt<NavigationService>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AppDb _db = getIt<AppDb>();

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
                onPressed: () {
                  final entity = LoginCredentialsCompanion(
                    name: drift.Value(_nameController.text),
                    username: drift.Value(_usernameController.text),
                    password: drift.Value(_passwordController.text),
                  );
                  _db.insertLoginCredential(entity).then((value) =>
                      ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(
                              content: const Text("Saved new login credential"),
                              actions: [
                            TextButton(
                                onPressed: () => ScaffoldMessenger.of(context)
                                    .hideCurrentMaterialBanner(),
                                child: const Text('Close'))
                          ])));
                  _navigationService.goBack();
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                )
              ],
            )));
  }
}
