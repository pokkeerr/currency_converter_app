import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../helpers/logger.dart';
import '../../models/convert_resulte_model.dart';
import '../../network/dio/failure.dart';

class ConverterResulDBModelProvider {
  final Database db;
  ConverterResulDBModelProvider(this.db);

  static String converterResultTable = 'converterResult';
  static String columnId = 'id';
  static String columnamount = 'amount';
  static String columnbaseCurrencyCode = 'baseCurrencyCode';
  static String columnbaseCurrencyName = 'baseCurrencyName';
  static String columupdatedDate = 'updatedDate';
  static String columAmount = 'entryAmount';

  Future<void> careteTable() async {
    await db.execute('''
  create table $converterResultTable ( 
  $columnId integer primary key, 
  $columnamount text not null,
  $columnbaseCurrencyCode text not null,
  $columnbaseCurrencyName text not null,
  $columupdatedDate text not null,
  $columAmount real not null )
  ''');
  }

  Future<void> insert(
      ConverterResultModel converterResultModel, double amount) async {
    try {
      await db.insert(
          converterResultTable, converterResultModel.toDBMap(amount));
    } catch (e) {
      Log.red(
          'ConverterResulDBModelProvider : Faild to Insert into $converterResultTable $e');
    }
  }

  Future<Either<Failure, ConverterResultModel>> getConverterResult(
      double amount) async {
    List<Map> maps = await db.query(converterResultTable,
        columns: [
          columnId,
          columnamount,
          columnbaseCurrencyCode,
          columnbaseCurrencyName,
          columupdatedDate
        ],
        where: '$columAmount = ?',
        whereArgs: [amount]);
    if (maps.isNotEmpty) {
      return Right(ConverterResultModel.fromDBMap(maps.last));
    }
    return Left(Failure(code: 0, message: "no data found for amount $amount"));
  }

  Future<int> delete(int id) async {
    return await db
        .delete(converterResultTable, where: '$columnId = ?', whereArgs: [id]);
  }

  // Future<int> update(ConverterResultModel converterResultModel) async {
  //   return await db.update(ratesTable, converterResultModel.toDBMap(),
  //       where: '$columnId = ?',
  //       whereArgs: [converterResultModel.date.millisecondsSinceEpoch]);
  // }

  Future close() async => db.close();
}
