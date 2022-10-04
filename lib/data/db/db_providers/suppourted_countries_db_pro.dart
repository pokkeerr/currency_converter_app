import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../helpers/logger.dart';
import '../../models/support_countries_model.dart';
import '../../network/dio/failure.dart';

class SupportCountriesDBModelProvider {
  final Database db;
  SupportCountriesDBModelProvider(this.db);

  static String countriesTable = 'countriesTable';
  static String columnId = 'id';
  static String columnCountries = 'countries';

  Future<void> careteTable() async {
    await db.execute('''
  create table $countriesTable ( 
  $columnId integer primary key, 
  $columnCountries text not null )
  ''');
  }

  Future<void> insert(SupportCountriesModel supportCountriesModel) async {
    try {
      await db.insert(countriesTable, supportCountriesModel.toDBMap());
    } catch (e) {
      Log.red(
          'SupportCountriesDBModelProvider : Faild to Insert into $countriesTable : $e');
    }
  }

  Future<Either<Failure, SupportCountriesModel>> getCurrencyconverter(
      int id) async {
    List<Map> maps =
        await db.query(countriesTable, columns: [columnId, columnCountries]);
    if (maps.isNotEmpty) {
      return Right(SupportCountriesModel.fromDBMap(maps.first));
    }
    return Left(Failure(code: 1, message: "no data found"));
  }

  Future<int> delete(int id) async {
    return await db
        .delete(countriesTable, where: '$columnId = ?', whereArgs: [id]);
  }

  // Future<int> update(CurrencyconverterModel currencyconverterModel) async {
  //   return await db.update(ratesTable, currencyconverterModel.toDBMap(),
  //       where: '$columnId = ?',
  //       whereArgs: [currencyconverterModel.date.millisecondsSinceEpoch]);
  // }

  Future close() async => db.close();
}
