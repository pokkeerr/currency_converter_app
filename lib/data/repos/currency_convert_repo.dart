import 'package:currency_converter_app/data/constans/app_const.dart';
import 'package:currency_converter_app/data/models/convert_resulte_model.dart';
import 'package:currency_converter_app/data/network/dio/dio_client.dart';
import 'package:currency_converter_app/data/network/dio/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../helpers/logger.dart';
import '../constans/app_apis.dart';
import '../models/convert_rates_model.dart';
import '../network/dio/error_handler.dart';

class CurrencyConvertRepo {
  final DioClient api = DioClient.instance;

  Future<Either<Failure, ConverterResultModel>> convert(
      String fromCountryIsoCode, String toCountryIsoCode, String amount) async {
    final url =
        '${AppApis.CONVERTER_BASE_URL}/currency/convert?format=json&from=$fromCountryIsoCode&to=$toCountryIsoCode&amount=$amount';
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
      Log.red('Erorr >>>> AdsRepo.getAds :$e');
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  Future<Either<Failure, ConverterRatestModel>> getRates(
      String fromCountryIsoCode) async {
    final url = '${AppApis.CONVERTER_RATES_BASE_URL}$fromCountryIsoCode';

    late Response res;
    try {
      res = await api.get(url);
      if (res.statusCode == 200) {
        return Right(ConverterRatestModel.fromJson(res.data));
      } else {
        return Left(Failure(
            code: res.statusCode!,
            message: res.data['message'],
            status: res.data['status']));
      }
    } catch (e) {
      Log.red('Erorr >>>> AdsRepo.getAds :$e');
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
