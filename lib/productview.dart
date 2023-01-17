import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/constants.dart';
import 'package:multiple_dropdown_firebase/details/detailscreen.dart';

class ItemView extends StatefulWidget {
  ItemView({@required this.company});
  var  company;

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  var productName, price, image, id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('product')
          .where('company', isEqualTo: widget.company)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Container();
        return GridView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectCard(
                productName: snapshot.data!.docs[index].get('name'),
                price: snapshot.data!.docs[index].get('price'),
                image: snapshot.data!.docs[index].get('image'),
                id: snapshot.data!.docs[index].get('id'),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        );
      },
    );
  }
}

class SelectCard extends StatelessWidget {
  const SelectCard({
    required this.productName,
    required this.price,
    required this.image,
    required this.id,
  });

  final String productName, price, image, id;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(fontSize: 10);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              productName: productName,
              price: price,
              image: image,
              id: id,
            ),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(kDefaultPaddin),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                //color: product.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(80), // Image radius
                    child: Image.network(image, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              productName,
              style: const TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$$price",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
