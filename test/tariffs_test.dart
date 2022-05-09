import 'package:flutter_test/flutter_test.dart';
import 'package:orange_power/core/models/tariff_model.dart';
import 'package:orange_power/core/services/tariff_api.dart';
import 'package:orange_power/core/view_models/home_viewmodel.dart';
import 'package:orange_power/locator.dart';

class MockTariffApi extends TariffsApi {
  @override
  Future<List<MyTariffModel>> getAvailableTariffs() {
    return Future.value([
      MyTariffModel(
          value_exec_vat: 14.10,
          value_inc_vat: 14.95,
          valid_from: "2022-05-10T21:30:00Z",
          valid_to: "2022-05-10T22:00:00Z"),
      MyTariffModel(
          value_exec_vat: 16.10,
          value_inc_vat: 17.08,
          valid_from: "2022-05-10T21:00:00Z",
          valid_to: "2022-05-10T21:30:00Z"),
      MyTariffModel(
          value_exec_vat: 11.20,
          value_inc_vat: 12.15,
          valid_from: "2022-05-10T20:30:00Z",
          valid_to: "2022-05-10T21:00:00Z"),
      MyTariffModel(
          value_exec_vat: 18.10,
          value_inc_vat: 18.90,
          valid_from: "2022-05-10T19:30:00Z",
          valid_to: "2022-05-10T20:00:00Z"),
      MyTariffModel(
          value_exec_vat: 22.50,
          value_inc_vat: 24.60,
          valid_from: "2022-05-10T19:00:00Z",
          valid_to: "2022-05-10T19:30:00Z"),
      MyTariffModel(
          value_exec_vat: 10.40,
          value_inc_vat: 11.00,
          valid_from: "2022-05-10T18:30:00Z",
          valid_to: "2022-05-10T19:00:00Z"),
      MyTariffModel(
          value_exec_vat: 16.86,
          value_inc_vat: 18.21,
          valid_from: "2022-05-10T18:00:00Z",
          valid_to: "2022-05-10T18:30:00Z"),
      MyTariffModel(
          value_exec_vat: 11.90,
          value_inc_vat: 13.45,
          valid_from: "2022-05-10T17:30:00Z",
          valid_to: "2022-05-10T18:00:00Z"),
    ]);
  }
}

void main() {
  setupLocator();
  var tariffViewModel = locator<HomeModel>();
  tariffViewModel.tariffApi = MockTariffApi();

  group('Given Tariffs should load', () {
    test('Page should load a list of products from firebase', () async {
      await tariffViewModel.getTariffs();
      tariffViewModel.getCheapestTariff();
      tariffViewModel.getCheapestTariffBlock();
      expect(tariffViewModel.cheapestTariff.value_inc_vat, 11.00);

      expect(
          tariffViewModel.cheapestTariffBlock[0].value_inc_vat +
              tariffViewModel.cheapestTariffBlock[1].value_inc_vat +
              tariffViewModel.cheapestTariffBlock[2].value_inc_vat +
              tariffViewModel.cheapestTariffBlock[3].value_inc_vat,
          63.08);
    });
  });
}
