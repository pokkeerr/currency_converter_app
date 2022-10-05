import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter_app/data/resources/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../cubits/currency_convert_cubit/currency_convert_cubit.dart';
import '../../cubits/internet_connection/internet_connection_cubit.dart';
import '../../cubits/supoort_countries_cubit/suppourted_countries_cubit.dart';
import '../../cubits/supoort_countries_cubit/suppourted_countries_state.dart';
import '../../data/models/convert_rates_model.dart';
import '../../data/models/currencyconverter_model.dart';
import '../../data/models/support_countries_model.dart';
import '../../data/resources/styles_manager.dart';
import '../../data/resources/values_manager.dart';
import '../../helpers/flags_helper.dart';
import '../widigets/convert_rates_widget.dart';
import '../widigets/convert_res_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController amountTxtCtrl = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  void initState() {
    BlocProvider.of<SuppourtedCountriesCubit>(context).getSupportedCountries();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<InternetCubit>(context).cencelStrem();
    amountTxtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('Curruncy Converter'), centerTitle: true),
        body: BlocBuilder<InternetCubit, InternetState>(
            builder: (context, internetState) {
          return BlocBuilder<SuppourtedCountriesCubit,
              SuppourtedCountriesState>(builder: (countryCtx, countrystate) {
            if (countrystate is SuppourtedCountriesLoadedState) {
              return SingleChildScrollView(
                  child: Form(
                      key: _fromKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            internetState is InternetConnectedState
                                ? SizedBox(height: 5.h)
                                : _noInternetConnection(),
                            _contantBody(countrystate, context)
                          ])));
            } else if (countrystate is SuppourtedCountriesLoadingState ||
                countrystate is SuppourtedCountriesInitailState) {
              return const Center(child: CircularProgressIndicator());
            } else if (countrystate is SuppourtedCountriesErrorState) {
              if (internetState is InternetDisconnectedState) {
                return Center(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                      Icon(Icons.wifi_off, size: 30.h, color: Colors.grey),
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("You Have To check your connection",
                              style: TextStyle(
                                  fontSize: FontSizeMgr.s32,
                                  color: Colors.black)))
                    ])));
              } else {
                return Center(child: Text(countrystate.failure.message));
              }
            }
            return const SizedBox();
          });
        }));
  }

  BlocBuilder<CurrencyConvertCubit, CurrencyConvertState> _contantBody(
      SuppourtedCountriesLoadedState countrystate, BuildContext context) {
    return BlocBuilder<CurrencyConvertCubit, CurrencyConvertState>(
        builder: (convertCtx, converstate) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _selectCountryWidget(countrystate),
            SizedBox(height: AppSize.s1_5.h),
            (converstate is CurrencyConvertLoading)
                ? const Center(child: CircularProgressIndicator())
                : _convertButton(context, countrystate),
            SizedBox(height: AppSize.s4.h),
            if (converstate is CurrencyConvertEror)
              Text("* Error :${converstate.failure.message}",
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            _loadFromConvertAndRaets(converstate, countrystate)
          ]);
    });
  }

  Container _noInternetConnection() {
    return Container(
        color: Colors.red,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("No internet conection!",
                  style: TextStyle(fontSize: 15, color: Colors.white))
            ]));
  }

  Widget _convertButton(
      BuildContext context, SuppourtedCountriesLoadedState countrystate) {
    return SizedBox(
        width: 95.w,
        child: ElevatedButton(
            onPressed: () async {
              if (_fromKey.currentState?.validate() ?? false) {
                if (amountTxtCtrl.text.isNotEmpty) {
                  await BlocProvider.of<CurrencyConvertCubit>(context).convert(
                      countrystate.fromCountry.fromIso3166ToIso4017(),
                      countrystate.toCountry.fromIso3166ToIso4017(),
                      amountTxtCtrl.text);
                }
              }
            },
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                          padding: EdgeInsets.all(8.0), child: Text("Convert")),
                      Icon(Icons.currency_exchange)
                    ]))));
  }

  Widget _loadFromConvertAndRaets(CurrencyConvertState converstate,
      SuppourtedCountriesLoadedState countrystate) {
    if (converstate is CurrencyConvertLoaded) {
      return Column(children: [
        _loadfromConvert(
            converstate.currencyWeeklyconverterModel, countrystate),
        Divider(height: 5.h, color: Colors.blue),
        _loadfromfromRates(converstate.converterRatestModel, countrystate),
      ]);
    } else if (converstate is CurrencyConvertLoadFromCurrncyConverter) {
      return _loadfromConvert(
          converstate.currencyWeeklyconverterModel, countrystate);
    } else if (converstate is CurrencyConvertLoaedFromRatesConverter) {
      return _loadfromfromRates(converstate.converterRatestModel, countrystate);
    } else {
      return const SizedBox();
    }
  }

  Widget _loadfromConvert(
      CurrencyWeeklyconverterModel currencyWeeklyconverterModel,
      SuppourtedCountriesLoadedState countrystate) {
    return Column(children: [
      const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("free.currconv.com Converter",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.bold))),
      ConvertResulteWidget(
          amount:
              amountTxtCtrl.text.isEmpty ? 0 : double.parse(amountTxtCtrl.text),
          currencyconverterModel: currencyWeeklyconverterModel,
          countrystate: countrystate),
    ]);
  }

  Widget _loadfromfromRates(ConverterRatesModel converterRatesModel,
      SuppourtedCountriesLoadedState countrystate) {
    return Column(children: [
      ConvertAllRates(
          amount:
              amountTxtCtrl.text.isEmpty ? 0 : double.parse(amountTxtCtrl.text),
          converterRatesModel: converterRatesModel,
          countrystate: countrystate)
    ]);
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
                      width: AppSize.s20.w,
                      height: 3.h,
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: (state.fromCountry),
                              isExpanded: true,
                              isDense: true,
                              icon: const Text(''),
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
                                        .convert(
                                            selectedCountry
                                                .fromIso3166ToIso4017(),
                                            state.toCountry
                                                .fromIso3166ToIso4017(),
                                            amountTxtCtrl.text);
                                  }
                                }
                              }))),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('To',
                          style: mediumTextStyle(color: Colors.blue)
                              .copyWith(fontSize: 14)),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          width: AppSize.s20.w,
                          height: 2.h,
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
                                  onChanged:
                                      (CountryInfo? selectedCountry) async {
                                    if (selectedCountry != null) {
                                      BlocProvider.of<SuppourtedCountriesCubit>(
                                              context)
                                          .setSoucendCountry(selectedCountry);
                                      if (amountTxtCtrl.text.isNotEmpty) {
                                        await BlocProvider.of<
                                                CurrencyConvertCubit>(context)
                                            .convert(
                                                state.fromCountry
                                                    .fromIso3166ToIso4017(),
                                                selectedCountry
                                                    .fromIso3166ToIso4017(),
                                                amountTxtCtrl.text);
                                      }
                                    }
                                  }))),
                    ],
                  ),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
              validator: (s) {
                if (s == null || s.isEmpty) {
                  return 'reqired';
                }
                return null;
              },
              onEditingComplete: () async {
                if (amountTxtCtrl.text.isNotEmpty) {
                  await BlocProvider.of<CurrencyConvertCubit>(context).convert(
                      state.fromCountry.fromIso3166ToIso4017(),
                      state.toCountry.fromIso3166ToIso4017(),
                      amountTxtCtrl.text);
                }
              },
              onFieldSubmitted: (_) async {
                if (amountTxtCtrl.text.isNotEmpty) {
                  await BlocProvider.of<CurrencyConvertCubit>(context).convert(
                      state.fromCountry.fromIso3166ToIso4017(),
                      state.toCountry.fromIso3166ToIso4017(),
                      amountTxtCtrl.text);
                }
              }));
    }
    return const SizedBox();
  }

  DropdownMenuItem<CountryInfo> _dropDownItem(CountryInfo e) {
    return DropdownMenuItem<CountryInfo>(
        value: e,
        child: Row(children: [
          CachedNetworkImage(
              height: AppSize.s25,
              width: AppSize.s25,
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
