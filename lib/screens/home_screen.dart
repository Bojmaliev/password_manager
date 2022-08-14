import 'package:flutter/material.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/services/base_service.dart';
import 'package:password_manager/services/impl/login_credentials_service.dart';
import 'package:password_manager/services/navigation_service.dart';
import 'package:password_manager/utils/router/routes.dart';
import 'package:password_manager/widgets/loading_screen.dart';

import '../widgets/login_credential_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LoginCredentialService _loginCredentialsService =
      getIt<LoginCredentialService>();

  final NavigationService navigationService = getIt<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password manager'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<LoginCredential>>(
        future: _loginCredentialsService.getAll(),
        builder: (context, snapshot) {
          final List<LoginCredential>? list = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingScreen();
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (list != null) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return LoginCredentialCard(item: list[index]);
              },
            );
          }
          return const Text('No items found');
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            navigationService.navigateTo(addLoginCredential);
          }),
    );
  }
}
