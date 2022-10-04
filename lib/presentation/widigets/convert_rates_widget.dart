import 'package:flutter/material.dart';
import '../../cubits/supoort_countries_cubit/suppourted_countries_state.dart';
import '../../data/models/convert_rates_model.dart';
import '../../data/resources/styles_manager.dart';

class ConvertAllRates extends StatelessWidget {
  const ConvertAllRates({
    Key? key,
    required this.converterRatesModel,
    required this.countrystate,
    required this.amount,
  }) : super(key: key);
  final ConverterRatesModel converterRatesModel;
  final SuppourtedCountriesLoadedState countrystate;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
              child: Text(
                  'Updated Date :${converterRatesModel.date.toIso8601String().substring(0, 10)}',
                  style: mediumTextStyle(color: Colors.green)
                      .copyWith(fontSize: 18))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
              child: Text(
                  "${'Base: ${countrystate.toCountry.fromIso3166ToIso4017()}\n${(converterRatesModel.getAmountFor(countrystate.toCountry.fromIso3166ToIso4017()) * amount).toStringAsFixed(2)}'} ${countrystate.toCountry.isoCode}",
                  style: mediumTextStyle(color: Colors.green)
                      .copyWith(fontSize: 30))),
          _allRatesWidget(converterRatesModel),
        ]);
  }

  Padding _allRatesWidget(ConverterRatesModel converterRatesModel) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('All Rates :',
                    style: mediumTextStyle(color: Colors.black)
                        .copyWith(fontSize: 16))),
            Column(
                children: converterRatesModel.rates.entries.map<Widget>(((e) {
              return Card(
                  // padding: const EdgeInsets.symmetric(vertical: 2),
                  // backgroundColor: Colors.blue,
                  // label:
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${e.key} ',
                                    style: mediumTextStyle(color: Colors.blue)
                                        .copyWith(fontSize: 13))),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${(e.value * amount).toStringAsFixed(2)} ',
                                    style: mediumTextStyle(color: Colors.blue)
                                        .copyWith(fontSize: 13)))
                          ])));
            })).toList()),
          ],
        ));
  }
}
