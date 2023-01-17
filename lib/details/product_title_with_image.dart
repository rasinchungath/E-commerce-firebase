import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage(
      {required this.productName, required this.price, required this.image,required this.id});
  final String productName, price, image, id;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20,),
          const Text(
            "Best Iphone Ever",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,

                ),
          ),
          Text(
            productName,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: "Price\n",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            decoration: TextDecoration.none)),
                    TextSpan(
                      text: "\$${price}",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: kDefaultPaddin),
              Expanded(
                child: Hero(
                    tag: id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(70), // Image radius
                        child: Image.network(image, 
                        height: 150,
                        fit: BoxFit.cover),
                      ),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
