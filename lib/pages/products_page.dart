import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/redux/actions.dart';
import 'package:flutter_ecommerce/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:badges/badges.dart';

final gradientBackground = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [
      0.1,
      0.4,
      0.6,
      0.9
    ],
        colors: [
      Colors.indigo[50],
      Colors.indigo[100],
      Colors.indigo[200],
      Colors.blue[50]
    ]));

class ProductsPage extends StatefulWidget {
  final void Function() onInit;
  ProductsPage({this.onInit});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  void initState() {
    super.initState();
    widget.onInit();
  }

  final _appBar = PreferredSize(
      // to increase appbar size
      preferredSize: Size.fromHeight(60.0),
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return AppBar(
                centerTitle: true,
                title: SizedBox(
                    child: state.user != null
                        ? Text(state.user.username)
                        : FlatButton(
                            child: Text('Register or login from Here',
                                style: Theme.of(context).textTheme.body1),
                            onPressed: () =>
                                Navigator.pushNamed(context, '/register'))),
                leading: state.user != null
                    //Badge icon to use counter above it and you must install its package first
                    ? BadgeIconButton(
                        itemCount: state.cartProducts.length,
                        badgeColor: Colors.lime,
                        badgeTextColor: Colors.black,
                        icon: Icon(Icons.store),
                        onPressed: () => Navigator.pushNamed(context, '/cart'))
                    : Text(''),
                actions: [
                  Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      // to get out instaed of appstate add voidcallbak no data will be returned
                      child: StoreConnector<AppState, VoidCallback>(
                          converter: (store) {
                        return () => store.dispatch(logoutUserAction);
                      }, builder: (_, callback) {
                        return state.user != null
                            ? IconButton(
                                icon: Icon(Icons.exit_to_app),
                                onPressed: callback)
                            : Text('');
                      }))
                ]);
          }));

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: _appBar,
        body: Container(
            // for orange background
            decoration: gradientBackground,
            child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,

                /// no  context as it is not needed
                builder: (_, state) {
                  return Column(children: [
                    Expanded(
                        // to avoid mobile notches
                        child: SafeArea(
                            // keep safe in top and bottom
                            top: false,
                            bottom: false,
                            child: GridView.builder(
                                // to define no of scroll = product length
                                // default direction is vertical and two columns

                                itemCount: state.products.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: //
                                            orientation == Orientation.portrait
                                                ? 2
                                                : 3,
                                        // distance between col, rows
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0,
                                        // totake full wide incase of orientation
                                        childAspectRatio:
                                            orientation == Orientation.portrait
                                                ? 1.0
                                                : 1.3),
                                itemBuilder: (context, i) =>
                                    ProductItem(item: state.products[i]))))
                  ]);
                })));
  }
}
