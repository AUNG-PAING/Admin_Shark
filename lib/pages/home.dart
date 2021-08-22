import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_shop/api.dart';
import 'package:home_shop/global.dart';
import 'package:home_shop/pages/alert.dart';
import 'package:home_shop/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(

      body:FutureBuilder(
          future: Api.getCategoty(),
          builder:(context,snapshot)=>snapshot.hasData ?
          RefreshIndicator(
            child: SafeArea(child:
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                Container(
                    color:fourthColor,
                    height:60,
                    width: MediaQuery.of(context).size.width,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40 ,
                          color: fourthColor,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context,"/history");
                            },
                            child: Container(

                              padding: EdgeInsets.all(10),
//                    height: 20,
//                    width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(image:checkImage()),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(child: Text(checkName(),style: TextStyle(color: Colors.white),),width: 150,),
                        SizedBox(width: 55),
                        checkLoginLogo(),
                        SizedBox(width: 20,),
                        chart()

                      ],)),
                Expanded(
                  child: Container(
                    color:Colors.blue[50],
                    child: GridView.builder(itemCount: Global.cateList.length
                        ,gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0.05,
                          crossAxisSpacing: 0.05,
                        ), itemBuilder:(context,ind){
                          print(Global.cateList[ind].image);
                          return Card(
                            elevation: 5,
                            child: InkResponse(
                              highlightColor: Colors.deepPurple.withOpacity(1),
                              splashColor: Colors.lightGreenAccent,
                              onTap:()async{
                                Global.idForProdCre=Global.cateList[ind].id;
//                                    await Api.getProducts(Global.cateList[ind].id);

                                Navigator.pushNamed(context,"/product");
                              },
                              child: Container(
//                                    width: 200,
//                                    height: 100,
                                decoration: BoxDecoration(
                                  color: firstColor,
                                  borderRadius: BorderRadius.circular(5),),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                color: fourthColor,
                                                borderRadius:BorderRadius.circular(5)),

                                            margin: EdgeInsets.fromLTRB(17,5,0,0),
                                            padding: EdgeInsets.fromLTRB(3,1,3,0),
//                        color: fourthColor,
                                            height: 20,
                                            child: Text(Global.cateList[ind].name,style: TextStyle(color:firstColor),)),
                                        Spacer(),
                                        InkWell(
                                            onTap: ()async{
                                              Alerts.forEditCategory=null;
                                              Global.fileImageForImageUpdate=null;

                                              Alerts.forEditCategory=Global.cateList[ind];
                                              await Alerts().editAlertForCategory(context);
                                              setState(() {
                                              });
                                            },
                                            child: Icon(Icons.edit,color:Colors.blue,)),
                                        InkWell(
                                          onTap: ()async{
                                            deleteCheckForCategories(Global.cateList[ind].id, context);
                                          },
                                            child: Icon(Icons.delete,color:Colors.pinkAccent,))
                                      ],
                                    ),
                                    SizedBox(height: 5,),

                                    Container(
                                      decoration: BoxDecoration(
                                        image:DecorationImage(image:NetworkImage(Global.cateList[ind].image)),
                                        color: thirdColor,
                                        borderRadius: BorderRadius.circular(10),
//                  shape: BoxShape.circle
                                      ),

                                      height: MediaQuery.of(context).size.height-682,
                                      width: MediaQuery.of(context).size.width-250,

                                    )
                                  ],),
                              ),
                            ),);
                        }),
                  ),
                )
              ],),
            )
            ),
            onRefresh: (){
              return Future.value(false);
            },
          ):
          RefreshIndicator(child:Center(child: CircularProgressIndicator(),), onRefresh:()async{
            Api.getCategoty();
            setState(() {});
          })
      ),
//      bottomNavigationBar:ButtonBar(children: [Container(width: 200,height: 30,color: Colors.blue,)],),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context,"/createCate");
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.add,size: 40,color: Colors.blue,),),
    ),
        onWillPop:popState,
    );
  }

  String checkName() {
    if(Global.userData == null){
      return "You need to login ";
    }
    else{
      return "${Global.userData.name}";
    }
  }

  checkImage() {
    return
    Global.userData == null ? AssetImage('assets/images/images.jpeg') : NetworkImage(Global.userData.profile);
  }

  chart(){
    return Container(
      padding: EdgeInsets.only(top: 5),
//      margin: EdgeInsets.only(right: 10),
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
            child: Center(child: Icon(Icons.shopping_cart,size: 40,color: Colors.white,))),
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
              Center(child: Text(orderCount(),style: TextStyle(color: Colors.white),))
            ],),),
        )
      ],),
    );
  }
  orderCount(){
    return Global.orderList.length.toString();
  }
  checkLoginLogo(){
    return Global.userData==null ? GestureDetector(
      onTap: (){
        Navigator.pushReplacementNamed(context,"/login");
      },
        child: Icon(Icons.person_add,size: 40,color: Colors.white)):Icon(Icons.tag_faces,size: 40,color: Colors.white);
  }
  Future<bool>popState() async{
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context)=>
          AlertDialog(
            title: Text("Warning"),
            content: Text("Are you sure exit"),

            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed:(){
                    Navigator.pop(context,false);
                  }, child: Text("No")),
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed:(){
                    Navigator.pop(context,true);
              }, child: Text("OK")),
            ],


          ),
    );
  }


  deleteCheckForCategories(_id,context){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder:(BuildContext context){
      return FutureBuilder(
          future: Api.getProducts(_id),
          builder: (context,snapShot)=>snapShot.hasData ?
          RefreshIndicator(child: Global.productList.length==0 ? AlertDialog(
            title: Text("Ok you can be Delete"),
            actions: [
              FlatButton(
                onPressed: (){
                  Navigator.pop(context,false);
                },
                child: Text("No"),
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: ()async{
                  await deleteYesFunction(_id,context);
                  Navigator.pop(context);
                },

              ),
            ],
          ):
          AlertDialog(
            title: Text("You can't be Delete.Has products in this Category"),
            actions: [
              FlatButton(
                onPressed: (){
                  Navigator.pop(context,false);
                },
                child: Text("Yes"),
              ),
            ],
          )
              , onRefresh: (){
                return Future.value(false);
              })
              :
          RefreshIndicator(child: AlertDialog(
            title: Text("We are checking"),
            content: Container(
              height: 50,
              width: 200,
              child: CircularProgressIndicator(),
            ),
          ), onRefresh:()async{
            setState(() {

            });
            Api.getProducts(_id);
          })
      );
        }
    );
  }
  deleteYesFunction(id,context)async{
    print("I ma dddddddd");
    return showDialog(
        context: context,
        builder:(BuildContext context){
          return FutureBuilder(
            future: Api.changeCategoriesStatus(id),
              builder:(context,snapShot)=>snapShot.hasData ?
                  RefreshIndicator(child:
                  AlertDialog(
                    title: Text("Deleted Your Category"),
                    actions: [
                      FlatButton(onPressed:(){
                        Navigator.pop(context,false);
                        setState(() {

                        });
                      }, child: Text("OK"))
                    ],
                  ),
                      onRefresh:(){return Future.value(false);}):
                  RefreshIndicator(child:
                      AlertDialog(
                        title: Text("Please Wait"),
                        content: CircularProgressIndicator()

                      )
                      , onRefresh:()async{
                    Api.changeCategoriesStatus(id);
                    setState(() {

                    });
                  })
          );
        });
  }

}
