import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HttpService {

  Future<void> getPosts() async {
    final apiUrl = "https://example.com/product";
    final header = {'Content-Type': 'application/json'};
    final response = await http.get(Uri.parse(apiUrl), headers: header);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Posts: $data");
    } else {
      print("Failed to fetch posts");
    }
  }



  Future<void> createProduct() async {
    final apiUrl = "https://example.com/product";
    final header = {'Content-Type': 'application/json'};
    final bodyRequest = jsonEncode({
      'name': 'iPhone',
      'price': 1000
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: header,
      body: bodyRequest,
    );

    if (response.statusCode == 201) {
      print("Success : ${response.body}");
    } else {
      print("Failed : ${response.statusCode}");
    }
  }

  Future<void> updateProduct() async {
    final apiUrl = "https://example.com/product/1";
    final header = {'Content-Type': 'application/json'};
    final bodyRequest = jsonEncode({
      'name': 'iPhone',
      'price': 1200
    });

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: header,
      body: bodyRequest,
    );

    if (response.statusCode == 200) {
      print("Success: ${response.body}");
    } else {
      print("Failed : ${response.statusCode}");
    }
  }


  Future<void> deleteProduct() async {
    final apiUrl = "https://example.com/product/1";
    final header = {'Content-Type': 'application/json'};
    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: header,
    );

    if (response.statusCode == 200) {
      print("Success: ${response.body}");
    } else {
      print("Failed : ${response.statusCode}");
    }
  }


}