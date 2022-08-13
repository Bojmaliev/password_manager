import 'package:get_it/get_it.dart';
import 'package:password_manager/services/navigation_service.dart';

GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
}
