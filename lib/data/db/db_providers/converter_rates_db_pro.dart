import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../helpers/logger.dart';
import '../../models/convert_rates_model.dart';
import '../../network/dio/failure.dart';

class ConverterRatestDBModelProvider {
  final Database db;
  ConverterRatestDBModelProvider(this.db);

  static String ratesTable = 'ratesTable';
  static String columnId = 'id';
  static String columnRates = 'rates';
  static String columndate = 'date';
  static String columnbase = 'base';
  static String columnAmount = 'amount';

  Future<void> careteTable() async {
    await db.execute('''
  create table $ratesTable ( 
  $columnId integer primary key, 
  $columnRates text not null,
  $columndate text not null,
  $columnbase text not null,
  $columnAmount real not null)
  ''');
  }

  Future<void> insert(
      ConverterRatesModel converterRatestModel, double amount) async {
    try {
      await db.insert(ratesTable, converterRatestModel.toDBMap(amount));
    } catch (e) {
      Log.red(
          'ConverterRatestDBModelProvider : Faild to Insert into $ratesTable $e');
    }
  }

  Future<Either<Failure, ConverterRatesModel>> getConverterRates(
      double amount) async {
    List<Map> maps = await db.query(ratesTable,
        columns: [columnId, columnRates, columndate, columnbase],
        where: '$columnAmount = ?',
        whereArgs: [amount]);
    if (maps.isNotEmpty) {
      return Right(ConverterRatesModel.fromDBMap(maps.last));
    }
    return left(Failure(code: 0, message: "no data found for amount $amount"));
  }

  Future<int> delete(int id) async {
    return await db.delete(ratesTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(
      ConverterRatesModel converterRatestModel, double amount) async {
    return await db.update(ratesTable, converterRatestModel.toDBMap(amount),
        where: '$columnId = ?',
        whereArgs: [converterRatestModel.date.millisecondsSinceEpoch]);
  }

  Future close() async => db.close();
}
