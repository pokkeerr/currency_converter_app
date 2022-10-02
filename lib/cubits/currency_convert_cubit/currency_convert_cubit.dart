import 'package:currency_converter_app/data/models/convert_rates_model.dart';
import 'package:currency_converter_app/data/network/dio/failure.dart';
import 'package:currency_converter_app/data/repos/currency_convert_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'currency_convert_state.dart';

class CurrencyConvertCubit extends Cubit<CurrencyConvertState> {
  final CurrencyConvertRepo currencyConvertRepo;
  CurrencyConvertCubit(this.currencyConvertRepo)
      : super(CurrencyConvertInitial());

  // Future<void> convert(
  //     String fromCountryIsoCode, String toCountryIsoCode, String amount) async {
  //   emit(CurrencyConvertLoading());
  //   final res = await currencyConvertRepo.convert(
  //       fromCountryIsoCode, toCountryIsoCode, amount);
  //   res.fold((l) {
  //     emit(CurrencyConvertEror(l));
  //   }, (r) {
  //     emit(CurrencyConvertLoaded(r));
  //   });
  // }

  Future<void> getRates(String fromCountryIsoCode) async {
    emit(CurrencyConvertLoading());
    final res = await currencyConvertRepo.getRates(fromCountryIsoCode);
    res.fold((l) {
      emit(CurrencyConvertEror(l));
    }, (r) {
      emit(CurrencyConvertLoaded(r));
    });
  }
}
