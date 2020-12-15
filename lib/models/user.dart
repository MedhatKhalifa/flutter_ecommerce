import 'package:meta/meta.dart';

class User {
  dynamic id;
  dynamic username;
  dynamic email;
  dynamic jwt;
  dynamic cartId;

  User(
      {@required this.id,
      @required this.username,
      @required this.email,
      @required this.jwt,
      @required this.cartId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        jwt: json['jwt'],
        cartId: json['cart_id']);
  }
}
