import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_shop/api.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../global.dart';

class createCate extends StatefulWidget {
  @override
  _createCateState createState() => _createCateState();
}

class _createCateState extends State<createCate> {
  var nameController=TextEditingController();

  var picker=ImagePicker();
  File filee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: Expanded(
        child: Container(
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration:BoxDecoration(
                  image: DecorationImage(
                    image: checkPhoto()
                  )
                ),
                height:200,
                width: 200,
              ),
              RaisedButton(
                child: Text("Image Choice"),
                  onPressed: (){
                  getPhoto(context,ImageSource.camera);
                  }),
              TextFormField(controller: nameController,
                  decoration:InputDecoration(
                      labelText:"Category Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  )
              ),
              Row(children: [
                Spacer(),
                RaisedButton(
                    child: Text("upload Category"),
                    onPressed: ()async{
                     await Api.uploadImage(filee.path);
                     await Future.delayed(Duration(seconds: 3));

                     while(Global.profileList == null){
                       print("null");
                     }
                     print(Global.profileList.path.runtimeType);
                     Map <String,String> data={
                       "name":nameController.text,
                       "image":null
                     };
                     data["image"]=Global.profileList.path;
                     print(data);
                     var result=await Api.cateCreate(data);
                     if(result == true){
                       showAlert(context,"Category Created", "Go to categories page", 1);
                     }
                     else{
                       showAlert(context,"Error", "Connection error Or Sever error", 0);
                     }

                    }),
              ],)

            ],
          ),
        ),
      )),
    );
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
    filee=cropImage;
    setState(() {

    });
  }
  checkPhoto(){
    if(filee== null ){
      return AssetImage("assets/images/images.jpeg");
    }
    else{
      return FileImage(filee);
    }
  }

  showAlert(BuildContext context,String header,String body,int a) {

    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        if(a==0){
          Navigator.pop(context);
        }
        else{
          Navigator.pushNamed(context,"/home");
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
