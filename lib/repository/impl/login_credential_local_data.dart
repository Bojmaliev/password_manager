import 'package:drift/drift.dart';
import 'package:password_manager/database/db/app_db.dart';
import 'package:password_manager/di.dart';
import 'package:password_manager/models/login_credential.dart';

import 'package:password_manager/repository/local_data.dart';

class LoginCredentialLocalData implements LocalData<LoginCredential> {
  final AppDb _appDb = getIt<AppDb>();

  @override
  Future<List<LoginCredential>> getAll() async {
    return _appDb.getLoginCredentials();
  }

  @override
  Future<LoginCredential> getOne(int id) {
    return _appDb.getLoginCredential(id);
  }

  @override
  Future<int> insert(LoginCredential entity) {
    return _appDb.insertLoginCredential(LoginCredentialsCompanion(
        name: Value(entity.name),
        username: Value(entity.username),
        password: Value(entity.password)));
  }

  @override
  Future<bool> update(LoginCredential entity) {
    return _appDb.updateLoginCredential(LoginCredentialsCompanion(
      id: Value.ofNullable(entity.id),
      name: Value(entity.name),
      username: Value(entity.username),
      password: Value(entity.password),
    ));
  }
}
