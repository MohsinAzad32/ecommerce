import 'package:ecommerce/model/cart.dart';
import 'package:ecommerce/screens/cart.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String imageurl;
  final int id;
  final String title;
  final String rating;
  final String description;
  final String itemssold;
  final String category;
  final double price;
  const DetailsScreen({
    super.key,
    required this.id,
    required this.price,
    required this.category,
    required this.description,
    required this.imageurl,
    required this.itemssold,
    required this.rating,
    required this.title,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final key = GlobalKey<AnimatedListState>();
  List<Cart> items = [
    Cart(
        image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
        price: 109.95,
        quantity: 2,
        title: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops'),
    Cart(
        image:
            'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
        price: 22.3,
        quantity: 3,
        title: 'Mens Casual Premium Slim Fit T-Shirts '),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3cba51),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: CartScreen(items: items),
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
            icon: Badge(
              label: Text(items.length.toString()),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                  tag: widget.title,
                  child: Image.network(
                    widget.imageurl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Card(
                color: Colors.green.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Hero(
                        tag: widget.id,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.title,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Times New Roman'),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '⭐ ${widget.rating}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times New Roman'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.itemssold} items sold',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times New Roman'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.32,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.green.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description:',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Times New Roman'),
                          ),
                        ),
                        Text(
                          widget.description,
                          maxLines: 4,
                          style: const TextStyle(
                            fontFamily: 'Times New Roman',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Text(
                              'Add to Cart',
                              style: TextStyle(
                                  fontFamily: 'Times New Roman',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    items.add(Cart(
                                        image: widget.imageurl,
                                        price: widget.price,
                                        quantity: int.parse(widget.itemssold),
                                        title: widget.title));
                                  });
                                  print(items[0].image);
                                  print(items[0].price);
                                  print(items[0].quantity);
                                  print(items[0].title);
                                },
                                icon: Icon(
                                  Icons.shopping_cart_checkout,
                                  size: 40,
                                  color: Colors.green.shade800,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
