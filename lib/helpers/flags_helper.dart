import 'package:currency_converter_app/data/constans/app_apis.dart';

class CountriesFlagMgr {
  static String getFlag(String countryCode, int size) {
    return '${AppApis.FLAG_BASR_URL}/$size/$countryCode.jpg';
  }
}
