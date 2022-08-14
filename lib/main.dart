import 'package:flutter/material.dart';
import 'package:password_manager/database/db/app_db.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/providers/login_credential_provider.dart';
import 'package:password_manager/services/impl/navigation_service.dart';
import 'package:password_manager/services/impl/snackbar_service.dart';
import 'package:password_manager/utils/router/route_generator.dart';
import 'package:provider/provider.dart';

import 'di.dart';

Future<void> main() async {
  await setupGetIt();
  runApp(
    ChangeNotifierProvider<LoginCredentialProvider>(
      create: (builder) {
        LoginCredentialProvider loginCredentialProvider =
            getIt<LoginCredentialProvider>();
        loginCredentialProvider.getLoginCredentialsFuture();
        return loginCredentialProvider;
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      scaffoldMessengerKey: getIt<SnackbarService>().scaffoldMessengerKey,
      title: 'Password Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: RouteGenerator.initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
