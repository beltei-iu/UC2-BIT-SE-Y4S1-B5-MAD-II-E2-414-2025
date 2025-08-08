import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _db = FirebaseDatabase.instance;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        title: Text("Add Product", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input title";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hint: Text("Title"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextFormField(
                controller: _priceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input price";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hint: Text("Price"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitProduct();
                    }
                  },
                  child: Text("Submit"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitProduct() async {
    try {
      final _dbRef = await _db.ref("products");
      final Map<String, Object?> dataReq = {
        "title": _titleController.text,
        "price": _priceController.text,
      };
      await _dbRef.push().set(dataReq);
      Future.delayed(Duration(seconds: 1));
      _titleController.clear();
      _priceController.clear();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product added successfully")));
      Navigator.pop(context);
    } catch (error) {
      print("Error $error");
    }
  }
}
