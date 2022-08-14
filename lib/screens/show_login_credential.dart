import 'package:flutter/material.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/services/impl/login_credentials_service.dart';
import 'package:password_manager/services/navigation_service.dart';
import 'package:password_manager/utils/router/routes.dart';
import 'package:password_manager/widgets/loading_screen.dart';

class ShowLoginCredential extends StatefulWidget {
  final int id;

  const ShowLoginCredential({Key? key, required this.id}) : super(key: key);

  @override
  State<ShowLoginCredential> createState() => _ShowLoginCredentialState();
}

class _ShowLoginCredentialState extends State<ShowLoginCredential> {
  final LoginCredentialService _loginCredentialService =
      getIt<LoginCredentialService>();
  final NavigationService _navigationService = getIt<NavigationService>();
  bool _showPassword = false;

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
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
              icon: const Icon(Icons.edit))
        ],
      ),
      body: FutureBuilder<LoginCredential>(
        future: _loginCredentialService.getOne(widget.id),
        builder: (context, snapshot) {
          final LoginCredential? item = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingScreen();
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (item != null) {
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
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      onPressed: _toggleShowPassword,
                    ),
                  ),
                )
              ],
            );
          }
          return const Text('No items found');
        },
      ),
    );
  }
}
