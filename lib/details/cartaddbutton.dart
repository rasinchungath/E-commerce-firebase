import 'package:flutter/material.dart';

class CartButton extends StatefulWidget {
  IconData icon;
  VoidCallback onPressed;
  CartButton({required this.icon, required this.onPressed});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 35,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          )),
        ),
        onPressed: widget.onPressed,
        child: Center(child: Icon(widget.icon, size: 17,),),
      ),
    );
  }
}