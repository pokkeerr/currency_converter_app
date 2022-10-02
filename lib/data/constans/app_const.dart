// ignore_for_file: constant_identifier_names

class AppConst {
  static const String HttpHeaderContentType = 'application/json';
  static const String HttpHeaderMediaContentType = 'multipart/form-data';

  static const String RAPIDAPI_HttpHeader_Host_NAME = 'X-RapidAPI-Host';
  static const String RAPIDAPI_HttpHeader_APIKEY_NAME = 'X-RapidAPI-Key';
  static const String RAPIDAPI_HttpHeader_Host =
      'currency-converter5.p.rapidapi.com';
  static const String RAPIDAPI_CURRENCY_CONVERTER_API_KEY =
      'ab295582edmsh561ec3af3f364c4p1864c1jsn94ec3118ff0a';

  static const Map<String, String> RAPIDAPI_HEADERS = {
    RAPIDAPI_HttpHeader_APIKEY_NAME: RAPIDAPI_CURRENCY_CONVERTER_API_KEY,
    RAPIDAPI_HttpHeader_Host_NAME: RAPIDAPI_HttpHeader_Host
  };

  //internet optins
  static int connectTimeout = 60000;
  static int receiveTimeout = 60000;
}
