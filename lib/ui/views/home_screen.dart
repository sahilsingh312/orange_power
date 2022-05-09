import 'package:flutter/material.dart';
import 'package:orange_power/core/enums/view_state.dart';
import 'package:orange_power/core/view_models/home_viewmodel.dart';
import 'package:orange_power/ui/views/base_view.dart';
import 'package:orange_power/ui/widgets/chart_ui.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<bool> showCheapestBlock = ValueNotifier<bool>(false);
  ValueNotifier<bool> showCheapestTariff = ValueNotifier<bool>(false);
  @override
  void dispose() {
    showCheapestBlock.dispose();
    showCheapestTariff.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getTariffs(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffFA7D19),
            title:  Center(child: Text('Orange Power', style: Theme.of(context).textTheme.headline1,)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      model.state == ViewState.busy
                          ? () {}
                          : model.getCheapestTariffBlock();
                      showCheapestBlock.value = true;
                    },
                    child: const Text(
                      'Cheapest 4 hour block',
                    )),
              )
            ],
          ),
          body: model.state == ViewState.busy
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveValue(
                      context,
                      defaultValue: 32,
                      valueWhen: [
                        const Condition.smallerThan(name: TABLET, value: 4)
                      ],
                    ).value!.toDouble(),
                  ),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Text('Orange Tariffs Chart', style: Theme.of(context).textTheme.headline2,),
                          for (var date in model.groupByDate.keys)
                            buildColumnCharts(date, model),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: ValueListenableBuilder(
                              valueListenable: showCheapestBlock,
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                return value == true
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 20),
                                            child: Text('Cheapest 4 hour Tariff Block', style: Theme.of(context).textTheme.bodyText1,),
                                          ),
                                          ChartUI(model.cheapestTariffBlock),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(model
                                                .cheapestTariffBlock[0].valid_from
                                                .substring(0, 10), style: Theme.of(context).textTheme.bodyText1,),
                                          )
                                        ],
                                      )
                                    : const SizedBox();
                              },
                            )),
                          ),
                          const SizedBox(height: 40,),
                        ],
                      ),
                    ),
                  ),
                ),
          bottomSheet: Container(
            color: const Color(0xffFA7D19),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Text('Best Future Tariff', style: Theme.of(context).textTheme.button),
                  onPressed: () {
                    model.getCheapestTariff();
                    showCheapestTariff.value = true;
                  },
                ),
                ValueListenableBuilder(
                    valueListenable: showCheapestTariff,
                    builder: (BuildContext context, value, Widget? child) {
                      return value == true
                          ? Text(
                              '${model.cheapestTariff.valid_from.substring(0, 10)} : ${model.cheapestTariff.value_inc_vat}', style: Theme.of(context).textTheme.bodyText1,)
                          : const Text('');
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  Column buildColumnCharts(date, HomeModel model) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(date, style: Theme.of(context).textTheme.bodyText1,),
        ),
        if (model.groupByDate[date].length > 25)
          for (int i = 0; i < model.groupByDate[date].length ~/ 25 + 1; i++)
            ChartUI(model.groupByDate[date].sublist(0, 25)),
        if (model.groupByDate[date].length < 25)
          ChartUI(model.groupByDate[date])
      ],
    );
  }
}
