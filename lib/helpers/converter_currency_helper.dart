import '../data/constans/app_apis.dart';

class CurrencyConveterHelper {
  static String getConverterUrl(
      String fromCountryIsoCode, String toCountryIsoCode, int amount) {
    return '${AppApis.CONVERTER_BASE_URL}/currency/convert?format=json&from=$fromCountryIsoCode&to=$toCountryIsoCode&amount=$amount';
  }
}
