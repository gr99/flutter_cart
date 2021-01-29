import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopping/screen/cartmodel.dart';
import 'package:shopping/screen/cartpage.dart';
import 'package:shopping/screen/home.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

void main() => runApp(MyApp(
      model: CartModel(),
    ));

class MyApp extends StatefulWidget {
  final CartModel model;

  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CartModel>(
      model: widget.model,
      child: MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: currentIndex,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              onItemSelected: (index) => setState(() {
                currentIndex = index;
                print(currentIndex);
              }),
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                  activeColor: Colors.red,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.history),
                  title: Text('History'),
                  activeColor: Colors.purpleAccent,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.account_circle),
                  title: Text(
                    'User',
                  ),
                  activeColor: Colors.pink,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            body: (currentIndex == 0)
                ? HomePage()
                : (currentIndex == 1)
                    ? CartPage()
                    : Text("jai hind"),
          ),
        ),
      ),
    );
  }
}
