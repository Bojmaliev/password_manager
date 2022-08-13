import 'package:flutter/material.dart';
import 'package:password_manager/screens/home.dart';
import 'package:password_manager/utils/router/routes.dart';

import '../../screens/not_found.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            builder: (_) => const Home()
        );
      default:
        return MaterialPageRoute(builder: (_) => const NotFound());
    }
  }

  static String initialRoute = home;
}
