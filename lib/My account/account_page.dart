import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/constants.dart';

class MyAccount extends StatelessWidget {
  MyAccount({super.key});

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'My Account',
        style: TextStyle(
          color: Colors.orange[500],
          fontSize: 17,
        ),
      ),
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
          icon: const Icon(
            Icons.home,
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: kDefaultPaddin / 2),
      ],
    );
  }

  Widget sizedbox = const SizedBox(
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Icon(
              Icons.account_circle,
              color: Colors.grey[500],
              size: 150,
            )),
            sizedbox,
            CardButton(text: 'My Account', buttonAction: () {
              log('message');
            }, icon: Icons.account_circle,),
            sizedbox,
            CardButton(text: 'Notifications', buttonAction: () {}, icon: Icons.notifications,),
            sizedbox,
           CardButton(text: 'My Orders', buttonAction: () {}, icon: Icons.shopping_cart,),
            sizedbox,
           CardButton(text: 'Settings', buttonAction: () {}, icon: Icons.settings,),
            sizedbox,
           CardButton(text: 'Help Center', buttonAction: () {}, icon: Icons.help_center,),
            sizedbox,
            CardButton(text: 'Log out', buttonAction: () {}, icon: Icons.logout_rounded,),
          ],
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  CardButton({required this.text, required this.buttonAction, required this.icon});
  final String text;
  final void Function() buttonAction;
  final  IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.white,),
              SizedBox(width: 10,),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        color: Colors.orange[500],
      ),
    );
  }
}
