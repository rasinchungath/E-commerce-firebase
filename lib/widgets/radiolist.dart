import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/checkout/paymentpage.dart';

Widget radioList({
  required void Function(PaymentMethod? value) selected,
  required String tiTle,
  required String text,
  required PaymentMethod value,
  required PaymentMethod method,
}) {
  return ListTile(
    title: Text(tiTle),
    leading: Radio(
      fillColor:
          MaterialStateColor.resolveWith((states) => Colors.orange.shade500),
      value: value,
      groupValue: method,
      onChanged: selected,

      //  (PaymentMethod? value) {

      //   // setState(() {
      //   //   method = value!;
      //   //   log(value.toString());
      //   // });
      // },
    ),
    subtitle: Text(text),
  );
}
