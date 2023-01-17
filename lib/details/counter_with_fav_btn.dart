import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/details/cartcounter.dart';

class CounterWithFavBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.favorite_outlined,
            color: Colors.white,
            size: 20,
          ),
        )
      ],
    );
  }
}
