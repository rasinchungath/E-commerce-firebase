import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multiple_dropdown_firebase/checkout/paymentpage.dart';
import 'package:multiple_dropdown_firebase/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Address extends StatelessWidget {
  

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
              ),
              onPressed: () {},
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.black),
              )),
        ),
      ],
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget sizedbox = const SizedBox(
      height: 20,
    );
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your  delivery address',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Name',
                ),
              ),
              sizedbox,
              TextFormField(
                controller: adressController,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Address',
                ),
              ),
              sizedbox,
              TextFormField(
                controller: pincodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Pin code',
                ),
              ),
              sizedbox,
              Center(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[500],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () {
                        String name, adress, pincode;
                        name = nameController.text;
                        adress = adressController.text;
                        pincode = pincodeController.text;
                        FirebaseFirestore.instance.collection('address').add({
                          'Name': name,
                          'Address': adress,
                          'Pin Code': pincode,
                        });

                        if (name.isNotEmpty &&
                            adress.isNotEmpty &&
                            pincode.isNotEmpty) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                            PaymentPage(
                                name: name, adress: adress, pincode: pincode),
                           ));
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please fill all the fields');
                        }
                      },
                      child: const Text(
                        'Proceed to Check out',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
