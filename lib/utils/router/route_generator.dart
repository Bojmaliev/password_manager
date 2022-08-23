import 'package:flutter/material.dart';
import 'package:password_manager/screens/login_screen.dart';
import 'package:password_manager/screens/not_found.dart';
import 'package:password_manager/utils/router/routes.dart';
import 'package:password_manager/screens/home_screen.dart';
import 'package:password_manager/screens/add_login_credential.dart';
import 'package:password_manager/screens/show_login_credential.dart';
import 'package:password_manager/screens/edit_login_credential.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = (settings.arguments ?? <String, dynamic>{}) as Map;

    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const Home());

      case addLoginCredential:
        return MaterialPageRoute(builder: (_) => const AddLoginCredential());
      case showLoginCredential:
        return MaterialPageRoute(builder: (_) {
          var id = arguments['id'];
          if (id == null) {
            throw Exception('id param required');
          }
          return ShowLoginCredential(id: id);
        });

      case editLoginCredential:
        return MaterialPageRoute(builder: (_) {
          var id = arguments['id'];
          if (id == null) {
            throw Exception('id param required');
          }
          return EditLoginCredential(id: id);
        });

      default:
        return MaterialPageRoute(builder: (_) => const NotFound());
    }
  }

  static String initialRoute = loginScreen;
}
