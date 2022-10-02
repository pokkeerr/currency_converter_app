import 'package:currency_converter_app/data/models/support_countries_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/support_countreis_repo.dart';
import 'suppourted_countries_state.dart';

class SuppourtedCountriesCubit extends Cubit<SuppourtedCountriesState> {
  final SupportCountriesRepo supportCountriesRepo;
  SuppourtedCountriesCubit(this.supportCountriesRepo)
      : super(SuppourtedCountriesInitailState());
  SupportCountriesModel? supportCountriesModel;
  CountryInfo? fromCountry;
  CountryInfo? toCountry;
  Future<void> getSupportedCountries() async {
    emit(SuppourtedCountriesLoadingState());
    final suported = await SupportCountriesRepo().getAllCountriesFromWeb();
    suported.fold((l) {
      emit(SuppourtedCountriesErrorState(l));
    }, (r) {
      fromCountry = r.countries.first;
      toCountry = r.countries.last;
      supportCountriesModel = r;
      emit(SuppourtedCountriesLoadedState(
          r, r.countries.first, r.countries.last));
    });
  }

  void setFirstCountry(CountryInfo c) {
    if (state is SuppourtedCountriesLoadedState) {
      fromCountry = c;
      emit(SuppourtedCountriesLoadedState(
          supportCountriesModel!, c, toCountry!));
    }
  }

  void setSoucendCountry(CountryInfo c) {
    if (state is SuppourtedCountriesLoadedState) {
      toCountry = c;
      emit(SuppourtedCountriesLoadedState(
          supportCountriesModel!, fromCountry!, c));
    }
  }
}
