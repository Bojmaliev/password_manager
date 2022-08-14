import 'package:drift/drift.dart';
import 'package:password_manager/database/db/app_db.dart';

class LoginCredential{
  final int id;
  final String name;
  final String username;
  final String password;

  LoginCredential(
      {required this.id,
      required this.name,
      required this.username,
      required this.password});
}
