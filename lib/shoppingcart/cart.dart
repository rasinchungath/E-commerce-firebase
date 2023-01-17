import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/checkout/address.dart';
import 'package:multiple_dropdown_firebase/constants.dart';
import 'package:multiple_dropdown_firebase/model/product_class.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  Cart cart = Cart();

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: kTextColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: 
          const Icon(
            Icons.delete,
            color: kTextColor,
          ),
          onPressed: () {
            context.read<Cart>().clearCart();
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.account_circle,
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: kDefaultPaddin / 2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Consumer<Cart>(builder: (context, cart, child) {
        return cart.products.isEmpty ? emptycart() : cartItems();
      }),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text('Total:'),
                subtitle: Consumer<Cart>(
                  builder: (context, cart, child) {
                    return Text(cart.totalPrice.toString());
                  },
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MaterialButton(
                onPressed: () {
                  if (context.read<Cart>().products.isNotEmpty) {
                     Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Address(),
                  ));
                  }
                 
                },
                color: Colors.orange[500],
                child: const Text(
                  'Check out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget emptycart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.shopping_cart,
            size: 100,
            color: Colors.grey,
          ),
          SizedBox(
            height: 30,
          ),
          Text('Oops!...Your cart is empty'),
        ],
      ),
    );
  }

  Widget cartItems() {
    return Consumer<Cart>(builder: (context, cart, child) {
      return ListView.builder(
        itemCount: cart.count,
        itemBuilder: (context, index) {
          final product = cart.getItems[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CartCard(
              productName: product.name,
              price: product.price,
              image: product.image,
              id: product.id,
              qty: product.qty,
              index: index,
            ),
          );
        },
      );
    });
  }
}

class CartCard extends StatelessWidget {
  CartCard({
    super.key,
    required this.productName,
    required this.price,
    required this.image,
    required this.id,
    required this.index,
    required this.qty,
  });
  final String productName, image, id;
  final double price;
  int qty, index;

  Cart cart = Cart();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10),
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(50), // Image radius
                        child: Image.network(image, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Column(
                      children: [
                        Text(productName),
                        Text("\$" + price.toString()),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (qty > 1) {
                                  context.read<Cart>().updateDecrement(
                                        price,
                                        qty,
                                        index,
                                      );
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              qty.toString().padLeft(2, "0"),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<Cart>().updateIncrementQty(
                                      price,
                                      qty,
                                      index,
                                    );
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text('Total:' +
                              cart.producctTotal(price, qty).toString()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: IconButton(
              onPressed: () {
                context.read<Cart>().removeItem(index);
              },
              icon: Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}
