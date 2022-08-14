import 'package:drift/drift.dart';

import '../../models/login_credential.dart';

@UseRowClass(LoginCredential)
class LoginCredentials extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().named('name')();

  TextColumn get username => text().named('username')();

  TextColumn get password => text().named('password')();
}
