import 'package:get_it/get_it.dart';
import 'package:newsapp/firebase/analytics.dart';
import 'package:newsapp/firebase/auth.dart';
import 'package:newsapp/firebase/firestore.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<FirebaseService>(() => FirebaseService());
  locator.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
}
