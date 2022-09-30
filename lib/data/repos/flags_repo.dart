import 'package:currency_converter_app/data/constans/app_apis.dart';
import 'package:currency_converter_app/data/models/countries_flags_model.dart';
import 'package:currency_converter_app/data/network/dio/dio_client.dart';
import 'package:currency_converter_app/data/network/dio/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../helpers/logger.dart';
import '../network/dio/error_handler.dart';

class FlagsRepo {
  static DioClient api = DioClient.instance;

  static Future<Either<Failure, CountryFlagsModel>> getAllCountries() async {
    late Response res;
    try {
      res = await api.get(AppApis.ALL_COUNTRY_FLAGS);
      if (res.statusCode == 200) {
        return Right(CountryFlagsModel.fromJson(res.data));
      } else {
        return Left(Failure(
            code: res.statusCode,
            message: res.data['message'],
            status: res.data['status']));
      }
    } catch (e) {
      Log.red('Erorr >>>> AdsRepo.getAds :$e');
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
