import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/shoppingcart/cart.dart';
import '../constants.dart';

AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: kTextColor,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon:const Icon(Icons.search, color: kTextColor,),
          
          
          onPressed: () { },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: kTextColor,),
          
          onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartView(),
                  ));
          },
        ),
        const SizedBox(width: kDefaultPaddin / 2),
      ],
    );
  }