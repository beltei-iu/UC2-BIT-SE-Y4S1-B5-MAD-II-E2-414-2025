import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mad_2_414/controller/cart_controller.dart';
import 'package:mad_2_414/data/file_storage_service.dart';
import 'package:mad_2_414/models/order.dart';
import 'package:mad_2_414/provider/cart_provider.dart';
import 'package:mad_2_414/services/category_service.dart';
import 'package:mad_2_414/services/order_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? fullName;
  int? _cartItemCount = 0;
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    loadUser();
    // _loadOrder();
  }

  Future<void> _loadOrder() async {
    List<String> ordrs = await FileStorageService.getOrders();
    setState(() {
      _cartItemCount = ordrs.length;
    });
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("fullName");
    String? email = prefs.getString("email");

    // await Future.delayed(Duration(seconds: 2));
    String? subUsername = email != null ? email.split("@")[0] : null;
    setState(() {
      this.fullName = username ?? subUsername ?? "Guest";
    });
    print("User data loaded");
  }

  @override
  Widget build(BuildContext context) {

    //final cartProvider = Provider.of<CartProvider>(context, listen: true);


    return Scaffold(appBar: _appBar, body: _body);
  }

  PreferredSizeWidget get _appBar {

    // cartProvider.getOrders().then((v){
    //     setState(() {
    //       _cartItemCount = v.length;
    //     });
    // }).catchError((e){
    //     setState(() {
    //       _cartItemCount = 0;
    //     });
    // });

    return AppBar(
      elevation: 0.5,
      backgroundColor: Colors.indigoAccent,
      actions: [
        badges.Badge(
          badgeContent: GetBuilder<CartController>(builder: (cartController){

            cartController

            return Text(
              "${cartController.orders.length}",
              style: TextStyle(color: Colors.white),
            );
          }),
          child: Icon(Icons.shopping_cart),
        ),

        Icon(Icons.more_vert),
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
          child: Image.asset("assets/images/HQ.png", height: 200, fit: BoxFit.cover),
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
            "Hi, $fullName",
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
    final cartItems =
        List.generate(10, (i) {
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
                            //FileStorageService.saveOrder(i, 2000, 1, 0);

                            final orderService = OrderService.instance;
                            final order = Order(
                              productId: i,
                              price: 2000,
                              quantity: 1,
                              discount: 0,
                            );
                            orderService.insertOrder(order);

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

    // Option 1
    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(children: cartItems),
    // );

    // Option 2
    return SizedBox(
      height: 250,
      child: ListView(scrollDirection: Axis.horizontal, children: cartItems),
    );
  }
}
