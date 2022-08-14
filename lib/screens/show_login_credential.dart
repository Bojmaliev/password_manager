import 'package:flutter/material.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/services/impl/login_credentials_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show credential'),
        centerTitle: true,
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
                Text(item.name),
                Text(item.username),
                Text(item.password),
              ],
            );
          }
          return const Text('No items found');
        },
      ),
    );
  }
}
