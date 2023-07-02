import 'package:flutter/material.dart';

void main() {
  final bool search = true;
  final bool products = true;
  final bool lenght = true;
  search ?
    products ?
      print("1") :
          lenght ?
            print("2"):
              print("3"):
      print("4");

  if(search){
    if(products)
      print("1");
    else if(lenght)
      print("2");
    else
      print("3");
  } else
    print("4");
}

