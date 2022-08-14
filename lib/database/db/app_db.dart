import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:password_manager/database/entity/login_credentials.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'password_manger.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [LoginCredentials])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<LoginCredential>> getLoginCredentials() async {
    return await select(loginCredentials).get();
  }

  Future<LoginCredential> getLoginCredential(int id) async {
    return await (select(loginCredentials)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateLoginCredential(LoginCredentialsCompanion entity) async {
    return await update(loginCredentials).replace(entity);
  }

  Future<int> insertLoginCredential(LoginCredentialsCompanion entity) async {
    return await into(loginCredentials).insert(entity);
  }

  Future<int> deleteLoginCredential(int id) async {
    return await (delete(loginCredentials)..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
