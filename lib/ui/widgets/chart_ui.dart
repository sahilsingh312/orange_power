import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:orange_power/core/models/tariff_model.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChartUI extends StatelessWidget {
  final List<MyTariffModel> _tariffs;
  const ChartUI(this._tariffs, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<charts.Series<MyTariffModel, String>> series = [
      charts.Series(
        id: "orange_tariffs",
        data: _tariffs,
        domainFn: (MyTariffModel myTariff, _) =>
            DateTime.parse(myTariff.valid_from).toString().substring(11, 16),
        measureFn: (MyTariffModel myTariff, _) => myTariff.value_inc_vat,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];
    return SizedBox(
      height: ResponsiveValue(
        context,
        defaultValue: 300,
        valueWhen: [
          const Condition.smallerThan(name: TABLET, value: 600)
        ],
      ).value!.toDouble(),
      child: charts.BarChart(
        series,
        animate: true,
        domainAxis: const charts.OrdinalAxisSpec(
            renderSpec: charts.SmallTickRendererSpec(labelRotation: 60)),
      ),
    );
  }
}
