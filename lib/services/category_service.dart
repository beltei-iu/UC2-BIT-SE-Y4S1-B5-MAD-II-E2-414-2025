import 'package:mad_2_414/data/db_sqflite_manager.dart';
import 'package:mad_2_414/models/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryService {

  Future<List<Category>> getCategory() async {
    final Database db = await DbSqfliteManager.instance.database;
    final List<Map<String, dynamic>> results = await db.query(TableConstant.categoryTable,);
    List<Category> categories =
        results.map((e) => Category.fromMap(e)).toList();
    return categories;
  }

  Future<void> insertCategory(Category category) async {
    final Database db = await DbSqfliteManager.instance.database;
    await db.insert(TableConstant.categoryTable, category.toMap());
  }
}
