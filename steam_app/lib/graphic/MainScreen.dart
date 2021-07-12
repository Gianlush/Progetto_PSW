import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steam_app/model/utility/Constants.dart';

import 'AccountPage.dart';
import 'CartPage.dart';
import 'LibraryPage.dart';
import 'ShopPage.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _mainScreenState();
  }
}
class _mainScreenState extends State<MainScreen>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(Constants.TITLE_APP),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: "Shop", icon: Icon(Icons.search_rounded)),
                Tab(text: "Account",icon: Icon(Icons.account_circle_outlined)),
                Tab(text: "Cart",icon: Icon(Icons.shopping_cart_sharp))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ShopPage(),
              AccountPage(),
              CartPage()
            ],
          ),
        )
      );
  }

}