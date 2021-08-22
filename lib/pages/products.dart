import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_shop/api.dart';
import 'package:home_shop/global.dart';
import 'package:home_shop/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'alert.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  File fileFo;
  var picker=ImagePicker();
  var nameController=TextEditingController();
  var descController=TextEditingController();
  var priceController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    bacKey(){
      Navigator.pushNamed(context,"/home");
    }
    return WillPopScope(
      // ignore: missing_return
      onWillPop:bacKey,
      child: Scaffold(
        appBar: AppBar(title: Text("Products"),leading:
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, "/home");
          },
          child: Container(
            child: Icon(

              Icons.home,size: 45,),
          ),
        ),
          backgroundColor: fourthColor,actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
//          color: Colors.black,
              child:Stack(children: [
                GestureDetector(
                    onTap: (){
                      print("i am here");
                      if(Global.userData==null){
                        Navigator.pushNamed(context,"/login");
                      }
                      else {
                        Navigator.pushNamed(context,"/postOrder");
                      }
                    },
                    child: Center(child: Icon(Icons.shopping_cart,size: 40,))),
                Positioned(
                  right:1,

                  child: Container(
                    height: 20,
                    width: 20,
                    child: Stack(children: [
                      Container(

                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      Center(child: Text(Global.orderList.length.toString()))
                    ],),),
                )
              ],),
            )
          ],
        ),
        body: FutureBuilder(future: Api.getProducts(Global.idForProdCre),
            builder: (context,pyanYa)=>pyanYa.hasData?
            RefreshIndicator(
              onRefresh: (){return Future.value(false);},
              child:
              ListView.builder(
                itemCount: Global.productList.length,
                itemBuilder: (context,ind){
                  return Card(
//            color: Colors.blue,
                    child: Container(
                      height: 150,
                      child:Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: NetworkImage(Global.productList[ind].image))
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(child: Container(
                            height: 130,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0,7,0,0),
                                  padding: EdgeInsets.fromLTRB(5,0,5,0),
                                  decoration: BoxDecoration(
                                      color:fourthColor,
                                      borderRadius: BorderRadius.circular(3)
                                  ),
                                  child:Text(
                                    Global.productList[ind].name,style: TextStyle(color: Colors.white,fontSize: 20),) ,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0,7,0,0),
                                  padding: EdgeInsets.fromLTRB(5,0,5,0),
                                  decoration: BoxDecoration(
                                      color:fourthColor,
                                      borderRadius: BorderRadius.circular(3)
                                  ),
                                  child:Text(
                                    Global.productList[ind].desc,style: TextStyle(color: Colors.white,fontSize: 20),) ,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: fourthColor,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                                  ),
                                  margin: EdgeInsets.fromLTRB(0,8,0,0),
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),

                                  height: 50,
                                  child: Row(children: [
                                    Container(
                                        child: Text('${Global.productList[ind].price} Ks',style: TextStyle(color: firstColor,fontSize: 20),)),
                                    Spacer(),
                                    Container(
                                        child: InkWell(
                                            onTap: (){
                                              Alerts.foeEditProduct =Global.productList[ind];
                                              Alerts().editAlertForProducts(context);
                                            },
                                            child: Icon(Icons.edit,color: Colors.pinkAccent,))
                                    ),
                                    SizedBox(width: 15,),
                                    GestureDetector(
                                      onTap: ()async{
                                        print(Global.productList[ind].id.runtimeType);
                                        await showAlertForDelete(context,Global.productList[ind].id);


                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(right: 7),
                                          child: Icon(Icons.delete,color:Colors.yellow,size: 30,)),
                                    )
                                  ],),
                                )
                              ],
                            ),
                          ),)
                        ],
                      ),
                    ),);
                },
              )
              ,):RefreshIndicator(
              onRefresh: ()async{
                await Api.getProducts(Global.idForProdCre);
                setState(() {

                });
              },
              child: Center(child: CircularProgressIndicator(),),
            )
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add,size: 50,),
            onPressed:(){uploadProduct(context, "hay","hey");}),
      ),
    );
  }
  check(id,index){
    print(Global.orderList.length);
    var existingItem=Global.orderList.firstWhere((element) => element.id == id,
      orElse: ()=>null
    );
    if(existingItem==null){
      Global.orderList.add(index);
    }
  }
  uploadProduct(BuildContext context,String header,String body) {

    Widget returnContainer = Container(
      height: 400,
      width: 400,
      color: Colors.white,
      child:Container(
        margin:EdgeInsets.only(left: 20,right: 20,top: 15),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(

                  labelText:"Name",border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(height: 8,),
            TextFormField(
              controller: descController,
              decoration: InputDecoration(

                  labelText:"Desc",border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(height: 8,),
            TextFormField(
              keyboardType:TextInputType.number ,
              controller: priceController,
              decoration: InputDecoration(

                  labelText:"Price",border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(height: 8,),
            Container(child:Row(children: [
              Container(decoration:BoxDecoration(
                image: DecorationImage(image: checkUploadFoto()),

              ),
                height: 70,width: 70,
              ),
              Spacer(),
              InkWell(
                  onTap: (){
                    getPhoto(context,ImageSource.gallery);


                  },
                  child: Icon(Icons.add_photo_alternate,size: 50,)),
            ],)),
            SizedBox(height: 8,),
            Container(
              child: Row(children: [
                FlatButton(
                  highlightColor: Colors.orange,
                  splashColor: Colors.white,
                  onPressed: (){
                    fileFo=null;
                    nameController.clear();
                    descController.clear();
                    priceController.clear();
                    Navigator.pop(context);},
                  child:Text("Cancel"),color:Colors.redAccent,),
                Spacer(),
                FlatButton(
//                  highlightColor: Colors.orange,
//                  splashColor: Colors.white,\
                  onPressed: ()async{
                    if(fileFo==null ){
                      showAlert(context,"Hay", "Photo");

                    }
                    else if(nameController.text.length==0){
                      showAlert(context,"Hay", "Name");
                    }
                    else if
                    (descController.text.length==0){
                      showAlert(context,"Hay", "Desc");

                    }else if(priceController.text.length==0){
                      showAlert(context,"Hay","How much ?");
                    }
                    else{
//                     await Api.uploadImage(fileFo.path);
                      showAlertUpLoad(context);
                    }


//                   Map<String,String> data ={
//                     "photo":Global.profileList.path,
//                     "price":priceController.text,
//                     "desc":descController.text,
//                     "name":nameController.text
//                   };
                  },
                  child:Text("Create"),color:Colors.blue,minWidth: 150,height: 60,)
              ],),
            )
          ],
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: fourthColor,
//      title: Text(header),
//      content: Text(body),
      actions: [
        returnContainer,
//        continueButton,
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
  checkUploadFoto(){
    if(fileFo==null){
      return AssetImage("assets/images/images.jpeg");
    }
    else{
      return FileImage(fileFo);
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
    fileFo=cropImage;
    Navigator.pop(context);
    uploadProduct(context,"hey", "Hey");
  }
  showAlert(BuildContext context,String header,String body) {

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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertUpLoad(BuildContext context) {

    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed:  ()async {
//        await Api.getProducts(Global.idForProdCre);

        Navigator.popAndPushNamed(context,"/product");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Finished"),
      content: Text("Product is created"),
      actions: [
        continueButton,
      ],
    );


    Widget Button = Center(child:CircularProgressIndicator());

    // set up the AlertDialog
    AlertDialog alert2 = AlertDialog(
      title: Text("Please Wait !!!"),
      actions: [
        Button,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {

        return FutureBuilder(
            future: uploadPhotoAndCrateP(fileFo.path),
            builder: (context,pyanya)=>pyanya.hasData?
            RefreshIndicator(
              child: alert,onRefresh: ()async{
              return Future.value(false);
            },
            ):
            RefreshIndicator(
              child: alert2,onRefresh: ()async{
//                    print("INININI");
              await uploadPhotoAndCrateP(fileFo.path);
              print("ya tal");
//                    await Future.delayed(Duration(seconds: 10));
//
//                    Map<String,String> data ={"photo":Global.profileList.path, "price":priceController.text,
//                      "desc":descController.text, "name":nameController.text,"cateId":Global.idForProdCre};
//                    bool a=await Api.createProduct(data);
              setState(() {

              });
            },
            )
        );
      },
    );
  }
uploadPhotoAndCrateP(photo)async{
    Api.uploadImage(photo);
    await Future.delayed(Duration(seconds: 4));
    Map<String,String> data ={"image":Global.profileList.path, "price":priceController.text,
      "desc":descController.text, "name":nameController.text,"cateId":Global.idForProdCre};
    bool a=await Api.createProduct(data);
    return a;
}

showAlertForDelete(BuildContext context,id) async{

    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        Navigator.pop(context);
        loadAlertProductDelete(context, id);

      },
    );
    Widget cancelButton=FlatButton(
      child: Text("Cancel"),
      onPressed: (){
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hey"),
      content: Text("Are you sure product item ???"),
      actions: [
        cancelButton,
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

  loadAlertProductDelete(BuildContext context,id)async {
    print("hhhhhhh");
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed:  ()async {

        Navigator.pop(context,true);
        setState(() {

        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Finished"),
      content: Text("Product is Deleted"),
      actions: [
        continueButton,
      ],
    );


    Widget Button = Center(child:CircularProgressIndicator());

    // set up the AlertDialog
    AlertDialog alert2 = AlertDialog(
      title: Text("Please Wait !!!"),
      actions: [
        Button,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {

        return FutureBuilder(
            future: Api.updateProductObject(id,Global.statusChangeObject),
            builder: (context,pyanya)=>pyanya.hasData?
            RefreshIndicator(
              child: alert,onRefresh: (){
              return Future.value(false);
            },
            ):
            RefreshIndicator(
              child: alert2,onRefresh: ()async{
//                    print("INININI");
              await Api.updateProductObject(id,Global.statusChangeObject);
              print("ya tal");
//                    await Future.delayed(Duration(seconds: 10));
//
//                    Map<String,String> data ={"photo":Global.profileList.path, "price":priceController.text,
//                      "desc":descController.text, "name":nameController.text,"cateId":Global.idForProdCre};
//                    bool a=await Api.createProduct(data);
              setState(() {

              });
            },
            )
        );
      },
    );
  }

}



//static addToCart(ProductModel product) {
//  var existingItem = orderList
//      .firstWhere((element) => element.id == product.id, orElse: () => null);
//
//  if (existingItem == null) {
//    orderList.add(product);
//  }
//  return orderList.length;
//}