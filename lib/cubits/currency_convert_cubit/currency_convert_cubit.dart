import 'dart:async';

import 'package:currency_converter_app/cubits/internet_connection/internet_connection_cubit.dart';
import 'package:currency_converter_app/data/models/convert_rates_model.dart';
import 'package:currency_converter_app/data/network/dio/failure.dart';
import 'package:currency_converter_app/data/repos/currency_convert_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/db/currency_convert_db.dart';
import '../../data/models/currencyconverter_model.dart';
part 'currency_convert_state.dart';

class CurrencyConvertCubit extends Cubit<CurrencyConvertState> {
  final CurrencyConvertRepo currencyConvertRepo;
  final CurrencyConverterDB db;
  final InternetCubit internetCubit;
  CurrencyConvertCubit(this.currencyConvertRepo, this.db, this.internetCubit)
      : super(CurrencyConvertInitial());

  Future<void> convert(
    String fromCountryIsoCode,
    String toCountryIsoCode,
    String amount,
  ) async {
    emit(CurrencyConvertLoading());
    final fromTo =
        '${fromCountryIsoCode.toUpperCase()}_${toCountryIsoCode.toUpperCase()}';
    final toFrom =
        '${toCountryIsoCode.toUpperCase()}_${fromCountryIsoCode.toUpperCase()}';
    if (internetCubit.state is InternetDisconnectedState) {
      final resConvertFromCurrencyConverter = await db.converterDBModelProvider!
          .getCurrencyWeeklyconverter(double.parse(amount), fromTo, toFrom);
      final resGetRates =
          await db.converterRatest!.getConverterRates(double.parse(amount));
      resConvertFromCurrencyConverter.fold((l) {
        emit(CurrencyConvertEror(l));
      }, (rr) {
        resGetRates.fold((l) {
          emit(CurrencyConvertEror(l));
        }, (r) {
          emit(CurrencyConvertLoaded(r, rr));
        });
      });
    } else {
      // final resConvertFromCurrencyConverter =
      //     await currencyConvertRepo.convertFromCurrencyConverter(
      //         fromCountryIsoCode, toCountryIsoCode, amount);
      final resConvertFromCurrencyConverterWeekly =
          await currencyConvertRepo.convertFromCurrencyConverterWeekly(
              fromCountryIsoCode, toCountryIsoCode, amount);
      final resGetRates =
          await currencyConvertRepo.convertAndGetRates(fromCountryIsoCode);
      resConvertFromCurrencyConverterWeekly.fold((l) {
        emit(CurrencyConvertEror(l));
      }, (rr) {
        db.converterDBModelProvider
            ?.insert(rr, double.parse(amount), fromTo, toFrom);
        resGetRates.fold((l) {
          emit(CurrencyConvertEror(l));
        }, (r) {
          db.converterRatest?.insert(r, double.parse(amount));
          emit(CurrencyConvertLoaded(r, rr));
        });
      });
    }
  }
}
