

import 'package:flutter/material.dart';
import 'package:home_shop/pages/Register.dart';
import 'package:home_shop/pages/Thank.dart';
import 'package:home_shop/pages/createCate.dart';
import 'package:home_shop/pages/flash.dart';
import 'package:home_shop/pages/history.dart';
import 'package:home_shop/pages/home.dart';
import 'package:home_shop/pages/kaungLogin.dart';
import 'package:home_shop/pages/login.dart';
import 'package:home_shop/pages/orderSending.dart';
import 'package:home_shop/pages/postOrder.dart';
import 'package:home_shop/pages/products.dart';
import 'package:home_shop/pages/regSend.dart';
import 'package:home_shop/pages/reload.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/":(context)=>Flash(),
      "/home":(context)=>Home(),
      "/product":(context)=>Product(),
      "/login":(context)=>Login(),
      "/register":(context)=>Register(),
      "/postOrder":(context)=>postOrder(),
      "/thank":(context)=>Thank(),
      "/reload":(context)=>Reload(),
      "/history":(context)=>History(),
      "/sendOrder":(context)=>SendOrder(),
      "/RegSend":(context)=>RegSend(),
      "/createCate":(context)=>createCate()

    },
  ));
}

