import 'package:get_it/get_it.dart';
import 'package:orange_power/core/services/tariff_api.dart';
import 'package:orange_power/core/view_models/home_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => TariffsApi());

  locator.registerFactory(() => HomeModel());
}
