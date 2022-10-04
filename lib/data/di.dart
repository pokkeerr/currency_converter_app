import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_converter_app/cubits/internet_connection/internet_connection_cubit.dart';
import 'package:currency_converter_app/data/db/currency_convert_db.dart';
import 'package:currency_converter_app/data/network/dio/dio_client.dart';
import 'package:currency_converter_app/data/repos/currency_convert_repo.dart';
import 'package:currency_converter_app/data/repos/support_countreis_repo.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> initDI() async {
  di.registerLazySingleton<DioClient>(() => DioClient.instance);
  di.registerLazySingleton<Connectivity>(() => Connectivity());
  di.registerLazySingleton<CurrencyConvertRepo>(
      () => CurrencyConvertRepo(di<DioClient>()));
  di.registerLazySingleton<SupportCountriesRepo>(
      () => SupportCountriesRepo(di<DioClient>()));
  di.registerLazySingleton<CurrencyConverterDB>(
      () => CurrencyConverterDB.instance);

  di.registerLazySingleton<InternetCubit>(
      () => InternetCubit(di<Connectivity>()));
  await di<CurrencyConverterDB>().database;
}
