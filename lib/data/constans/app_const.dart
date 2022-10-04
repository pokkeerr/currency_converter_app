// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class AppConst {
  static const String HttpHeaderContentType = 'application/json';
  static const String HttpHeaderMediaContentType = 'multipart/form-data';

  //RapidAPI
  static const String RAPIDAPI_HttpHeader_Host_NAME = 'X-RapidAPI-Host';
  static const String RAPIDAPI_HttpHeader_APIKEY_NAME = 'X-RapidAPI-Key';
  static const String RAPIDAPI_HttpHeader_Host =
      'currency-converter5.p.rapidapi.com';
  static const Map<String, String> RAPIDAPI_HEADERS = {
    RAPIDAPI_HttpHeader_APIKEY_NAME: RAPIDAPI_CURRENCY_CONVERTER_API_KEY,
    RAPIDAPI_HttpHeader_Host_NAME: RAPIDAPI_HttpHeader_Host
  };

  //https://api.exchangerate-api.com/
  static const String RAPIDAPI_CURRENCY_CONVERTER_API_KEY =
      'ab295582edmsh561ec3af3f364c4p1864c1jsn94ec3118ff0a';

  //https://www.currencyconverterapi.com/
  static const String currencyconverterapi_API_KEY = '57e467c3ed10d6efbe95';

//database
  static String DB_Name = 'currency_convert3.db';
  static int DB_Verstion = 1;

  //internet optins
  static int connectTimeout = 60000;
  static int receiveTimeout = 60000;
}
