import 'package:scoped_model/scoped_model.dart';
import 'dart:core';

class CartModel extends Model {
  List<Product> cart = [];
  double totalCartValue = 0;

  int get total => cart.length;

  void addProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    if (index != -1)
      updateProduct(product, product.quan + 1);
    else {
      cart.add(product);
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].quan = 1;
    cart.removeWhere((item) => item.id == product.id);
    calculateTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].quan = qty;
    if (cart[index].quan == 0) removeProduct(product);

    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.quan = 1);
    cart = [];
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    cart.forEach((f) {
      totalCartValue += int.parse(f.price) * f.quan;
    });
  }
}

class Product {
  String id;
  // ignore: non_constant_identifier_names
  String meal_name;
  // ignore: non_constant_identifier_names
  String meal_info;
  String price;
  String type;
  int quan = 1;

  Product(this.id, this.meal_name, this.meal_info, this.price, this.type);

  factory Product.fromJson(dynamic json) {
    return Product(
      json['_id'] as String,
      json['meal_name'] as String,
      json['meal_info'] as String,
      json['price'] as String,
      json['type'] as String,
    );
  }

  @override
  String toString() {
    return '{ ${this.meal_name}, ${this.meal_info},${this.price},${this.type} }';
  }
}
