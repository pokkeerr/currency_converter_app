import 'dart:convert';

import 'package:currency_converter_app/data/network/dio/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../helpers/logger.dart';

class CurrencyWeeklyconverterModel {
  final Map<String, Map<String, num>> res;

  CurrencyWeeklyconverterModel(this.res);

  static CurrencyWeeklyconverterModel fromMap(Map<String, dynamic> map) {
    final m = Map<String, dynamic>.from(map);
    Map<String, Map<String, num>> d = {};
    for (var v in m.entries) {
      if (v.value is Map<String, num>) {
        d[v.key] = Map<String, num>.from(v.value);
      } else {
        Map<String, num> dd = {};
        for (var e in v.value.entries) {
          dd[e.key] = e.value;
        }
        d[v.key] = dd;
      }
    }
    return CurrencyWeeklyconverterModel(d);
  }

  CurrencyWeeklyconverterModel.froDBmMap(Map<dynamic, dynamic> map)
      : res = Map<String, Map<String, num>>.from(map['rates']);

  Map<String, dynamic> toMap() => res;

  Map<String, dynamic> toDBMap(double amount, String fromTo, String toFrom) {
    final result = <String, dynamic>{};
    result.addAll({
      'rates': json.encode(res),
      'id': DateTime.now().millisecondsSinceEpoch,
      'amount': amount,
      'fromTo': fromTo,
      'toFrom': toFrom
    });
    return result;
  }
}

class CurrencyconverterModel {
  final Map<String, num> resulte;

  CurrencyconverterModel(this.resulte);

  CurrencyconverterModel copyWith({Map<String, num>? res}) {
    return CurrencyconverterModel(res ?? resulte);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'res': resulte});

    return result;
  }

  Map<String, dynamic> toDBMap(double amount, String fromTo, String toFrom) {
    final result = <String, dynamic>{};
    result.addAll({
      'rates': json.encode(resulte),
      'id': DateTime.now().millisecondsSinceEpoch,
      'amount': amount,
      'fromTo': fromTo,
      'toFrom': toFrom
    });

    return result;
  }

  factory CurrencyconverterModel.fromMap(Map<String, dynamic> map) {
    return CurrencyconverterModel(Map<String, num>.from(map));
  }
  factory CurrencyconverterModel.fromDBMap(Map<dynamic, dynamic> map) {
    return CurrencyconverterModel(
        Map<String, num>.from(json.decode(map['rates'])));
  }

  String toJson() => json.encode(toMap());

  factory CurrencyconverterModel.fromJson(String source) =>
      CurrencyconverterModel.fromMap(json.decode(source));

  @override
  String toString() => 'CurrencyconverterModel(res: $resulte)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyconverterModel && mapEquals(other.resulte, resulte);
  }

  @override
  int get hashCode => resulte.hashCode;
}

class CurrencyconverterDBModelProvider {
  final Database db;
  CurrencyconverterDBModelProvider(this.db);

  static String currencyconverterTable = 'currencyconverterTable';
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

  Future<void> insert(CurrencyconverterModel currencyconverterModel,
      double amount, String fromTo, String toFrom) async {
    try {
      await db.insert(currencyconverterTable,
          currencyconverterModel.toDBMap(amount, fromTo, toFrom));
    } catch (e) {
      Log.red(
          'CurrencyconverterDBModelProvider : Faild to Insert into $currencyconverterTable $e');
    }
  }

  Future<Either<Failure, CurrencyconverterModel>> getCurrencyconverter(
      double amount, String fromTo, String toFrom) async {
    List<Map> maps = await db.query(currencyconverterTable,
        columns: [columnId, columnResulte],
        where: '$columnAmount = ?, $columnfromTo = ?, $columnToFrom',
        whereArgs: [amount, fromTo, toFrom]);
    if (maps.isNotEmpty) {
      return Right(CurrencyconverterModel.fromDBMap(maps.last));
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
