import 'package:flutter/material.dart';
import 'package:home_shop/api.dart';

class SendOrder extends StatefulWidget {
  @override
  _SendOrderState createState() => _SendOrderState();
}

class _SendOrderState extends State<SendOrder> {
  Send()async{
    bool bol=await Api.sendOrder();
    await Future.delayed(Duration(seconds: 5));
    if(bol==true){
      Navigator.pushReplacementNamed(context,"/thank");
    }
    else{
      setState(() {

      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Send();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
                width: 200,
                decoration:BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/sending.jpg")))),
          SizedBox(height: 50,),
          Container(child: Text("Order Sending...Please wait",style: TextStyle(fontSize: 20),))
        ],),
      ) ,);
  }
}
