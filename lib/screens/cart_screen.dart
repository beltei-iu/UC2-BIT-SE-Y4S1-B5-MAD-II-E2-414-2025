import 'package:flutter/material.dart';
import 'package:mad_2_414/controller/cart_controller.dart';
import 'package:mad_2_414/data/file_storage_service.dart';
import 'package:mad_2_414/models/order.dart';
import 'package:mad_2_414/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final cartController = Get.put(CartController());
  List<Order> orders = [];
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    _loadOrder();
  }

  Future<void> _loadOrder() async{
    setState(() {
      _isLoading = true;
    });
    cartController.getOrders().then((value) {
      setState(() {
        orders = value;
        _isLoading = false;
      });
    }).catchError((e){
      setState(() {
        // case error
        _isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    //final cartProvider = Provider.of<CartProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        actions: [Icon(Icons.search)],
      ),

        body: _isLoading ?
              Center(child: CircularProgressIndicator()) :
               ListView.builder(
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {

                Order order = orders[index];

                print("Order : $order");

                return Dismissible(
                  key: ValueKey(order.id),
                  child: Card(
                    elevation: 0.5,
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text("${order.productId}"),
                      subtitle: Text("Order "),
                      trailing: Icon(Icons.delete),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    final alert = AlertDialog(
                        title: Icon(Icons.delete, size: 30, color: Colors.red,),
                        content: Text("Are you sure you want to delete this order?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              cartController.deleteOrder(order.id!);
                              _loadOrder();
                              Navigator.pop(context, false);
                            },
                            child: Text("Yes"),
                          ),
                        ]
                    );
                    showDialog(
                      context: context,
                      builder: (context) => alert,
                    );
                  },
                );
              },
            ),

      // body: FutureBuilder(
      //   future: cartController.getOrders(),
      //   builder: (
      //     BuildContext context,
      //     AsyncSnapshot<List<Order>> asyncSnapshot,
      //   ) {
      //     // Loading
      //     if (asyncSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //
      //     // Error
      //     if (asyncSnapshot.hasError) {
      //       return Center(child: Text("Error : ${asyncSnapshot.error}"));
      //     }
      //
      //     // No data
      //     if (!asyncSnapshot.hasData) {
      //       return Center(child: Text("No Data"));
      //     }
      //
      //     List<Order> orders = asyncSnapshot.data as List<Order>;
      //     print("orders : $orders");
      //
      //     return ListView.builder(
      //       itemCount: orders.length,
      //       itemBuilder: (BuildContext context, int index) {
      //
      //         Order order = orders[index];
      //
      //         print("Order : $order");
      //
      //         return Dismissible(
      //             key: ValueKey(order.id),
      //             child: Card(
      //               elevation: 0.5,
      //               child: ListTile(
      //                 leading: Icon(Icons.shopping_cart),
      //                 title: Text("${order.productId}"),
      //                 subtitle: Text("Order "),
      //                 trailing: Icon(Icons.delete),
      //               ),
      //             ),
      //             confirmDismiss: (direction) async {
      //                 final alert = AlertDialog(
      //                   title: Icon(Icons.delete, size: 30, color: Colors.red,),
      //                   content: Text("Are you sure you want to delete this order?"),
      //                   actions: [
      //                     TextButton(
      //                       onPressed: () => Navigator.pop(context, false),
      //                       child: Text("No"),
      //                     ),
      //                       TextButton(
      //                       onPressed: () {
      //                         cartController.deleteOrder(order.id!);
      //                         Navigator.pop(context, false);
      //                       },
      //                       child: Text("Yes"),
      //                       ),
      //                   ]
      //                 );
      //                 showDialog(
      //                   context: context,
      //                   builder: (context) => alert,
      //                 );
      //             },
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
