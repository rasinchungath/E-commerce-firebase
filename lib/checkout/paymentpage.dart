import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/model/product_class.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'razid.dart' as razorCredentials;

enum PaymentMethod { cashondelivery, online, upi, wallet }

class PaymentPage extends StatefulWidget {
  PaymentPage(
      {required this.name, required this.adress, required this.pincode});
  String name, adress, pincode;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Cart cart = Cart();
  int deliverycharge = 40;
  final _razorpay = Razorpay();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response);
    verifySignature(
      signature: response.signature,
      paymentId: response.paymentId,
      orderId: response.orderId,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response);
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? ''),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

// create order
  void createOrder() async {
    String username = razorCredentials.keyId;
    String password = razorCredentials.keySecret;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, dynamic> body = {
      "amount": 100,
      "currency": "INR",
      "receipt": "rcptid_11"
    };
    var res = await http.post(
      Uri.https(
          "api.razorpay.com", "v1/orders"), 
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      openGateway(jsonDecode(res.body)['id']);
    }
    print(res.body);
  }

  openGateway(String orderId) {
    var options = {
      'key': razorCredentials.keyId,
      'amount': 100, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'I Phone 14',
      'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        'contact': '919657668899',
        'email': 'ary@example.com',
      }
    };
    _razorpay.open(options);
  }

  verifySignature({
    String? signature,
    String? paymentId,
    String? orderId,
  }) async {
    Map<String, dynamic> body = {
      'razorpay_signature': signature,
      'razorpay_payment_id': paymentId,
      'razorpay_order_id': orderId,
    };

    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    var res = await http.post(
      Uri.https(
        "10.0.2.2", // my ip address , localhost
        "razorpay_signature_verify.php",
      ),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded", // urlencoded
      },
      body: formData,
    );

    print(res.body);
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.body),
        ),
      );
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    // Removes all listeners

    super.dispose();
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Payment',
        style: TextStyle(color: Colors.orange[500], fontSize: 18),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange[500]),
              ),
              onPressed: () {},
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.orange[500],
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  PaymentMethod method = PaymentMethod.cashondelivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total:'),
                          Consumer<Cart>(
                            builder: (context, cart, child) {
                              return Text(cart.totalPrice.toString());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Shipping charges:'),
                          Text(deliverycharge.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.grey[500],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Consumer<Cart>(
                            builder: (context, cart, child) {
                              final deliveryTotal =
                                  cart.totalPrice + deliverycharge;
                              return Text(
                                deliveryTotal.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Cash on delivery'),
                      leading: Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.orange.shade500),
                        value: PaymentMethod.cashondelivery,
                        groupValue: method,
                        onChanged: (PaymentMethod? value) {
                          setState(() {
                            method = value!;
                            log(value.toString());
                          });
                        },
                      ),
                      subtitle: const Text('Pay at the time of delivery'),
                    ),
                    ListTile(
                      title: const Text('Online payment'),
                      leading: Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.orange.shade500),
                        value: PaymentMethod.online,
                        groupValue: method,
                        onChanged: (PaymentMethod? value) {
                          setState(() {
                            method = value!;
                            log(value.toString());
                          });
                        },
                      ),
                      subtitle: const Text('Visa / Master Card / Rupay'),
                    ),
                    ListTile(
                      title: const Text('Pay using UPI'),
                      leading: Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.orange.shade500),
                        value: PaymentMethod.upi,
                        groupValue: method,
                        onChanged: (PaymentMethod? value) {
                          // setState(() {
                          //   method = value!;
                          //   log(value.toString());
                          // });
                        },
                      ),
                      subtitle: const Text('Currently unavailable'),
                    ),
                    ListTile(
                      title: const Text('Pay using Wallet'),
                      leading: Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.orange.shade500),
                        value: PaymentMethod.wallet,
                        groupValue: method,
                        onChanged: (PaymentMethod? value) {
                          // setState(() {
                          //   method = value!;
                          //   log(value.toString());
                          // });
                        },
                      ),
                      subtitle: const Text('Currently unavailable'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery address:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            '${widget.name.toUpperCase()}\n${widget.adress.toUpperCase()}\n${widget.pincode}'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[500],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            (method == PaymentMethod.online)
                ? "Debit card"
                : 'Cash on delivery',
            style: TextStyle(color: Colors.orange[500]),
          ),
          content: Text((method == PaymentMethod.online)
              ? "Continue to pay using debit card"
              : 'Continue to pay cash on delivery'),
          actions: [
            TextButton(
                onPressed: () {
                  createOrder();
                  Navigator.of(context).pop();

                  String payMethod = (method == PaymentMethod.online)
                      ? 'debit card'
                      : 'cash on delivery';

                  CollectionReference orderRef =
                      FirebaseFirestore.instance.collection('order');
                  CollectionReference orderdetailsRef =
                      FirebaseFirestore.instance.collection('orderdetails');

                  final docId = orderRef.doc().id;

                  var formattedDate =
                      DateFormat('dd-MM-yyyy').format(DateTime.now());

                  orderRef.doc(docId).set({
                    'name': widget.name,
                    'order total': context.read<Cart>().totalPrice,
                    'delivery charge': deliverycharge,
                    'address': widget.adress,
                    'orderid': docId,
                    'order date': formattedDate,
                    'payment method': payMethod,
                    'Total amount':
                        context.read<Cart>().totalPrice + deliverycharge,
                  });
                  for (var item in context.read<Cart>().getItems) {
                    orderdetailsRef.doc().set({
                      'orderid': docId,
                      'item id': item.id,
                      'itemname': item.name,
                      'itemimage': item.image,
                      'orderqty': item.qty,
                      'orderprice': item.qty * item.price,
                      'payment method': payMethod,
                    });
                  }
                },
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.orange[500]),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.orange[500]),
                ))
          ],
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
