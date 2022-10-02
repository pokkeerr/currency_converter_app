part of 'currency_convert_cubit.dart';

abstract class CurrencyConvertState extends Equatable {
  const CurrencyConvertState();

  @override
  List<Object> get props => [];
}

class CurrencyConvertInitial extends CurrencyConvertState {}

class CurrencyConvertLoading extends CurrencyConvertState {}

class CurrencyConvertLoaded extends CurrencyConvertState {
  // final ConverterResultModel? converterResultModel;

  // const CurrencyConvertLoaded(this.converterResultModel);
  final ConverterRatestModel converterRatestModel;

  const CurrencyConvertLoaded(this.converterRatestModel);
  @override
  List<Object> get props => [converterRatestModel];
}

class CurrencyConvertEror extends CurrencyConvertState {
  final Failure failure;

  const CurrencyConvertEror(this.failure);
  @override
  List<Object> get props => [failure];
}
