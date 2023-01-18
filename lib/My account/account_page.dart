import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/constants.dart';
import 'package:multiple_dropdown_firebase/homescreen.dart';

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
        icon: Icon(
          Icons.arrow_back,
          color: Colors.orange[500],
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.home,
            size: 35,
            color: Colors.orange,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
          },
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
      backgroundColor: Colors.grey[200],
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Icon(
              Icons.account_circle,
              color: Colors.orange[300],
              size: 150,
            )),
            sizedbox,
            CardButton(
              text: 'My Account',
              buttonAction: () {
                log('message');
              },
              icon: Icons.account_circle,
            ),
            sizedbox,
            CardButton(
              text: 'Notifications',
              buttonAction: () {},
              icon: Icons.notifications,
            ),
            sizedbox,
            CardButton(
              text: 'My Orders',
              buttonAction: () {},
              icon: Icons.shopping_cart,
            ),
            sizedbox,
            CardButton(
              text: 'Settings',
              buttonAction: () {},
              icon: Icons.settings,
            ),
            sizedbox,
            CardButton(
              text: 'Help Center',
              buttonAction: () {},
              icon: Icons.help_center,
            ),
            sizedbox,
            CardButton(
              text: 'Log out',
              buttonAction: () {},
              icon: Icons.logout_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  CardButton(
      {required this.text, required this.buttonAction, required this.icon});
  final String text;
  final void Function() buttonAction;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.orange,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
