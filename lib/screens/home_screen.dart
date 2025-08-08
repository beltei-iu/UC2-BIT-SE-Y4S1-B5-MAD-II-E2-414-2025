import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mad_2_414/controller/cart_controller.dart';
import 'package:mad_2_414/data/file_storage_service.dart';
import 'package:mad_2_414/models/order.dart';
import 'package:mad_2_414/models/product.dart';
import 'package:mad_2_414/provider/cart_provider.dart';
import 'package:mad_2_414/screens/add_product_screen.dart';
import 'package:mad_2_414/services/category_service.dart';
import 'package:mad_2_414/services/order_service.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _fullName = "Guest";
  final cartController = Get.put(CartController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Map<String, Product> productsMap = {};

  @override
  void initState() {
    super.initState();
    _currentUser();
    _fetchProducts();
  }

  Future<void> _currentUser() async {
    final currentUser = await _auth.currentUser!;
    setState(() {
      _fullName = currentUser.email!.split("@")[0];
    });
  }

  Future<void> _fetchProducts() async {
    try {
      final dbRef = await _db.ref("products");
      await dbRef.onValue.listen((event) {
        Map<dynamic, dynamic> data = event.snapshot.value as dynamic;
        print("Data : $data");
        data.forEach((key, value) {
          print("key  : $key");
          print("value : $value");
          try {
            // If value is already a Map (common in Firebase)
            if (value is Map<String, dynamic>) {
              Product product = Product.fromMap(value);
              print("Product: ${product.toString()}");
              setState(() {
                productsMap[key] = product;
              });
            }
            // If value is a JSON string (less common)
            else if (value is String) {
              Map<String, dynamic> productMap = jsonDecode(value);
              Product product = Product.fromMap(productMap);
              print("Product: ${product.toString()}");
              setState(() {
                productsMap[key] = product;
              });
            }
          } catch (e) {
            print("Error parsing product $key: $e");
          }
        });
      });
    } catch (error) {
      print("Error $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar, body: _body);
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      elevation: 0.5,
      backgroundColor: Colors.indigoAccent,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: badges.Badge(
            badgeContent: GetBuilder<CartController>(
              builder: (cartController) {
                return Text(
                  "${cartController.orders.length}",
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
            child: Icon(Icons.shopping_cart),
          ),
        ),
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.add, color: Colors.white),
          ),
          onTap: () {
            Get.to(AddProductScreen());
          },
        ),
      ],
    );
  }

  Widget get _body {
    return ListView(
      children: [
        _welcomeWidget,
        _searchWidget,
        _slide,
        _TopTitleWidget,
        _topProductListWidget,
      ],
    );
  }

  Widget get _slide {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: SizedBox(
        height: 200,
        child: Image.asset(
          "assets/images/HQ.png",
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget get _welcomeWidget {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "hi".tr + " " + "$_fullName",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          Text("What do you want to read today?"),
        ],
      ),
    );
  }

  Widget get _searchWidget {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: TextField(
        onChanged: (val) {},
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.voice_chat), Icon(Icons.search_off)],
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: "Search...",
        ),
      ),
    );
  }

  Widget get _TopTitleWidget {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ថ្មីៗ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }

  Widget get _topProductListWidget {
    print("productsMap.values: ${productsMap.values}");

    final cartItems =
        productsMap.values.map((i) {
          return SizedBox(
            height: 250,
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Card(
                elevation: 2,
                child: Column(
                  children: [
                    Image.asset("assets/images/iphone.jpg", height: 150),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            final alert = AlertDialog(
                              title: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 100,
                              ),
                              content: Text("Order saved successfuly"),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"),
                                ),
                              ],
                            );

                            showDialog(
                              context: context,
                              builder: (context) => alert,
                            );
                          },
                          icon: Icon(Icons.add),
                        ),
                        Text(
                          "1",
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList();
    return SizedBox(
      height: 250,
      child: ListView(scrollDirection: Axis.horizontal, children: cartItems),
    );
  }
}
