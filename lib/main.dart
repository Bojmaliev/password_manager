import 'package:flutter/material.dart';
import 'package:password_manager/services/navigation_service.dart';
import 'package:password_manager/utils/router/router.dart';

import 'di.dart';

Future<void> main() async {
  await setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      title: 'Password Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: MyRouter.initialRoute,
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}
