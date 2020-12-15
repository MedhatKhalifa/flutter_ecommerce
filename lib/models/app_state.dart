import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final User user;
  final List<Product> products;
  // cart will be copy of products wo it is not needed to make new model for it
  final List<Product> cartProducts;

  AppState(
      {@required this.user,
      @required this.products,
      @required this.cartProducts});

  factory AppState.initial() {
    return AppState(user: null, products: [], cartProducts: []);
  }
}
