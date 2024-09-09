import 'dart:convert';

import 'package:ecommerce/screens/categories.dart';
import 'package:ecommerce/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  Future<List<dynamic>> getProducts() async {
    const url = 'https://fakestoreapi.com/products';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Categories'),
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return FadeTransition(
                              opacity: animation,
                              child: const CategoriesScreen(),
                            );
                          },
                          transitionDuration: const Duration(seconds: 1),
                          reverseTransitionDuration: const Duration(seconds: 1),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ));
                      },
                    ),
                  ])
        ],
        title: const Text('E-Commerce App'),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFF3cba51),
        child: FutureBuilder<List<dynamic>>(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitCircle(
                  color: Colors.green.shade900,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No products found'),
              );
            } else {
              final products = snapshot.data!;
              return GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Card(
                      color: Colors.green.shade100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FittedBox(
                                child: Hero(
                                  tag: product['title'],
                                  child: Image.network(
                                    product['image'],
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                  ),
                                ),
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: DetailsScreen(
                                      price: product['price'],
                                      id: product['id'],
                                      category: product['category'],
                                      description: product['description'],
                                      imageurl: product['image'],
                                      itemssold:
                                          product['rating']['count'].toString(),
                                      rating:
                                          product['rating']['rate'].toString(),
                                      title: product['title'],
                                    ),
                                  );
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                transitionDuration: const Duration(seconds: 1),
                                reverseTransitionDuration:
                                    const Duration(seconds: 1),
                              ));
                            },
                            child: Hero(
                              tag: product['id'],
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  product['title'],
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontFamily: 'Times New Roman'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Card(
                                  color: Colors.green.shade400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      '\$ ${product['price'].toString()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Times New Roman'),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                    '⭐ ${product['rating']['rate'].toString()}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
