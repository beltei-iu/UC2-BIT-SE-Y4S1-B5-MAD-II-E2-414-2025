import 'package:mad_2_414/data/db_sqflite_manager.dart';
import 'package:mad_2_414/models/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductService {

  Future<void> insertProduct(Product product) async {
    final productTable = "product";
    final db = await DbSqfliteManager.instance.database;
    await db.insert(productTable, product.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Product>> readProducts() async {
    final productTable = "product";
    final db = await DbSqfliteManager.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(productTable);
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<void> updateProduct(Product product) async {
    final productTable = "product";
    final db = await DbSqfliteManager.instance.database;
    await db.update(
      productTable, product.toMap(), where: 'id = ?', whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(int id) async {
    final productTable = "product";
    final db = await DbSqfliteManager.instance.database;
    await db.delete(productTable, where: 'id = ?', whereArgs: [id]);
  }

}