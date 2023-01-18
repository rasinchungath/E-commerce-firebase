import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/details/body.dart';
import 'package:multiple_dropdown_firebase/shoppingcart/cart.dart';
import '../widgets/appbar.dart';

class DetailsScreen extends StatelessWidget {

  const DetailsScreen({super.key, required this.productName,required this.price, required this.image,required this.id});
  final String productName, price, image, id;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      // each product have a color
      appBar: buildAppBar(context: context, firstIcon: Icons.search, secondIcon: Icons.shopping_cart,
      firstButtonAction: (){},
      secondButtonAction: (){
         Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CartView(),
          ));
      }
      ),
      body: Body(productName: productName, price: price, image: image, id: id,),
    );
  }

 
}