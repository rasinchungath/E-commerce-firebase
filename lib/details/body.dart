
import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/constants.dart';
import 'package:multiple_dropdown_firebase/details/addtocart.dart';
import 'package:multiple_dropdown_firebase/details/colorandsize.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatefulWidget {
  Body(
      {required this.productName,
      required this.price,
      required this.image,
      required this.id});
  final String productName, price, image, id;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  // height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ColorAndSize(),
                      const SizedBox(height: kDefaultPaddin / 2),
                      Description(),
                      const SizedBox(height: kDefaultPaddin / 2),
                      counter(),

                      // CounterWithFavBtn(),
                      const SizedBox(height: kDefaultPaddin / 2),

                      AddToCart(
                        productName: widget.productName,
                        price: widget.price,
                        image: widget.image,
                        id: widget.id,
                        qty: qty,
                      ),
                    ],
                  ),
                ),
                ProductTitleWithImage(
                  productName: widget.productName,
                  price: widget.price,
                  image: widget.image,
                  id: widget.id,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget counter() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              if (qty > 1) {
                setState(() {
                  qty--;
                });
              }
            },
            icon: const Icon(Icons.remove)),
        Text(
          qty.toString().padLeft(2, "0"),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                qty++;
              });
            },
            icon: const Icon(Icons.add)),
      ],
    );
  }
}
