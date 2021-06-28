import 'package:get_it/get_it.dart';

import 'provider/category_provider.dart';
import 'provider/auth_provider.dart';
import 'provider/user_provider.dart';
import 'services/auth_service.dart';
import 'services/category_service.dart';
import 'services/messaging_service.dart';
import 'services/storage_service.dart';
import 'services/user_service.dart';

GetIt services = GetIt.instance;

void setupServices() {
  services.registerLazySingleton<AuthService>(() => AuthService());
  services.registerLazySingleton<CategoryService>(() => CategoryService());
  services.registerLazySingleton<MessagingService>(() => MessagingService());
  services.registerLazySingleton<StorageService>(() => StorageService());
  services.registerLazySingleton<UserService>(() => UserService());


  services.registerSingletonAsync<CategoryProvider>(() async => CategoryProvider());
  services.registerSingletonAsync<UserProvider>(() async => UserProvider());
  services.registerSingletonAsync<AuthProvider>(
    () async => AuthProvider(),
    dependsOn: [UserProvider],
  );
}
