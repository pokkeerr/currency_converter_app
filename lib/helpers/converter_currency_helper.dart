import '../data/constans/app_apis.dart';

String getConverterRapidapiUrl(
    String fromCountryIsoCode, String toCountryIsoCode, int amount) {
  return '${AppApis.Rapidapi_CONVERTER_BASE_URL}/currency/convert?format=json&from=$fromCountryIsoCode&to=$toCountryIsoCode&amount=$amount';
}
