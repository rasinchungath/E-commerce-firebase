
import 'package:flutter/material.dart';
import 'package:multiple_dropdown_firebase/model/product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../shoppingcart/cart.dart';

class Cart extends ChangeNotifier {
  final List<Product> products = [];


  List<Product> get getItems {
    return products;
  }

  double get totalPrice {
    var total = 0.0;

    for (var item in products) {
      total += item.proTotal;
    }
    return total;
  }

  int? get count {
    return products.length;
  }

  

  void addItem(String name, double price, int qty, String image, String id,
      BuildContext context) {
    final existingItem = products.where((element) => element.name == name);

    if (existingItem.isNotEmpty) {
      Fluttertoast.showToast(msg: 'Product already added to cart');
    } else {
      double proTotal = producctTotal(
        price,
        qty,
      );
      products.add(Product(
          name: name,
          price: price,
          qty: qty,
          image: image,
          id: id,
          proTotal: proTotal));

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CartView(),
      ));
    }
    notifyListeners();
  }

  void removeItem(intx) {
    products.removeAt(intx);
    notifyListeners();
  }

  void clearCart() {
    products.clear();
    notifyListeners();
  }

  double producctTotal(
    double price,
    int qty,
  ) {
    double proTotal = price;
    proTotal = proTotal * qty;

    notifyListeners();
    return proTotal;
  }

  void updateIncrementQty(
    double price,
    int qty,
    int index,
  ) {
    // log('index' + index.toString());
    // log('qty' + qty.toString());

    if (products.length > 0) {
      products[index].qty = products[index].qty + 1;
      products[index].proTotal = products[index].price * products[index].qty;
      //log('product qty' + products[index].qty.toString());
    }

    notifyListeners();
  }

  void updateDecrement(
    double price,
    int qty,
    int index,
  ) {
    // log('index' + index.toString());
    // log('qty' + qty.toString());

    if (products.length > 0) {
      products[index].qty = products[index].qty - 1;
      products[index].proTotal = products[index].price * products[index].qty;
      //log('product qty' + products[index].qty.toString());
    }

    notifyListeners();
  }
}
