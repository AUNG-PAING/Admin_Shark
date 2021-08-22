import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_shop/utils.dart';

import '../api.dart';
import '../global.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var phoneController= TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Here"),backgroundColor:fourthColor),
        body: Container(
          padding: EdgeInsets.all(30),
          color:firstColor,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneController,
              decoration: InputDecoration(
                labelText:"Phone No:",
                prefixIcon: Icon(Icons.phone,color: fourthColor,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
            ),
            SizedBox(height: 25,),


            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                  prefixIcon: Icon(Icons.lock,color: fourthColor,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  )
              ),
            ),
            SizedBox(height: 35,),
            Row(

              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,"/register");
                  },
                  child: Container(
                    width: 150,
                    child: Column(children: [
                      Text("Register here if you are not member !!!",style: TextStyle(color: fourthColor),),
                      SizedBox(height: 6,),
                      Container(height: 5,width: 200,color:fourthColor,)
                    ],),
                  ),
                ),
                Spacer(),
                GestureDetector(onTap: ()async{
                  String data=jsonEncode({
                    "phoneNo":phoneController.text,
                    "password":passwordController.text
                  });

                  bool bol=await Api.login(data);
                  if(bol){
                    print (Global.userData);
                    Navigator.pushReplacementNamed(context,"/home");
                  }
                  else{
                    phoneController.clear();
                    passwordController.clear();
                    Global.showAlertDialog(context,"Attention Please","သင်​၏ဖုန်းနံပါတ်နှင့်လျှို့ဝှက်နံပါတ်အားထပ်မံဖြည့်စွက်ပါ");
                  }
                },

                  child: Container(

                    child: Center(child: Text("Login",style: TextStyle(color: firstColor),)),

                    decoration: BoxDecoration(
                        color: fourthColor,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    width: 100,
                    height: 50,
                  ),
                ),
              ],
            )

          ],),
        ),
    );
  }

}
