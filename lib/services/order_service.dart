
import 'package:mad_2_414/data/db_sqflite_manager.dart';
import 'package:mad_2_414/models/order.dart';
import 'package:sqflite/sqflite.dart';

class OrderService {

  static final OrderService instance = OrderService._init();
  OrderService._init();

  Future<List<Order>> getOrders() async {
    final Database db = await DbSqfliteManager.instance.database;
    final List<Map<String, dynamic>> results = await db.query(
      TableConstant.orderTable,
    );
    List<Order> orders =
    results.map((e) => Order.fromMap(e)).toList();
    return orders;
  }

  Future<void> insertOrder(Order order) async {
    final Database db = await DbSqfliteManager.instance.database;
    await db.insert(TableConstant.orderTable, order.toMap());
  }

  Future<void> deleteOrder(int id) async {
    final Database db = await DbSqfliteManager.instance.database;
    await db.delete(TableConstant.orderTable, where: "id = ?", whereArgs: [id]);
  }
}