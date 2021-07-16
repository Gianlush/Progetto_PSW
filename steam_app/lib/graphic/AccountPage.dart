
import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:steam_app/model/Model.dart';
import 'package:steam_app/model/objects/GamePerOrder.dart';
import 'package:steam_app/model/objects/Order.dart';
import 'package:steam_app/model/objects/User.dart';
import 'package:steam_app/model/utility/LogInResult.dart';
import 'package:steam_app/model/widget/MyInputField.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountPageState();
  }
}

class AccountPageState extends State<AccountPage>{

  static User user ;
  static bool logged = false;
  static bool correctCredentials = true;
  static bool forcedLogout = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if(forcedLogout)
      return ErrorView("SESSIONE EXPIRED! \n \n Login again!");
      
    else if(!correctCredentials){
      return ErrorView("WRONG CREDENTIALS!");
    }
    else if(logged){
      return LoggedView();
    }
    else
      return LoggingView();
  }

  Widget LoggingView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            child: Icon(Icons.shopping_basket_outlined,size: 300, color: Colors.deepPurple),
            padding: EdgeInsets.fromLTRB(0, 200, 0, 0)
        ),
        Padding(
            child: Text("Welcome!", style: TextStyle(color: Colors.deepPurple, fontSize: 30),),
            padding: EdgeInsets.all(20)
        ),
        Flexible(child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            width: 500,
            child: MyInputField(text: "Email", controller: emailController,))
        ),
        Flexible(child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            width: 500,
            child: MyInputField(text: "Password", controller: passwordController, isPassword: true))
        ),
        Container(
          width: 103,
          child: RawMaterialButton(
              onPressed: () => login(),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
              fillColor: Colors.deepPurple,
              child: Padding(
                padding: EdgeInsets.all(22),
                child: Row(
                  children: [
                    Text("Login", style: TextStyle(color: Colors.white)),
                    Icon(Icons.login_outlined)
                  ],
                ),
              )
          ),
        )
      ],
    );
  }

  Widget LoggedView(){
    searchOrders();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(400, 30, 0, 40),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: ShapeDecoration(color: Colors.deepOrangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              child: Text("Personal information: ", style: TextStyle(color: Colors.white, fontSize: 33)),
            )),
        ]),
        Container(
          height: 150,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ", style: TextStyle(fontSize: 18)),
                        myText(user.name)
                      ]
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Surname: ", style: TextStyle(fontSize: 18)),
                        myText(user.surname)
                      ]
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: ", style: TextStyle(fontSize: 18)),
                        myText(user.email),
                      ]
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 12),
                  child: RawMaterialButton(
                      onPressed: () => logout(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                      fillColor: Colors.deepOrangeAccent,
                      child: Padding(
                        padding: EdgeInsets.all(22),
                        child: Row(
                          children: [
                            Text("Logout", style: TextStyle(color: Colors.white)),
                            Icon(Icons.logout)
                          ],
                        ),
                      )
                  ),
                )
              ]),
        ),
        Row(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(400, 30, 20, 40),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: ShapeDecoration(color: Colors.deepOrangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    child: Text("Order history: ", style: TextStyle(color: Colors.white, fontSize: 33)),
                  )),
              Container(
                decoration: ShapeDecoration(shape: CircleBorder(), color: Colors.deepOrangeAccent),
                child: IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () => searchOrders()),
              )
            ]
        ),
        Flexible(child: ListOrder())
      ],
    );
  }

  Widget ErrorView(String message){
    return Padding(
        padding: EdgeInsets.fromLTRB(20,450,20,20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(message, style: TextStyle(fontSize: 35)),
            RawMaterialButton(
              onPressed: () {setState(() {correctCredentials = true; forcedLogout = false;});},
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
              fillColor: Colors.deepPurple,
              child: Text("OK", style: TextStyle(color: Colors.white),),
            )
          ],
        )
    );
  }

  static forceLogout(){
    logged = false;
    user = null;
    correctCredentials = true;
    forcedLogout = true;
  }

  logout() {
    Model.sharedInstance.logOut();
    setState(() {
      logged = false;
      user = null;
      correctCredentials = true;
    });
  }

  login() {
    String email = emailController.text;
    String password = passwordController.text;
    Model.sharedInstance.logIn(email, password).then((value) {
      if(value == LogInResult.logged){
        Model.sharedInstance.getUserByEmail( User(email: email) ).then((value) {
          user=value;
          searchOrders();
          setState(() {
            logged = true;
            correctCredentials = true;
          });
        });
        emailController.text="";
        passwordController.text="";
      }
      else if(value == LogInResult.error_wrong_credentials){
        setState(() {
          logged = false;
          correctCredentials = false;
        });
      }
    });
  }

  searchOrders(){
    Model.sharedInstance.searchOrder(user).then((value) {
      setState(() {
        user.orders=value;
      });
    });
  }

  Widget ListOrder(){
    if(user.orders!=null && user.orders.isNotEmpty) {
      return Container(
        width: 500,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: user.orders.length,
            itemBuilder: (context, index) {
              Order o = user.orders[index];
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: ShapeDecoration(color: Colors.deepPurple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Order placed on: ", style: TextStyle(color: Colors.blue, fontSize: 15)),
                                Text("${o.shopDate.day}/${o.shopDate.month}/${o.shopDate.year}", style: TextStyle(color: Colors.white, fontSize: 18),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Total: ",style: TextStyle(color: Colors.blue, fontSize: 15)),
                                Text("${o.total}€", style: TextStyle(color: Colors.white, fontSize: 18),),
                              ],
                            )
                          ],

                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: o.gamePerOrder.length,
                            itemBuilder: (context, index) {
                              return GamePerOrderView(o.gamePerOrder[index],o);
                            })
                      ]
                  ),
                ),
              );
            }
        ),
      );
    }
    else {
      return Text("NO ORDER YET!", style: TextStyle(color: Colors.black, fontSize: 30));
    }
  }

  Widget GamePerOrderView(GamePerOrder gamePerOrder, Order order){
    return Container(
      padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Purchase: ",style: TextStyle(color: Colors.white, fontSize: 15),),
          Text(gamePerOrder.game.name, style: TextStyle(color: Colors.greenAccent, fontSize: 20),),
          Text(order.paymentMethod, style: TextStyle(color: Colors.greenAccent, fontSize: 20)),
          Text(gamePerOrder.game.price.toString()+"€", style: TextStyle(color: Colors.greenAccent, fontSize: 20))
        ],
      ),
    );
  }

  Widget myText(String value) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0,10,0,0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.deepPurple
        ),
        child: Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 27),
        ),
      ),
    );
  }
}
