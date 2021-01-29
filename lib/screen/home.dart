import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopping/components/app-bar.dart';
import 'package:shopping/screen/cartmodel.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uri = 'http://10.0.2.2:3000/product';
  List<Product> _products;
  // ignore: missing_return
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    setState(() {
      var tagObjsJson = jsonDecode(response.body) as List;
      _products =
          tagObjsJson.map((tagJson) => Product.fromJson(tagJson)).toList();
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: homeAppBar(context),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 0.7),
        itemCount: _products == null ? 0 : _products.length,
        itemBuilder: (context, index) {
          return ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
            return Container(
              margin: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 20,
                        color: Color(0xFFB0CCE1).withOpacity(0.32))
                  ]),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    model.addProduct(_products[index]);
                    final snackBar = SnackBar(
                      content: const Text('Added To Cart'),
                      backgroundColor: const Color(0xffae00f0),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'Close',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.7,
                          height: 100,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new NetworkImage(
                                'https://www.takeaway.com/foodwiki/uploads/sites/11/2019/08/samosa_2-1080x960.jpg',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _products[index].meal_name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "\u{20B9} " + _products[index].price.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
      //  MealList(products: _products, size: size),
    );
  }
}
