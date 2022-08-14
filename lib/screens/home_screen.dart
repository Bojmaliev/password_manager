import 'package:flutter/material.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/providers/login_credential_provider.dart';
import 'package:password_manager/services/base_service.dart';
import 'package:password_manager/services/impl/login_credentials_service.dart';
import 'package:password_manager/services/impl/navigation_service.dart';
import 'package:password_manager/utils/router/routes.dart';
import 'package:password_manager/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/login_credential_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NavigationService navigationService = getIt<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password manager'),
        centerTitle: true,
      ),
      body: Consumer<LoginCredentialProvider>(
        builder: (_, instance, child) {
          final List<LoginCredential> list = instance.loginCredentialListFuture;
          if (list.isEmpty) {
            return const Center(
                child: Text("You don't have any login credentials saved yet!")
            );
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return LoginCredentialCard(item: list[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          navigationService.navigateTo(addLoginCredential);
        },
      ),
    );
  }
}
