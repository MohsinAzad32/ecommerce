import 'package:ecommerce/model/cart.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Cart> items;
  const CartScreen({super.key, required this.items});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  double price = 219.0 + 22.3 + 15.9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF3cba51),
        appBar: AppBar(),
        body: widget.items.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.hourglass_empty_rounded,
                      size: 50,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Cart is Empty',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                      ),
                    )
                  ],
                ),
              )
            : Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: AnimatedList(
                      key: listKey,
                      initialItemCount: widget.items.length,
                      itemBuilder: (context, index, animation) {
                        final item = widget.items[index];
                        return SizeTransition(
                          key: UniqueKey(),
                          sizeFactor: animation,
                          child: Card(
                            key: UniqueKey(),
                            color: Colors.green.shade300,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  item.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                item.title,
                                maxLines: 1,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      widget.items[index].price.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'Times New Roman'),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.items[index].quantity++;
                                              price = widget
                                                      .items[index].price *
                                                  widget.items[index].quantity;
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.add_circle_outlined)),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          item.quantity.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: 'Times New Roman'),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (widget
                                                      .items[index].quantity ==
                                                  0) {
                                                return;
                                              } else {
                                                widget.items[index].quantity--;
                                              }
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.remove_circle_rounded)),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  widget.items.removeAt(index);
                                  listKey.currentState!.removeItem(
                                    index,
                                    (context, animation) {
                                      return SizeTransition(
                                        key: UniqueKey(),
                                        sizeFactor: animation,
                                        child: Card(
                                          key: UniqueKey(),
                                          color: Colors.green.shade300,
                                          child: ListTile(
                                            title: Text(
                                              item.title,
                                              maxLines: 1,
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    widget.items[index].price
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'Times New Roman'),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            widget.items[index]
                                                                .quantity++;
                                                            price = widget
                                                                    .items[
                                                                        index]
                                                                    .price *
                                                                widget
                                                                    .items[
                                                                        index]
                                                                    .quantity;
                                                          });
                                                        },
                                                        icon: const Icon(Icons
                                                            .add_circle_outlined)),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        item.quantity
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Times New Roman'),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            if (widget
                                                                    .items[
                                                                        index]
                                                                    .quantity ==
                                                                0) {
                                                              return;
                                                            } else {
                                                              widget
                                                                  .items[index]
                                                                  .quantity--;
                                                            }
                                                          });
                                                        },
                                                        icon: const Icon(Icons
                                                            .remove_circle_rounded)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                listKey.currentState!
                                                    .removeItem(
                                                  index,
                                                  (context, animation) {
                                                    return SizeTransition(
                                                      sizeFactor: animation,
                                                    );
                                                  },
                                                  duration: const Duration(
                                                      seconds: 1),
                                                );
                                              },
                                              icon: const Icon(Icons.delete),
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    duration: const Duration(seconds: 1),
                                  );
                                },
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Total Amount   \$ $price',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Times New Roman'),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]));
  }
}
