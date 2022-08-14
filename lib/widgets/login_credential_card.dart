import 'package:flutter/material.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/services/impl/navigation_service.dart';
import 'package:password_manager/utils/router/routes.dart';

import '../models/login_credential.dart';

class LoginCredentialCard extends StatelessWidget {
  LoginCredentialCard({Key? key, required this.item}) : super(key: key);

  final LoginCredential item;
  final NavigationService _navigationService = getIt<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          child: ListTile(
        title: Text(item.username),
        subtitle: Text(item.name),
      )),
      onTap: () {
        _navigationService
            .navigateTo(showLoginCredential, args: {'id': item.id});
      },
    );
  }
}
