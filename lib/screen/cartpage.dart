import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopping/screen/cartmodel.dart';
import 'package:shopping/constant.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.yellow[900]),
        backgroundColor: Colors.white,
        title: Text(
          "Cart",
          style: TextStyle(color: kPrimaryColor),
        ),
        actions: <Widget>[
          FlatButton(
              child: Text(
                "Clear",
                // style: TextStyle(color: Colors.yellow[900]),
              ),
              onPressed: () => ScopedModel.of<CartModel>(context).clearCart())
        ],
      ),
      body: ScopedModel.of<CartModel>(context, rebuildOnChange: true)
                  .cart
                  .length ==
              0
          ? Center(
              child: Text("No items in Cart"),
            )
          : Container(
              padding: EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: ScopedModel.of<CartModel>(context,
                            rebuildOnChange: true)
                        .total,
                    itemBuilder: (context, index) {
                      return ScopedModelDescendant<CartModel>(
                        builder: (context, child, model) {
                          return ListTile(
                            title: Text(model.cart[index].meal_name),
                            subtitle: Text(model.cart[index].quan.toString() +
                                " x " +
                                model.cart[index].price.toString() +
                                " = " +
                                (model.cart[index].quan *
                                        int.parse(model.cart[index].price))
                                    .toString()),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  model.updateProduct(model.cart[index],
                                      model.cart[index].quan + 1);
                                  // model.removeProduct(model.cart[index]);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  model.updateProduct(model.cart[index],
                                      model.cart[index].quan - 1);
                                  // model.removeProduct(model.cart[index]);
                                },
                              ),
                            ]),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Total:\u{20B9}" +
                          ScopedModel.of<CartModel>(context,
                                  rebuildOnChange: true)
                              .totalCartValue
                              .toString() +
                          "",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    color: Colors.yellow[900],
                    textColor: Colors.white,
                    elevation: 20,
                    child: Text("BUY NOW"),
                    onPressed: () {},
                  ),
                ),
              ]),
            ),
    );
  }
}
