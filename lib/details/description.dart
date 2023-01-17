import 'package:flutter/material.dart';


class Description extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        'I phone is the best smart phone available in the global market right now, its hardware and software experience makes them unique from other companies',
        style: TextStyle(
            fontSize: 10, decoration: TextDecoration.none, color: Colors.black),
      ),
    );
  }
}
