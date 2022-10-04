part of 'currency_convert_cubit.dart';

abstract class CurrencyConvertState extends Equatable {
  const CurrencyConvertState();

  @override
  List<Object> get props => [];
}

class CurrencyConvertInitial extends CurrencyConvertState {}

class CurrencyConvertLoading extends CurrencyConvertState {}

class CurrencyConvertLoadFromCurrncyConverter extends CurrencyConvertState {
  // final CurrencyconverterModel currencyconverterModel;
  final CurrencyWeeklyconverterModel currencyWeeklyconverterModel;

  const CurrencyConvertLoadFromCurrncyConverter(
      this.currencyWeeklyconverterModel);
  @override
  List<Object> get props => [currencyWeeklyconverterModel];
}

class CurrencyConvertLoaedFromRatesConverter extends CurrencyConvertState {
  final ConverterRatesModel converterRatestModel;

  const CurrencyConvertLoaedFromRatesConverter(this.converterRatestModel);
  @override
  List<Object> get props => [converterRatestModel];
}

class CurrencyConvertLoaded extends CurrencyConvertState {
  // final ConverterResultModel? converterResultModel;

  // const CurrencyConvertLoaded(this.converterResultModel);
  final ConverterRatesModel converterRatestModel;
  // final CurrencyconverterModel currencyconverterModel;
  final CurrencyWeeklyconverterModel currencyWeeklyconverterModel;
  const CurrencyConvertLoaded(
    this.converterRatestModel,
    this.currencyWeeklyconverterModel,
  );
  @override
  List<Object> get props =>
      [converterRatestModel, currencyWeeklyconverterModel];
}

class CurrencyConvertEror extends CurrencyConvertState {
  final Failure failure;

  const CurrencyConvertEror(this.failure);
  @override
  List<Object> get props => [failure];
}
