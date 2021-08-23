import 'package:get_it/get_it.dart';
import 'package:newsapp/services/auth.dart';
import 'package:newsapp/services/firebase_service.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<FirebaseService>(() => FirebaseService());
}
