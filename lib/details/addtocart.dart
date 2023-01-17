import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/model/product_class.dart';
import 'package:multiple_dropdown_firebase/shoppingcart/cart.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class AddToCart extends StatelessWidget {
  AddToCart(
      {required this.productName,
      required this.price,
      required this.image,
      required this.id,
      required this.qty});
  final String productName, price, image, id;
  int qty;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartView(),
                  ));
                },
                icon: const Icon(Icons.shopping_cart)),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange[500]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  double productprice = double.parse(price);
                  context.read<Cart>().addItem(
                      productName, productprice, qty, image, id, context);
                },
                child: Text(
                  "Add to cart".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
