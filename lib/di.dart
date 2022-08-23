import 'package:get_it/get_it.dart';
import 'package:password_manager/providers/login_credential_provider.dart';
import 'package:password_manager/services/encrypt_service.dart';
import 'package:password_manager/database/db/app_db.dart';
import 'package:password_manager/repository/local_data.dart';
import 'package:password_manager/models/login_credential.dart';
import 'package:password_manager/services/impl/encrypt_service_impl.dart';
import 'package:password_manager/services/impl/local_auth_service_impl.dart';
import 'package:password_manager/services/impl/navigation_service.dart';
import 'package:password_manager/services/impl/login_credentials_service.dart';
import 'package:password_manager/repository/impl/login_credential_local_data.dart';
import 'package:password_manager/services/impl/snackbar_service.dart';
import 'package:password_manager/services/local_auth_service.dart';

GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<SnackbarService>(() => SnackbarService());
  getIt.registerLazySingleton<AppDb>(() => AppDb());
  getIt.registerLazySingleton<LocalData<LoginCredential>>(
      () => LoginCredentialLocalData());

  getIt.registerLazySingleton<LoginCredentialService>(
      () => LoginCredentialService());

  getIt.registerLazySingleton<LoginCredentialProvider>(
      () => LoginCredentialProvider());

  getIt.registerLazySingleton<LocalAuthService>(() => LocalAuthServiceImpl());

  getIt.registerFactoryAsync<EncryptService>(() async {
    final localAuthService = getIt<LocalAuthService>();

    if (!(await localAuthService.hasPassword())) {
      throw Exception('Password not yet set');
    }
    String password = (await localAuthService.getPassword()) as String;
    return EncryptServiceImpl(password);
  });
}
