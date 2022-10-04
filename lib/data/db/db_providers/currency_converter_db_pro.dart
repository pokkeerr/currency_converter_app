import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../helpers/logger.dart';
import '../../models/currencyconverter_model.dart';
import '../../network/dio/failure.dart';

class CurrencyWeeklyConverterDBModelProvider {
  final Database db;
  CurrencyWeeklyConverterDBModelProvider(this.db);

  static String currencyconverterTable = 'currencyWeeklyconverterTable';
  static String columnId = 'id';
  static String columnResulte = 'rates';
  static String columnAmount = 'amount';
  static String columnfromTo = 'fromTo';
  static String columnToFrom = 'ToFrom';

  Future<void> careteTable() async {
    await db.execute('''
  create table $currencyconverterTable ( 
  $columnId integer primary key, 
  $columnResulte text not null,
  $columnAmount real not null,
  $columnfromTo text not null,
  $columnToFrom text not null )
  ''');
  }

  Future<void> insert(CurrencyWeeklyconverterModel currenWeeklyCyconverterModel,
      double amount, String fromTo, String toFrom) async {
    try {
      await db.insert(currencyconverterTable,
          currenWeeklyCyconverterModel.toDBMap(amount, fromTo, toFrom));
    } catch (e) {
      Log.red(
          'CurrencyWeeklyConverterDBModelProvider : Faild to Insert into $currencyconverterTable $e');
    }
  }

  Future<Either<Failure, CurrencyWeeklyconverterModel>>
      getCurrencyWeeklyconverter(
          double amount, String fromTo, String toFrom) async {
    List<Map> maps = await db.query(currencyconverterTable,
        columns: [columnId, columnResulte],
        where: '$columnAmount = ?, $columnfromTo = ?, $columnToFrom',
        whereArgs: [amount, fromTo, toFrom]);
    if (maps.isNotEmpty) {
      return Right(CurrencyWeeklyconverterModel.froDBmMap(maps.last));
    }
    return Left(Failure(code: 0, message: "no data found for $fromTo"));
  }

  Future<int> delete(int id) async {
    return await db.delete(currencyconverterTable,
        where: '$columnId = ?', whereArgs: [id]);
  }

  // Future<int> update(CurrencyconverterModel currencyconverterModel) async {
  //   return await db.update(ratesTable, currencyconverterModel.toDBMap(),
  //       where: '$columnId = ?',
  //       whereArgs: [currencyconverterModel.date.millisecondsSinceEpoch]);
  // }

  Future close() async => db.close();
}
