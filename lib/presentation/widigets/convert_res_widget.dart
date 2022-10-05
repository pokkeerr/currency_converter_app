import 'package:currency_converter_app/presentation/widigets/spline_area_chart_widget.dart';
import 'package:flutter/material.dart';
import '../../cubits/supoort_countries_cubit/suppourted_countries_state.dart';
import '../../data/models/currencyconverter_model.dart';
import '../../data/resources/styles_manager.dart';

class ConvertResulteWidget extends StatelessWidget {
  const ConvertResulteWidget({
    Key? key,
    required this.currencyconverterModel,
    required this.countrystate,
    required this.amount,
  }) : super(key: key);
  final CurrencyWeeklyconverterModel currencyconverterModel;
  final SuppourtedCountriesLoadedState countrystate;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SplineAreaChartWidget(currencyconverterModel),
          ...currencyconverterModel.res.entries
              .map((e) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(e.key.replaceAll("_", " > "),
                          style: mediumTextStyle(color: Colors.green)
                              .copyWith(fontSize: 20)),
                      ...e.value.entries
                          .map((ee) => Card(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(ee.key,
                                            style: mediumTextStyle(
                                                    color: Colors.blue)
                                                .copyWith(fontSize: 14))),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            (ee.value * amount)
                                                .toStringAsFixed(2),
                                            style: mediumTextStyle(
                                                    color: Colors.blue)
                                                .copyWith(fontSize: 14)))
                                  ])))
                          .toList()
                    ],
                  )))
              .toList()
        ]);
  }
}
