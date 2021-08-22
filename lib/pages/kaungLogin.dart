import 'package:flutter/material.dart';

class KaungLogin extends StatefulWidget {
  @override
  _KaungLoginState createState() => _KaungLoginState();
}

class _KaungLoginState extends State<KaungLogin> {
  var a=0;

  var fistNum=TextEditingController();
  var sec=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
//        height: 500,
//        width: 300,
        margin: EdgeInsets.all(50),
        padding: EdgeInsets.all(30),
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(a.toString()),
            TextFormField(
              controller: fistNum,
            ),
            SizedBox(height: 30,),
            TextFormField(
              controller: sec,
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    var a =int.parse(fistNum.text);
                    var b= int.parse(sec.text);
                    plus(a,b);
                    setState(() {

                    });
                  },
                  child: Container(
                    color: Colors.black,
                    height: 40,width: 100,
                  child: Center(child: Text("plus",style: TextStyle(color: Colors.yellow,fontSize:30),)),),
                ),
                Spacer(),
                RaisedButton(onPressed: (){
                  var a =int.parse(fistNum.text);
                  var b= int.parse(sec.text);
                  plus(a,b);
                  setState(() {

                  });
                },
                  child: Text("Register"),),
              ],
            )
          ],),
      ),
    );
  }
  plus(x,y){
    a=x+y;
  }
}
