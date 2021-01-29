import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping/screen/cartpage.dart';
import 'package:shopping/constant.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {},
    ),
    title: RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(text: "ZEP", style: TextStyle(color: ksecondaryColor)),
          TextSpan(text: "Food", style: TextStyle(color: kPrimaryColor)),
        ],
      ),
    ),
    actions: [
      IconButton(
          icon: Icon(
            Icons.add_shopping_cart,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CartPage()));
          })
    ],
  );
}
