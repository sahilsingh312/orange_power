import 'package:orange_power/core/enums/view_state.dart';
import 'package:orange_power/core/models/tariff_model.dart';
import 'package:orange_power/core/services/tariff_api.dart';
import 'package:orange_power/core/view_models/base_viewmodel.dart';
import 'package:orange_power/locator.dart';
import "package:collection/collection.dart";

class HomeModel extends BaseModel {
  TariffsApi tariffApi = locator<TariffsApi>();

  late List<MyTariffModel> _myTariffs;
  late var groupByDate;
  List<MyTariffModel> _cheapestTariffBlock = [];
  List<MyTariffModel> get cheapestTariffBlock => [..._cheapestTariffBlock];
  late MyTariffModel _cheapestTariff;
  MyTariffModel get cheapestTariff => _cheapestTariff;

  Future getTariffs() async {
    setState(ViewState.busy);
    _myTariffs = await tariffApi.getAvailableTariffs();
    groupByDate = groupBy(
        _myTariffs, (MyTariffModel obj) => obj.valid_from.substring(0, 10));
    setState(ViewState.idle);
  }

  MyTariffModel getCheapestTariff() {
    _cheapestTariff = _myTariffs.reduce((currentTariff, nextTariff) =>
        currentTariff.value_inc_vat < nextTariff.value_inc_vat
            ? currentTariff
            : nextTariff);

    return _cheapestTariff;
  }

  void getCheapestTariffBlock() {
    double maxSum = _myTariffs
        .sublist(0, 4)
        .fold(0, (previous, current) => previous + current.value_inc_vat);
    List<MyTariffModel> maxList = _myTariffs.sublist(0, 4);
    for (int i = 4; i < _myTariffs.length; i++) {
      double currentSum = _myTariffs
          .sublist(i - 3, i + 1)
          .fold(0, (previous, current) => previous + current.value_inc_vat);
      maxSum + _myTariffs[i].value_inc_vat - _myTariffs[i - 4].value_inc_vat;
      if (currentSum < maxSum) {
        maxSum = currentSum;
        maxList = _myTariffs.sublist(i - 3, i + 1);
      }
    }
    _cheapestTariffBlock = maxList;
  }
}
