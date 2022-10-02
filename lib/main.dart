import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_converter_app/cubits/currency_convert_cubit/currency_convert_cubit.dart';
import 'package:currency_converter_app/cubits/internet_connection/internet_connection_cubit.dart';
import 'package:currency_converter_app/cubits/supoort_countries_cubit/suppourted_countries_cubit.dart';
import 'package:currency_converter_app/data/models/support_countries_model.dart';
import 'package:currency_converter_app/data/repos/currency_convert_repo.dart';
import 'package:currency_converter_app/data/repos/support_countreis_repo.dart';
import 'package:currency_converter_app/data/resources/styles_manager.dart';
import 'package:currency_converter_app/data/resources/values_manager.dart';
import 'package:currency_converter_app/helpers/flags_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cubits/supoort_countries_cubit/suppourted_countries_state.dart';
import 'package:sizer/sizer.dart';

void main() async {
  final Connectivity connectivity = Connectivity();
  final CurrencyConvertRepo convertRepo = CurrencyConvertRepo();
  final SupportCountriesRepo supportCountriesRepo = SupportCountriesRepo();
  await Hive.initFlutter();

  runApp(MyApp(connectivity, convertRepo, supportCountriesRepo));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  final CurrencyConvertRepo convertRepo;
  final SupportCountriesRepo supportCountriesRepo;
  const MyApp(this.connectivity, this.convertRepo, this.supportCountriesRepo,
      {Key? key})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SuppourtedCountriesCubit>(
              create: (_) => SuppourtedCountriesCubit(supportCountriesRepo)),
          BlocProvider<CurrencyConvertCubit>(
              create: (_) => CurrencyConvertCubit(convertRepo)),
          BlocProvider<InternetCubit>(
              create: (_) => InternetCubit(connectivity)),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
              title: 'Curruncy Converter',
              theme: ThemeData(primarySwatch: Colors.blue),
              home: const MyHomePage(title: 'Curruncy Converter'));
        }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    BlocProvider.of<SuppourtedCountriesCubit>(context).getSupportedCountries();
    super.initState();
  }

  TextEditingController amountTxtCtrl = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), centerTitle: true),
        body: BlocBuilder<SuppourtedCountriesCubit, SuppourtedCountriesState>(
            builder: (countryCtx, countrystate) {
          if (countrystate is SuppourtedCountriesLoadedState) {
            return SingleChildScrollView(
                child: Form(
                    key: _fromKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 25),
                              child: Text("Simple Curruncy Converter",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold))),
                          BlocBuilder<CurrencyConvertCubit,
                                  CurrencyConvertState>(
                              builder: (convertCtx, converstate) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _selectCountryWidget(countrystate),
                                  SizedBox(height: AppSize.s1_5.h),
                                  SizedBox(height: AppSize.s4.h),
                                  if (converstate is CurrencyConvertEror)
                                    Text(
                                        "* Error :${converstate.failure.message}",
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                                  if (converstate is CurrencyConvertLoaded)
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 25),
                                              child: Text(
                                                  "${(converstate.converterRatestModel.getAmountFor(countrystate.toCountry.toIso4017()) * double.parse(amountTxtCtrl.text)).toStringAsFixed(2)} ${countrystate.toCountry.isoCode}",
                                                  style: mediumTextStyle(
                                                          color: Colors.green)
                                                      .copyWith(fontSize: 35))),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 18),
                                              child: Text(
                                                  'Updated Date :${converstate.converterRatestModel.date.toIso8601String().substring(0, 10)}',
                                                  style: mediumTextStyle(
                                                          color: Colors.green)
                                                      .copyWith(fontSize: 18))),
                                        ]),
                                  (converstate is CurrencyConvertLoading)
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : SizedBox(
                                          width: 95.w,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                if (_fromKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  await BlocProvider.of<
                                                              CurrencyConvertCubit>(
                                                          context)
                                                      .getRates(countrystate
                                                          .fromCountry
                                                          .toIso4017());
                                                }
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  margin:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                                "Convert")),
                                                        Icon(Icons
                                                            .currency_exchange)
                                                      ]))),
                                        ),
                                ]);
                          })
                        ])));
          } else if (countrystate is SuppourtedCountriesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (countrystate is SuppourtedCountriesErrorState) {
            return Center(child: Text(countrystate.failure.message));
          } else if (countrystate is SuppourtedCountriesInitailState) {
            return const Center(child: Text('inital'));
          }
          return const SizedBox();
        }));
  }

  Widget _selectCountryWidget(SuppourtedCountriesState state) {
    if (state is SuppourtedCountriesLoadedState) {
      return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
              style: mediumTextStyle(color: Colors.green).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue),
              controller: amountTxtCtrl,
              inputFormatters: [
                FilteringTextInputFormatter.allow((RegExp(r'(^\d*\.?\d*)')))
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: AppSize.s25.w,
                      height: AppSize.s4.h,
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: (state.fromCountry),
                              isExpanded: true,
                              isDense: true,
                              icon: const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text('to')),
                              items: state.supportCountriesModel.countries
                                  .map((e) => _dropDownItem(e))
                                  .toList(),
                              onChanged: (CountryInfo? selectedCountry) async {
                                if (selectedCountry != null) {
                                  BlocProvider.of<SuppourtedCountriesCubit>(
                                          context)
                                      .setFirstCountry(selectedCountry);
                                  if (amountTxtCtrl.text.isNotEmpty) {
                                    await BlocProvider.of<CurrencyConvertCubit>(
                                            context)
                                        .getRates(selectedCountry.toIso4017());
                                  }
                                }
                              }))),
                  prefix: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: AppSize.s30.w,
                      height: AppSize.s4.h,
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: (state.toCountry),
                              isExpanded: true,
                              isDense: true,
                              icon: const Visibility(
                                  visible: true, child: SizedBox(width: 1)),
                              items: state.supportCountriesModel.countries
                                  .map((e) => _dropDownItem(e))
                                  .toList(),
                              onChanged: (CountryInfo? selectedCountry) {
                                if (selectedCountry != null) {
                                  BlocProvider.of<SuppourtedCountriesCubit>(
                                          context)
                                      .setSoucendCountry(selectedCountry);
                                }
                              }))),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
              validator: (s) {
                if (s == null || s.isEmpty) {
                  return 'reqired';
                }
                return null;
              },
              onEditingComplete: () async {
                await BlocProvider.of<CurrencyConvertCubit>(context)
                    .getRates(state.fromCountry.toIso4017());
              },
              onFieldSubmitted: (_) async {
                await BlocProvider.of<CurrencyConvertCubit>(context)
                    .getRates(state.fromCountry.toIso4017());
              }));
    }
    return const SizedBox();
  }

  DropdownMenuItem<CountryInfo> _dropDownItem(CountryInfo e) {
    return DropdownMenuItem<CountryInfo>(
        value: e,
        child: Row(children: [
          CachedNetworkImage(
              height: 25,
              width: 25,
              imageUrl: getFlagByIsoCode(e.isoCode, 20),
              fit: BoxFit.contain,
              errorWidget: (_, s, d) => const Icon(Icons.flag)),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(e.isoCode.toUpperCase(),
                      style: const TextStyle(
                          overflow: TextOverflow.fade,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15))))
        ]));
  }
}
