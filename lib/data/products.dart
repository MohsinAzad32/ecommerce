import 'dart:convert';

// import 'package:ecommerce/model/productsmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products {
  String url = 'https://fakestoreapi.com/products';

  Future getproducts() async {
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    return body;
  }
}
