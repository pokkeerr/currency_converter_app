import 'package:currency_converter_app/data/constans/app_apis.dart';

String getFlagByIsoCode(String countryCode, int size) {
  return '${AppApis.FLAG_BASR_URL}w$size/$countryCode.jpg';
}
