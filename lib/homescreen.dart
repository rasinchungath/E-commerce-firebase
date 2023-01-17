import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_dropdown_firebase/My%20account/account_page.dart';
import 'package:multiple_dropdown_firebase/constants.dart';
import 'package:multiple_dropdown_firebase/productview.dart';
import 'package:multiple_dropdown_firebase/shoppingcart/cart.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var category, category_item;
  var setDefaultcetegory = true, setDefaultcetegoryItem = true;

  @override
  void initState() {
    super.initState();
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: kTextColor,),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon:const Icon(Icons.account_circle, color: kTextColor,),
          
          
          onPressed: () { 
             Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyAccount(),
                  ));
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: kTextColor,),
          
          onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartView(),
                  ));
          },
        ),
        const SizedBox(width: kDefaultPaddin / 2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('category: $category');
    debugPrint('selected item: $category_item');
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('category')
                  .orderBy('category_name')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // Safety check to ensure that snapshot contains data
                // without this safety check, StreamBuilder dirty state warnings will be thrown
                if (!snapshot.hasData) return Container();
                // Set this value for default,
                // setDefault will change if an item was selected
                // First item from the List will be displayed
                if (setDefaultcetegory) {
                  category = snapshot.data!.docs[0].get('category_name');
                  debugPrint('setDefault category: $category');
                }
                return DropdownButton(
                  isExpanded: false,
                  value: category,
                  items: snapshot.data!.docs.map((value) {
                    return DropdownMenuItem(
                      value: value.get('category_name'),
                      child: Text('${value.get('category_name')}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    debugPrint('selected onchange: $value');
                    setState(
                      () {
                        debugPrint('category  selected: $value');
                        // Selected value will be stored
                        category = value;
                        // Default dropdown value won't be displayed anymore
                        setDefaultcetegory = false;
                        // Set makeModel to true to display first car from list
                        setDefaultcetegoryItem = true;
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            category != null
                ? StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('sub_category')
                        .where('name', isEqualTo: category)
                        .snapshots(),
                    // .orderBy("makeModel").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        debugPrint('snapshot status: ${snapshot.error}');
                        return Container(
                          child: Text(
                              'snapshot empty category: $category selected item: $category_item'),
                        );
                      }
                      if (setDefaultcetegoryItem) {
                        category_item = snapshot.data!.docs[0].get('model');
                        debugPrint('setDefault selected item: $category_item');
                      }
                      return DropdownButton(
                        isExpanded: false,
                        value: category_item,
                        items: snapshot.data!.docs.map((value) {
                          debugPrint('selected item: ${value.get('model')}');
                          return DropdownMenuItem(
                            value: value.get('model'),
                            child: Text(
                              '${value.get('model')}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          debugPrint('selected item: $value');
                          setState(
                            () {
                              // Selected value will be stored
                              category_item = value;
                              // Default dropdown value won't be displayed anymore
                              setDefaultcetegoryItem = false;
                            },
                          );
                        },
                      );
                    },
                  )
                : Container(),
            Expanded(
              child: ItemView( company: category_item),
            )
          ],
        ),
      ),
    );
  }
}
