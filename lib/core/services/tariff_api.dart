import 'dart:convert';
import "package:collection/collection.dart";
import 'package:http/http.dart' as http;
import 'package:orange_power/core/models/tariff_model.dart';

class TariffsApi {
  Future<List<MyTariffModel>> getAvailableTariffs() async {
    var tariffs = <MyTariffModel>[];
    late var groupByDate;
    final response = await http.get(Uri.parse(
        'https://api.octopus.energy/v1/products/AGILE-18-02-21/electricity-tariffs/E-1R-AGILE-18-02-21-A/standard-unit-rates/'));
    if (response.statusCode == 200) {
      var parsed = json.decode(response.body)['results'] as List<dynamic>;
      for (var tariff in parsed) {
        tariffs.add(MyTariffModel.fromJson(tariff));
      }
      groupByDate =
          groupBy(tariffs, (MyTariffModel obj) => obj.valid_from.substring(0, 10));
      return tariffs;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
