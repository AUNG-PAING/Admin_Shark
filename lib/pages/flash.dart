import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_shop/utils.dart';

import '../api.dart';

class Flash extends StatefulWidget {
  @override
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  loadPage()async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context,"/home");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPage();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
//        color: Colors.blue,
          child: Column(children: [
            Expanded(
              child: Container(
                width: 2000,
                color:Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 300,
                        width: 300,
                        child:Image.asset("assets/images/shark2.jpg",)),
//                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                        child: Text("ငမန်းကြီး",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color:Colors.red[900]),)),
                    Text("အေးခဲအစားအသောက်နှင့်ပင်လယ်စာအမျိုးမျိုးဖြန့်ချီရေး",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
//                    0xff529CC8
                    SizedBox(height: 70),
                    CircularProgressIndicator(strokeWidth: 3,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),backgroundColor:Color(0xff529CC8),),
                  ],
                ),
              ),
            ),

          ],),
        ),
      ),
    );
  }
}
