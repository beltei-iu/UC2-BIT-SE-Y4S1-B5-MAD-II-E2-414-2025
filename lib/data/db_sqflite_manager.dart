import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DbSqfliteManager {

  String dbName = "phone_shop.db";
  String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
  String textType = "TEXT";
  String doubleType = "DOUBLE";
  String intType = "INTEGER";


  static final DbSqfliteManager instance = DbSqfliteManager._init();

  DbSqfliteManager._init();

  Future<Database> get database async {
    // Path DB
    final dbPath = await getDatabasesPath();
    // Path
    final path = join(dbPath, dbName);
    if(Platform.isWindows || Platform.isLinux){
      var databaseFactory = databaseFactoryFfi;
      return databaseFactory.openDatabase(path,options: OpenDatabaseOptions(
          onCreate: _initTable
      ));
    }
    else if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      return databaseFactory.openDatabase(path,options: OpenDatabaseOptions(
          onCreate: _initTable
      ));
    }else{
      // Create DB
      return openDatabase(path, version: 1, onCreate: _initTable);
    }

  }

  Future<void> _initTable(Database db, int version) async {
    _initTableCategory(db);
    _initTableProduct(db);
    _initTableOrder(db);
  }

  Future<void> _initTableCategory(Database db) async{
    String categoryTable = '''
    CREATE TABLE IF NOT EXISTS ${TableConstant.categoryTable} (
      ${TableConstant.categoryId} $idType,
      ${TableConstant.categoryName} $textType,
      ${TableConstant.categortyNameKh} $textType
      )
    ''';
    db.execute(categoryTable);
  }

  Future<void> _initTableProduct(Database db) async{
    String productTable = '''
    CREATE TABLE IF NOT EXISTS ${TableConstant.productTable} (
      ${TableConstant.productId} $idType,
      ${TableConstant.productName} $textType,
      ${TableConstant.productDescription} $textType,
      ${TableConstant.productPrice} $doubleType,
      ${TableConstant.productDiscount} $intType,
      ${TableConstant.productRate} $intType
      )
    ''';
    db.execute(productTable);
  }

  Future<void> _initTableOrder(Database db) async{
    String orderTable = '''
    CREATE TABLE IF NOT EXISTS ${TableConstant.orderTable} (
      ${TableConstant.orderId} $idType,
      ${TableConstant.orderProductId} $intType,
      ${TableConstant.orderPrice} $doubleType,
      ${TableConstant.orderQuantity} $intType,
      ${TableConstant.orderDiscount} $intType
      )
    ''';
    db.execute(orderTable);
  }
}

class TableConstant {
  static const categoryTable = "tbl_category";
  static const categoryId = "id";
  static const categoryName = "name";
  static const categortyNameKh = "nameKh";

  static const productTable = "tbl_product";
  static const productId = "id";
  static const productName = "name";
  static const productDescription = "description";
  static const productPrice = "price";
  static const productDiscount = "discount";
  static const productRate = "rate";

  static const orderTable = "tbl_order";
  static const orderId = "id";
  static const orderProductId = "productId";
  static const orderPrice = "price";
  static const orderQuantity = "quantity";
  static const orderDiscount = "discount";
}
