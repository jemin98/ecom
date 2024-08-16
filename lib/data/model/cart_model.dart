import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;
bool isLoading = false;
  void addToCart(String name, double price) {
    _cartItems.add({'name': name, 'price': price});
    notifyListeners();
  }

  double get totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + item['price']);

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

   loadingStatusChange() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
