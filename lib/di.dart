import 'package:get_it/get_it.dart';
import 'package:password_manager/services/encrypt.dart';
import 'package:password_manager/database/db/app_db.dart';
import 'package:password_manager/repository/local_data.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/services/impl/encrypt_impl.dart';
import 'package:password_manager/services/impl/navigation_service.dart';
import 'package:password_manager/services/impl/login_credentials_service.dart';
import 'package:password_manager/repository/impl/login_credential_local_data.dart';
import 'package:password_manager/services/impl/snackbar_service.dart';

GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<SnackbarService>(() => SnackbarService());
  getIt.registerLazySingleton<AppDb>(() => AppDb());
  getIt.registerLazySingleton<LocalData<LoginCredential>>(
      () => LoginCredentialLocalData());

  getIt.registerLazySingleton<LoginCredentialService>(
      () => LoginCredentialService());

  const String password = "ASDFGHJKLASDFGHJ";
  getIt.registerFactory<Encrypt>(() => EncryptImpl(password));
}
