import 'package:flutter/material.dart';
import 'package:mad_2_414/data/file_storage_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        elevation: 2,
        centerTitle: true,
        actions: [Icon(Icons.search)],
      ),
      body: FutureBuilder(
        future: FileStorageService.getOrders(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<String>> asyncSnapshot,
        ) {
          // Loading
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Error
          if (asyncSnapshot.hasError) {
            return Center(child: Text("${asyncSnapshot.error}"));
          }

          // No data
          if (!asyncSnapshot.hasData) {
            return Center(child: Text("No Data"));
          }

          List<dynamic> orders = asyncSnapshot.data as List;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              String order = orders[index];
              return Card(
                elevation: 0.5,
                child: ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text(order),
                  subtitle: Text("Order $index"),
                  trailing: Icon(Icons.details),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
