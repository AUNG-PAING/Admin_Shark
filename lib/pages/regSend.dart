import 'package:flutter/material.dart';

import '../api.dart';
import '../global.dart';

class RegSend extends StatefulWidget {
  @override
  _RegSendState createState() => _RegSendState();
}

class _RegSendState extends State<RegSend> {
  SendPhotoAndReg()async{
    await Api.uploadImage(Global.UserRegPhoto.path);
    await Future.delayed(Duration(seconds: 3));
    if(Global.profileList != null){
//      Map <String,String> data={"profile":"${Global.profileList.path}"};
     Global.UserRegData["profile"]=Global.profileList.path;
     bool bol=await Api.Register(Global.UserRegData);

      if(bol){
        print("aung tal");
        pwAlert(context,"အထူးကျေးဇူးတင်ပါသည်","လူကြီးမင်း​၏စာရင်းပေးသွင်းမှုကိုလက်ခံရရှိပြီးဖြစ်ပါသဖြင့် လော့အင်စာမျက်နှာတွင်ဝင်ရောက်အသုံးပြုနိုင်ပါပြီ", 1);
      }
      if(bol==false){
        pwAlert(context,'Please','သင်​၏အချက်အလက်ဖြည့်သွင်းမှုမှာပြည့်စုံမှုမရှိပါထို့ကြောင့်လိုအပ်သည်ကိုထပ်မံဖြည့်စွက်ပါ',0);
      }
    }
    else{
      pwAlert(context,'Please','Check Your Network Connection',0);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SendPhotoAndReg();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(child: Text("Registering...Please wait !!!"))
          ],)
        ),
      ),
    );
  }
  pwAlert(BuildContext context,String header,String body,int a) {

    // set up the buttons
//    Widget cancelButton = FlatButton(
//      child: Text("Cancel"),
//      onPressed:  () {},
//    );

    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        if(a==0){
          Navigator.pushReplacementNamed(context,"/register");
        }
        else{
          Navigator.pushReplacementNamed(context,"/login");
        }
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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}


