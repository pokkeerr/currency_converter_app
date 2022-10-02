import 'package:currency_converter_app/data/models/support_countries_model.dart';
import 'package:currency_converter_app/data/network/dio/failure.dart';
import 'package:equatable/equatable.dart';

abstract class SuppourtedCountriesState extends Equatable {
  const SuppourtedCountriesState();

  @override
  List<Object> get props => [];
}

class SuppourtedCountriesInitailState extends SuppourtedCountriesState {}

class SuppourtedCountriesLoadingState extends SuppourtedCountriesState {}

class SuppourtedCountriesLoadedState extends SuppourtedCountriesState {
  final SupportCountriesModel supportCountriesModel;
  final CountryInfo fromCountry;
  final CountryInfo toCountry;
  const SuppourtedCountriesLoadedState(
      this.supportCountriesModel, this.fromCountry, this.toCountry);
  @override
  List<Object> get props => [supportCountriesModel, fromCountry, toCountry];
}

class SuppourtedCountriesErrorState extends SuppourtedCountriesState {
  final Failure failure;
  const SuppourtedCountriesErrorState(this.failure);
  @override
  List<Object> get props => [failure];
}
