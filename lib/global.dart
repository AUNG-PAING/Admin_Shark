import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_shop/models/AllOrderModel.dart';
import 'package:home_shop/models/Catemodels.dart';
import 'package:home_shop/models/Profile.dart';
import 'package:home_shop/models/UserModel.dart';
import 'package:home_shop/models/productModel.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Global{
  static String BASE_URL="http://192.168.1.10:3000";
  static Map <String, String> headers = {"content-type": "application/json"};

  static Map <String,String> TokenHeader={
    "content-type":"application/json",
    "authorization":"Bearer ${userData.token}"
  };
  static  Map <String,int> statusChangeObject= {"status":0};
  static List<CategoryModel> cateList;
  static List<ProductModels> productList;
  static List orderList=[];
  static UserModel userData;
  static var photo;
  static ProfileModel profileList;
  static Map <String,String> UserRegData;
  static File UserRegPhoto;
  static List<AllOrderModels> allOrder=[];
  static var idForProdCre;
  static File fileImageForImageUpdate;


  static showAlertDialog(BuildContext context,String header,String body) {

    // set up the buttons
//    Widget cancelButton = FlatButton(
//      child: Text("Cancel"),
//      onPressed:  () {},
//    );

    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(header),
      content: Text(body),
      actions: [
//        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static loadtoOrderMap(){
    List <Map>order=[];
    orderList.forEach((element) {
      Map<String,String> map=new Map<String,String>();
      map["productId"]=element.id;
      map["productName"]=element.name;
      map["count"]=element.count.toString();
      map['price']=element.price;
      order.add(map);
    });
    return order;
//    order.forEach((element) {
//      print(element);
//    });
  }
}