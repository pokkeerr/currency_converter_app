import 'package:currency_converter_app/data/constans/app_const.dart';
import 'package:currency_converter_app/data/models/convert_resulte_model.dart';
import 'package:currency_converter_app/data/network/dio/dio_client.dart';
import 'package:currency_converter_app/data/network/dio/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../helpers/logger.dart';
import '../constans/app_apis.dart';
import '../models/convert_rates_model.dart';
import '../models/currencyconverter_model.dart';
import '../network/dio/error_handler.dart';

class CurrencyConvertRepo {
  static CurrencyConvertRepo instance(DioClient api) =>
      CurrencyConvertRepo(api);
  CurrencyConvertRepo(this.api);
  final DioClient api;

  Future<Either<Failure, ConverterResultModel>> convertByRapidapi(
      String fromCountryIsoCode, String toCountryIsoCode, String amount) async {
    final url =
        '${AppApis.Rapidapi_CONVERTER_BASE_URL}/currency/convert?format=json&from=$fromCountryIsoCode&to=$toCountryIsoCode&amount=$amount';
    api.updateHeader(andHeaders: AppConst.RAPIDAPI_HEADERS);

    late Response res;
    try {
      res = await api.get(url);
      if (res.statusCode == 200) {
        return Right(ConverterResultModel.fromJson(res.data));
      } else {
        return Left(Failure(
            code: res.statusCode!,
            message: res.data['message'],
            status: res.data['status']));
      }
    } catch (e) {
      Log.red('Erorr >>>> CurrencyConvertRepo.convertByRapidapi :$e');
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  // Future<Either<Failure, CurrencyconverterModel>> convertFromCurrencyConverter(
  //     String fromCountryIsoCode, String toCountryIsoCode, String amount) async {
  //   final url =
  //       '${AppApis.currencyconverterapi_BASE_URL}${fromCountryIsoCode.toUpperCase()}_${toCountryIsoCode.toUpperCase()},${toCountryIsoCode.toUpperCase()}_${fromCountryIsoCode.toUpperCase()}&compact=ultra&apiKey=${AppConst.currencyconverterapi_API_KEY}';

  //   late Response res;
  //   try {
  //     res = await api.get(url);
  //     if (res.statusCode == 200) {
  //       return Right(CurrencyconverterModel.fromMap(res.data));
  //     } else {
  //       return Left(Failure(
  //           code: res.statusCode!,
  //           message:
  //               res.data['message'] ?? "errrrorrr convertFromCurrencyConverter",
  //           status: res.data['status'] ?? res.statusCode));
  //     }
  //   } catch (e) {
  //     Log.red(
  //         'Erorr >>>> CurrencyConvertRepo.convertFromCurrencyConverter :$e');
  //     return Left(ErrorHandler.handle(e).failure);
  //   }
  // }

  Future<Either<Failure, CurrencyWeeklyconverterModel>>
      convertFromCurrencyConverterWeekly(String fromCountryIsoCode,
          String toCountryIsoCode, String amount) async {
    final date = DateTime.now();
    final fDate = date.toString().split(' ').first;
    final lDate =
        date.subtract(const Duration(days: 7)).toString().split(' ').first;
    final url =
        '${AppApis.currencyconverterapi_BASE_URL}${fromCountryIsoCode.toUpperCase()}_${toCountryIsoCode.toUpperCase()},${toCountryIsoCode.toUpperCase()}_${fromCountryIsoCode.toUpperCase()}&compact=ultra&date=$lDate&endDate=$fDate&apiKey=${AppConst.currencyconverterapi_API_KEY}';
    Log.green(url);
    late Response res;
    try {
      res = await api.get(url.trim());
      if (res.statusCode == 200) {
        return Right(CurrencyWeeklyconverterModel.fromMap(res.data));
      } else {
        return Left(Failure(
            code: res.statusCode!,
            message:
                res.data['message'] ?? "errrrorrr CurrencyWeeklyconverterModel",
            status: res.data['status'] ?? res.statusCode));
      }
    } catch (e) {
      Log.red(
          'Erorr >>>> CurrencyConvertRepo.convertFromCurrencyConverter :$e');
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ConverterRatesModel>> convertAndGetRates(
      String fromCountryIsoCode) async {
    final url = '${AppApis.CONVERTER_RATES_BASE_URL}$fromCountryIsoCode';

    late Response res;
    try {
      res = await api.get(url);
      if (res.statusCode == 200) {
        return Right(ConverterRatesModel.fromJson(res.data));
      } else {
        return Left(Failure(
            code: res.statusCode!,
            message: res.data['message'],
            status: res.data['status']));
      }
    } catch (e) {
      Log.red('Erorr >>>> CurrencyConvertRepo.convertAndGetRates :$e');
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
