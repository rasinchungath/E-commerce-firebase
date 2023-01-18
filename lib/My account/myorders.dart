import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/constants.dart';
import 'package:multiple_dropdown_firebase/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrders extends StatelessWidget {
  MyOrders({super.key});

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'My Ordrers',
        style: TextStyle(
          color: Colors.orange[500],
          fontSize: 17,
        ),
      ),
      centerTitle: true,
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

  final CollectionReference _order =
      FirebaseFirestore.instance.collection('order');
  final CollectionReference _orderhistory =
      FirebaseFirestore.instance.collection('orderdetails');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: buildAppBar(context),
      body: StreamBuilder(
        stream: _order.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ExpansionTile(
                      
                      title: const Text(
                        'Order ID:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15,),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          '${documentSnapshot['orderid']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue),
                        ),
                          
                        Text(
                          'Order Date: ${documentSnapshot['order date']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          'Order Total : ${documentSnapshot['order total']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ]),
                      children: <Widget>[
                        StreamBuilder(
                            stream: _orderhistory
                                .where("orderid",
                                    isEqualTo: documentSnapshot['orderid'])
                                .snapshots(),
                            builder: ((context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot1) {
                              if (streamSnapshot1.hasData) {
                                return Container(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount:
                                        streamSnapshot1.data!.docs.length,
                                    itemBuilder: ((context, index) {
                                      final DocumentSnapshot documentSnapshot1 =
                                          streamSnapshot1.data!.docs[index];
                                      return Card(
                                        elevation: 5.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image(
                                                height: 80,
                                                width: 80,
                                                image: NetworkImage(
                                                  documentSnapshot1[
                                                      'itemimage'],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 130,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueGrey
                                                                .shade800,
                                                            fontSize: 16.0),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                '${documentSnapshot1['itemname']}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    RichText(
                                                      maxLines: 1,
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueGrey
                                                                .shade800,
                                                            fontSize: 16.0),
                                                        children: [
                                                          TextSpan(
                                                              text: (documentSnapshot1[
                                                                      'orderprice']
                                                                  .toString()),
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              RichText(
                                                maxLines: 1,
                                                text: TextSpan(
                                                  text: '' r"x ",
                                                  style: TextStyle(
                                                    color: Colors
                                                        .blueGrey.shade800,
                                                    fontSize: 16.0,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: (documentSnapshot1[
                                                              'orderqty']
                                                          .toString()),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              } else {
                                return const Text('');
                              }
                            })),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
