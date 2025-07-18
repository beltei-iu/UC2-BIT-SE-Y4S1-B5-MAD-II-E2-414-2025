

import 'package:get/get.dart';
import 'package:mad_2_414/models/order.dart';
import 'package:mad_2_414/services/order_service.dart';

class CartController extends GetxController {

  var orders = <Order>[].obs;
  var itemsCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  Future<List<Order>> getOrders() async {
    final orderService = OrderService.instance;
    List<Order> orderItems = await orderService.getOrders();
    itemsCount.value = orderItems.length;
    update();
    return orderItems;
  }

  Future<void> insertOrder(Order order) async {
    final orderService = OrderService.instance;
    await orderService.insertOrder(order);
    getOrders();
  }

  Future<void> deleteOrder(int id) async {
    final orderService = OrderService.instance;
    await orderService.deleteOrder(id);
    getOrders();
  }
}