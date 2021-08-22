import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_shop/api.dart';
import 'package:home_shop/models/Catemodels.dart';
import 'package:home_shop/models/Profile.dart';
import 'package:home_shop/models/productModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../global.dart';


class Alerts{

  var tControl=TextEditingController();

  var pNameControl=TextEditingController();
  var pPriceControl=TextEditingController();
  var pDescControl=TextEditingController();
  static CategoryModel forEditCategory;
  static ProductModels foeEditProduct;
  var picker=ImagePicker();

  editAlertForCategory(context){
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text("Category Edit Box"),
            content: Container(
              height: 240,
              child: Column(
                children: [
                  TextFormField(
                    controller:tControl,
                    decoration: InputDecoration(border:OutlineInputBorder(borderRadius:BorderRadius.circular(5)),
                        hintText: forEditCategory.name ),
                  ),

                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            image:DecorationImage(image:Global.fileImageForImageUpdate !=null ? FileImage(Global.fileImageForImageUpdate ):NetworkImage(forEditCategory.image)),
                            borderRadius: BorderRadius.circular(10),

//                  shape: BoxShape.circle
                          ),

                          height:120,
                          width: 120

                      ),
                      Spacer(),
                      InkWell(
                        onTap:()async{
                          await showDialog(context: context, builder:
                          (BuildContext context){
                            return AlertDialog(
                              title:Text(" For Image"),
                              content:Container(
                                height: 80,
                                width: 150,
                                child: Row(children: [
                                  InkWell(
                                      child: Icon(Icons.image),
                                    onTap: ()async{
                                     await  getPhoto(context,ImageSource.gallery);
                                      Navigator.pop(context,true);
                                    },
                                  ),
                                  InkWell(child: Icon(Icons.camera_alt),
                                      onTap: ()async{
                                    await getPhoto(context,ImageSource.camera);
                                    Navigator.pop(context,true);
                                      }
                                      )
                                ],),
                              )
                            );

                          }
                          );
                          Alerts().editAlertForCategory(context);

                        },
                          child: Icon(Icons.add_photo_alternate,size: 80,color: Colors.blue,))
                    ],
                  )
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context,"/home");
                },
                child: Text("Back"),),
              FlatButton(
                onPressed: ()async{
                  Navigator.pop(context);
                  showDialog(context: context,
                      builder:((BuildContext context){
                        return FutureBuilder(
                            future: checkImageAndUploadForCateUpdate(),
                            builder:(context,snapShot)=>snapShot.hasData ?
                                RefreshIndicator(child: AlertDialog(
                                  title: Text("Updated Category"),
                                  actions: [
                                    FlatButton(onPressed:(){
                                      Navigator.pushReplacementNamed(context,"/home");
                                    }, child:Text("Ok"))
                                  ],
                                ), onRefresh:(){
                                  return Future.value(false);
                                }):
                            RefreshIndicator(child:

                            AlertDialog(
                              title: Text("Wait"),
                              content: CircularProgressIndicator(),
                            )
                                , onRefresh:()async{
                              await checkImageAndUploadForCateUpdate();
                            })

                        );
                      })
                  );
                },
                child: Text("To Edit"),),
            ],
          )
          ;
        }
    );
  }
  checkImageAndUploadForCateUpdate()async{
    if(Global.fileImageForImageUpdate == null){
      Map <String,String> body={
        "name":tControl.text.length > 0 ? tControl.text :forEditCategory.name,
        "image":forEditCategory.image
      };
      bool bol=await Api.updateCategoryBody(forEditCategory.id, body);

      return bol;
    }
    else{
      await Api.uploadImage(Global.fileImageForImageUpdate.path);
      await Future.delayed(Duration(seconds: 5));
      Map <String,String> body={
        "name":tControl.text.length > 0 ? tControl.text :forEditCategory.name,
        "image":Global.profileList.path
      };

      bool bol=await Api.updateCategoryBody(forEditCategory.id, body);
      Global.profileList=null;
      return bol;


    }
  }



  editAlertForProducts(context){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text("Products Edit Box"),
            content: Container(
//              color: Colors.pink,
              height: 380,
              child: Column(
                children: [
                  TextFormField(
                    controller:pNameControl,
                    decoration: InputDecoration(border:OutlineInputBorder(borderRadius:BorderRadius.circular(5)),
                        hintText: foeEditProduct.name ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller:pPriceControl,
                    decoration: InputDecoration(border:OutlineInputBorder(borderRadius:BorderRadius.circular(5)),
                        hintText: foeEditProduct.price ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller:pDescControl,
                    decoration: InputDecoration(border:OutlineInputBorder(borderRadius:BorderRadius.circular(5)),
                        hintText: foeEditProduct.desc ),
                  ),

                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            image:DecorationImage(image:Global.fileImageForImageUpdate !=null ? FileImage(Global.fileImageForImageUpdate ):NetworkImage(foeEditProduct.image)),
                            borderRadius: BorderRadius.circular(10),

//                  shape: BoxShape.circle
                          ),

                          height:120,
                          width: 120

                      ),
                      Spacer(),
                      InkWell(
                          onTap:()async{

                            await showDialog(
                                barrierDismissible: false,
                                context: context, builder:
                                (BuildContext context){
                              return AlertDialog(
                                  title:Text(" For Image"),
                                  content:Container(
                                    height: 80,
                                    width: 150,
                                    child: Row(children: [
                                      InkWell(
                                        child: Icon(Icons.image,size: 80,color: Colors.cyan,),
                                        onTap: ()async{

                                          await  getPhoto(context,ImageSource.gallery);
                                          Navigator.pop(context,true);

                                        },
                                      ),
                                      Spacer(),
                                      InkWell(child: Icon(Icons.camera_alt,size: 80,color:Colors.cyan,),
                                          onTap: ()async{

                                            await getPhoto(context,ImageSource.camera);
                                            Navigator.pop(context,true);

                                          }
                                      )
                                    ],),
                                  )
                              );


                            }

                            );
                            Alerts().editAlertForProducts(context);
                          },
                          child: Icon(Icons.add_photo_alternate,size: 80,color: Colors.blue,))
                    ],
                  )
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);

                },
                child: Text("Back"),),
              FlatButton(
                onPressed: ()async{

                  showDialog(context: context,
                      barrierDismissible: false,
                      builder:((BuildContext context){
                        return FutureBuilder(
                            future: checkImageAndUploadForProductsUpdate(),
                            builder:(context,snapShot)=>snapShot.hasData ?
                            RefreshIndicator(child: AlertDialog(
                              title: Text("Updated Product"),
                              actions: [
                                FlatButton(onPressed:(){
                                  Navigator.pushNamed(context,"/product");
                                }, child:Text("Ok"))
                              ],
                            ), onRefresh:(){
                              return Future.value(false);
                            }):
                            RefreshIndicator(child:

                            AlertDialog(
                              title: Text("Wait"),
                              content: CircularProgressIndicator(),
                            )
                                , onRefresh:()async{
                                  await checkImageAndUploadForProductsUpdate();
                                })

                        );
                      })
                  );
                },
                child: Text("To Edit"),),
            ],
          )
          ;
        }
    );
  }
  checkImageAndUploadForProductsUpdate()async{
    if(Global.fileImageForImageUpdate == null){
      Map <String,String> body={
        "name":pNameControl.text.length > 0 ? pNameControl.text :foeEditProduct.name,
        "price":pPriceControl.text.length >0 ? pPriceControl.text :foeEditProduct.price,
        "desc":pDescControl.text.length > 0 ? pDescControl.text: foeEditProduct.desc,
      };
      bool bol=await Api.updateProductObject(foeEditProduct.id, body);

      return bol;
    }

    else{

      await Api.uploadImage(Global.fileImageForImageUpdate.path);
      await Future.delayed(Duration(seconds: 3));
      Map <String,String> body={
        "name":pNameControl.text.length > 0 ? pNameControl.text :foeEditProduct.name,
        "price":pPriceControl.text.length >0 ? pPriceControl.text :foeEditProduct.price,
        "desc":pDescControl.text.length > 0 ? pDescControl.text: foeEditProduct.desc,
        "image":Global.profileList.path
      };

      bool bol=await Api.updateProductObject(foeEditProduct.id, body);
      Global.profileList=null;
      return bol;
    }
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
    Global.fileImageForImageUpdate=cropImage;
  }





  }
