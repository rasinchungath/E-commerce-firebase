import 'package:flutter/material.dart';
import '../constants.dart';

AppBar buildAppBar({
  required BuildContext context,
  required IconData firstIcon,
  required IconData secondIcon,
  required void Function() firstButtonAction,
  required void Function() secondButtonAction,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.orange[500],
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          firstIcon,
          color: Colors.orange[500],
        ),
        onPressed: firstButtonAction,
      ),
      IconButton(
        icon: Icon(
          secondIcon,
          color: Colors.orange[500],
        ),
        onPressed: secondButtonAction,
      ),
      const SizedBox(width: kDefaultPaddin / 2),
    ],
  );
}
