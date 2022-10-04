import 'package:currency_converter_app/data/constans/app_const.dart';

import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import 'db_providers/converter_rates_db_pro.dart';
import 'db_providers/converyer_res_db_pro.dart';
import 'db_providers/currency_converter_db_pro.dart';
import 'db_providers/suppourted_countries_db_pro.dart';

class CurrencyConverterDB {
  static final CurrencyConverterDB instance = CurrencyConverterDB._init();
  ConverterRatestDBModelProvider? converterRatest;
  ConverterResulDBModelProvider? converterResult;
  // CurrencyconverterDBModelProvider? currencyconverter;
  CurrencyWeeklyConverterDBModelProvider? converterDBModelProvider;
  SupportCountriesDBModelProvider? supportCountries;
  static Database? _database;

  CurrencyConverterDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    converterRatest = ConverterRatestDBModelProvider(_database!);
    converterResult = ConverterResulDBModelProvider(_database!);
    converterDBModelProvider =
        CurrencyWeeklyConverterDBModelProvider(_database!);
    supportCountries = SupportCountriesDBModelProvider(_database!);
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), AppConst.DB_Name);
    return await openDatabase(path,
        version: AppConst.DB_Verstion, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await ConverterRatestDBModelProvider(db).careteTable();
    await ConverterResulDBModelProvider(db).careteTable();
    // await CurrencyconverterDBModelProvider(db).careteTable();
    CurrencyWeeklyConverterDBModelProvider(db).careteTable();
    await SupportCountriesDBModelProvider(db).careteTable();
  }
}
