
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_shop/api.dart';
import 'package:home_shop/global.dart';
import 'package:home_shop/utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var picker=ImagePicker();
  File file;

  var nameController=TextEditingController();
  var passController=TextEditingController();
  var conpassController=TextEditingController();
  var phoneController=TextEditingController();
  var addressController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title:
          Text("Register Here"),backgroundColor:fourthColor,),
        body: CustomScrollView(slivers: <Widget>[SliverToBoxAdapter(
          child:Expanded(
            child: Container(
              height: 740,
            child: Column(children: [

              Container(
                margin: EdgeInsets.only(top: 20),
//                color: Colors.yellow,
                child: Stack(children: [
                  GestureDetector(
                    onTap: ()async{
//                  await getPhoto(context,ImageSource.gallery);
                      showAlertDialog(context,"You can be choose !!!","Camera or Gallery"
                      );
                      setState(() {

                      });
                    },
                    child: ClipOval(
                      child: Container(
                        height: 150,
                        child: CheckIconOrPhoto(),
                        width:150,),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: (){
                        showAlertDialog(context,"You can be choose !!!","Camera or Gallery"
                        );
                        setState(() {

                        });
                      },
                      child: Icon(Icons.camera,size: 50,color: fourthColor,)
                    ),
                  )
                ],
                ),
              ),
              Expanded(child: Container(
                margin: EdgeInsets.fromLTRB(20,0,20,0),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                        controller: nameController,
                        decoration:InputDecoration(
                            labelText:"Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        )
                    ),
                    SizedBox(height:40,),
                    TextFormField(
                        controller: addressController,
                        decoration:InputDecoration(
                            labelText:"Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        )
                    ),
                    SizedBox(height: 40,),
                    TextFormField(
                        controller: phoneController,
                        decoration:InputDecoration(
                            labelText:"Phone No",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        )
                    ),
                    SizedBox(height: 40,),
                    TextFormField(
                        controller: passController,
                        decoration:InputDecoration(
                            labelText:"Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        )
                    ),
                    SizedBox(
                      child: Text("Please type same password",style: TextStyle(color: fourthColor),),
                      height: 20,),
                    TextFormField(
                        controller: conpassController,
                        decoration:InputDecoration(
                            labelText:"Confirm Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        )
                    ),
                    SizedBox(

                      height: 40,),
                    GestureDetector(
                      onTap: (){
                        print("I am here");
                        ComfirmPassAndReg(file);

                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Register Me",style: TextStyle(fontSize: 25,color: firstColor),),],
                        ),
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: fourthColor,
                            borderRadius: BorderRadius.circular(20)
                        ),),
                    )
                  ],),
              ))
            ],),
        ),
          ),)],)
      ),
    );
  }


  CheckIconOrPhoto() {
    if(file==null){
      return Icon(Icons.person_add,color: Colors.grey,size: 153,);
    }
    else return Image.file(file);
  }

  Future <void> getPhoto(context,source)async{

    final image=await picker.getImage(source: source,imageQuality: 30);
    var cropImage=await ImageCropper.cropImage(
        sourcePath:image.path,
       aspectRatio: CropAspectRatio(ratioX: 1,ratioY: 1),
       compressFormat: ImageCompressFormat.jpg,
       compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
       androidUiSettings: AndroidUiSettings(
        toolbarTitle: "cropper",
      )
    );
//    print(cropImage.runtimeType);
//    print(cropImage.path.runtimeType);
    file=cropImage;
    Global.UserRegPhoto=file;
    setState(() {

    });
  }

  showAlertDialog(BuildContext context,String header,String body) {

//    Widget continueButton = FlatButton(
//      child: Text("Ok"),
//      onPressed:  () {
//        Navigator.pop(context);
//      },
//    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(header),
      content: Text(body),
      actions: [
//        cancelButton,
      Container(

        child: Row(children: [
        IconButton(icon:Icon(Icons.camera), onPressed:()async{
          await getPhoto(context,ImageSource.camera);
          Navigator.pop(context);
        },iconSize: 70,),
        IconButton(icon:Icon(Icons.photo), onPressed:()async{
          await getPhoto(context,ImageSource.gallery);
          Navigator.pop(context);
        },iconSize: 70)
      ],),)
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

  ComfirmPassAndReg(file)async{
    var a =passController.text;
    var b =conpassController.text;
//    print(b.runtimeType);
    if(Global.UserRegPhoto==null){
      pwAlert(context,'Please','ဓာတ်ပုံနှင့်အတူ သင်၏အချက်အလက်များအား ဖြည့်စွက်ပါ။',0);
    }
    if(a.length!= 0 && b.length!=0 && a==b){
      Map<String,String> data={
        "name":nameController.text,
//        "profile":null,
        "password":conpassController.text,
        "phoneNo":phoneController.text,
        "address":addressController.text
      } ;
      Global.UserRegData=data;
      Navigator.pushReplacementNamed(context,"/RegSend");

    }
    else {
      pwAlert(context,'Please','လျှို့ဝှက်နံပါတ်နှစ်ခုမှာ တူညီမှုမရှိပါသဖြင့်ပြန်လည်ဖြည့်စွက်ပါ',0);
      conpassController.clear();

    }

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
          Navigator.pop(context);
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
//      bool bol =await Api.Register(data);
//      if(bol){
//        print("aung tal");
//        pwAlert(context,"အထူးကျေးဇူးတင်ပါသည်","လူကြီးမင်း​၏စာရင်းပေးသွင်းမှုကိုလက်ခံရရှိပြီးဖြစ်ပါသဖြင့် လော့အင်စာမျက်နှာတွင်ဝင်ရောက်အသုံးပြုနိုင်ပါပြီ", 1);
//      }
//      if(bol==false){
//        pwAlert(context,'Please','သင်​၏အချက်အလက်ဖြည့်သွင်းမှုမှာပြည့်စုံမှုမရှိပါထို့ကြောင့်လိုအပ်သည်ကိုထပ်မံဖြည့်စွက်ပါ',0);
//      }

