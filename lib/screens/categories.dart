import 'dart:convert';
import 'package:ecommerce/screens/details.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final categories = [
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];
  Future<List<dynamic>> getProducts(String category) async {
    final url = 'https://fakestoreapi.com/products/category/$category';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body;
    } else {
      throw Exception('Failed to load products');
    }
  }

  String name = 'electronics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3cba51),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      backgroundColor: WidgetStatePropertyAll(
                          name == categories[index]
                              ? Colors.green.shade800
                              : Colors.green.shade200),
                    ),
                    onPressed: () {
                      setState(() {
                        name = categories[index];
                      });
                    },
                    child: Text(
                      categories[index],
                      style: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(
            color: Colors.green.shade100,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: FutureBuilder<List<dynamic>>(
              future: getProducts(name),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                    ),
                                  )),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: DetailsScreen(
                                          price: product['price'],
                                          id: product['id'],
                                          category: product['category'],
                                          description: product['description'],
                                          imageurl: product['image'],
                                          itemssold: product['rating']['count']
                                              .toString(),
                                          rating: product['rating']['rate']
                                              .toString(),
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
                                    transitionDuration:
                                        const Duration(seconds: 1),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Times New Roman'),
                                    ),
                                  ),
                                  Text(
                                      '⭐ ${product['rating']['rate'].toString()}'),
                                ],
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
          )
        ],
      ),
    );
  }
}
