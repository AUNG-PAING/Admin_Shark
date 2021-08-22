import 'package:flutter/material.dart';

import '../api.dart';
import '../global.dart';
import '../utils.dart';

class Thank extends StatefulWidget {
  @override
  _ThankState createState() => _ThankState();
}

class _ThankState extends State<Thank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Expanded(
          child: Container(
            color: fourthColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(70),topRight:Radius.circular(50),bottomRight: Radius.circular(70) )
                    ),
                    width: 350,
                    height: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      Container(
                        width: 200,
                        height: 139,
                        decoration: BoxDecoration(
                          image: DecorationImage(image:AssetImage("assets/images/shark.jpg"))
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        width: 300,

                        child: Text("သင်၏ ကုန်ပစ္စည်း အမှာစာအား    ငါးမန်းကြီး မှ လက်ခံရရှိပါသည်။  အထူးကျေးဇူးတင်ပါသည်",
                          style: TextStyle(color: Colors.white,fontSize: 18),),
                        decoration: BoxDecoration(
                            color: fourthColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20),topLeft: Radius.circular(20))
                        ),
                      )
                    ],

                    ),
                  ),
                  SizedBox(height: 60,),
                  InkWell(
                    onTap: () async {
                      Navigator.pushReplacementNamed(context,"/history");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Go to Orders Page",style: TextStyle(fontSize: 20,color: thirdColor),),
                        Icon(Icons.touch_app,size: 30,color: Colors.pinkAccent,)
                      ],),
                      width: 350,height: 50,
                      decoration: BoxDecoration(color: Color(0xffF6F5F6),
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                    ),
                  )
                ],),
            ),

          ),
        ),
      )
    );

  }
}
