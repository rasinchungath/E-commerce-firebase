import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/details/cartaddbutton.dart';
import '../../../constants.dart';

class CartCounter extends StatefulWidget {
  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CartButton(
          icon: Icons.remove,
          onPressed: () {
            if (qty > 1) {
              setState(() {
                qty--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            qty.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        CartButton(
          icon: Icons.add,
          onPressed: () {
            setState(() {
              qty++;
            });
          },
        ),
      ],
    );
  }
}
