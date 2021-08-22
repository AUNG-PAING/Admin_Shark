import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_shop/api.dart';
import 'package:home_shop/models/orderModel.dart';
import 'package:home_shop/utils.dart';

import '../global.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
//  List Data=[];
//  loadData()async{
//
//    List datas=Global.allOrder;
//    this.Data=datas.reversed.toList();
//    setState(() {
//
//    });
//  }
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    loadData();
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Api.getAllOrder(),
          builder:(context,snapshot)=>snapshot.hasData ?
              RefreshIndicator(
                  child:SafeArea(child:
              Column(
                children: [
                  Container(
                    child: Center(child: Text("Orders",style: TextStyle(fontSize: 20,color: Colors.white),)),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: fourthColor,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: ListView.builder(
//          reverse: true,
//        dragStartBehavior: DragStartBehavior.start,
                          itemCount: Global.allOrder.length,
                          itemBuilder: (context,index){

                            return ExpansionTile(
                              title: Row(
                                children: [
                                  Container(
                                      width: 100,
                                      child: Text("${Global.allOrder[index].created.substring(0,10)}")),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        check(Global.allOrder[index].status),
                                        Icon(checkIcon(Global.allOrder[index].status))
                                      ],),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: checkStatusForColors(Global.allOrder[index].status),
                                    ),
                                  ),


                                ],
                              ),
////                      Text("${Data[index].created.substring(0,10)} ${Data[index].userName} ${check(Data[index].status)}"),
//                      backgroundColor: checkStatusForColors(Data[index].status),
                              subtitle: Row(
                                children: [
                                  Container(
                                      width:90,
//                          padding:EdgeInsets.only(left: 10,right: 10),
                                      child: Text("${Global.allOrder[index].subTotal} Ks")),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 3),
                                    child: Text("${Global.allOrder[index].userName}",style: TextStyle(color: Colors.white),),
                                    decoration: BoxDecoration(
                                        color:fourthColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                  ),

                                ],),
                              children: [
                                Container(
                                  height: 100,
                                  child: Row(
                                    children: [

                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
//                                    color: Colors.red,
                                                height: 45,
                                                width: 280,
                                                child: Row(children: [Icon(Icons.home),Text(Global.allOrder[index].address)],),
                                              ),
                                              Container(
                                                child: Row(children: [Icon(Icons.phone),Text(Global.allOrder[index].phoneNo)],),
                                              )
                                            ],
                                          )),
                                      Spacer(),
                                      Container(

                                        decoration: BoxDecoration(

                                            image: DecorationImage(image:NetworkImage(Global.allOrder[index].userPhoto)),
                                            borderRadius: BorderRadius.circular(10)

                                        ),
                                        height: 60,
                                        width: 60,),
                                    ],
                                  ),


                                ),
                                ...List.generate(Global.allOrder[index].items.length, (ind){ return
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: Row(children: [
                                      Container(
                                        child:Text("${Global.allOrder[index].items[ind].pName}"),
                                        width: 150,),
                                      Container(child: Text("${Global.allOrder[index].items[ind].price}"),
                                        width: 80,),
                                      Container(child: Text("${Global.allOrder[index].items[ind].count}"),
                                        width: 50,),
                                      Container(child: Text("${int.parse(Global.allOrder[index].items[ind].price)*int.parse(Global.allOrder[index].items[ind].count)}")),
                                    ],),);
//                Card(
//                  color: Colors.yellowAccent,
//                    child:Text("${Data[index].items[ind].Product.name}${Data[index].items[ind].price}"));

                                }),
                                Container(
                                  height: 70,
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 200,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: fourthColor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(onTap:(){
//                                              print(Data[index].orderId);
                                              Map <String,String> UserDa={
                                                "id":Global.allOrder[index].orderId,
                                                "status":Global.allOrder[index].status == 1 ? "0":"1"
                                              };
                                              changeStatus(context,"Warning !!!", "Really Send Products to Customer?",UserDa);
                                              print(UserDa);

                                            },
                                              child: Container(
                                                height: 35,
                                                width: 195,
                                                color: Colors.white,
                                                child:checkButton(Global.allOrder[index].status)
                                              ),
                                            )
                                          ],),
                                      ),
                                      Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                            color:thirdColor,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        width: 130,
                                        height:40,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [Text("Total",style: TextStyle(color: Colors.white),),
                                              SizedBox(width: 20,),
                                              Text("${Global.allOrder[index].subTotal.toString()} Ks",style: TextStyle(color: Colors.white),),]),
                                      ),
                                    ],
                                  ),),
                                SizedBox(
                                  child: Text("****************************************"),
                                  height: 30,)
                              ],
                            );
                          }),
                    ),
                  ),
                  Container(
                    child: Column(children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context,"/home");
                        },
                        child: Container(
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            height: 40,
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Go to Categories",style: TextStyle(fontSize: 20,color: Colors.black),),Icon(Icons.touch_app,color: Colors.pinkAccent,)],)
                        ),
                      ),],),
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: fourthColor,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))),
                  ),
                ],
              )
              ), onRefresh:()async{
                    return Future.value(false);

              }):
              RefreshIndicator(child:Center(child: CircularProgressIndicator(),), onRefresh:()async{
                 Api.getAllOrder();
                setState(() {

                });
              })
      )

    );
  }
  checkStatusForColors(status){
    if(status==1){
      return Colors.yellowAccent;
    }
    else {
      return Colors.pinkAccent;
    }
  }
  check(status){
    if(status==1){
      return Text("Receive");
    }
    else{
      return Text("Send",style: TextStyle(color: Colors.white),);
    }
  }
  checkIcon(status){
    if (status==1){
      return Icons.call_received;
    }
    else{
      return Icons.call_made;
    }
  }
  checkButton(status){
    if(status == 1){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Approve Order Send"),
          Icon(Icons.remove_shopping_cart)
        ],
      );
    }
    else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Redo order"),
          Icon(Icons.shopping_cart)
        ],
      );
    }
  }
  changeStatus(BuildContext context,String header,String body,Userdata) {


    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        Navigator.pop(context);
        loadStatus(context,Userdata);
        print(Userdata);
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
//      backgroundColor: Colors.yellow[50],
      title: Text(header),
      content: Text(body),
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

  loadStatus(BuildContext context,Userdata)async {

    AlertDialog alert = AlertDialog(
      title: Text("Please Wait..."),
      content: Container(
        height: 100,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          CircularProgressIndicator(),
        ],)
      ),
      actions: [

//        cancelButton,
//        continueButton,
      ],
    );

    AlertDialog alert2 = AlertDialog(
      title: Text("Approve"),
      content: Text("Approve Customer's Order"),
      actions: [
        RaisedButton(
          child: Text("Ok"),
            onPressed: (){
          Navigator.pushReplacementNamed(context,"/history");
        })

//        cancelButton,
//        continueButton,
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return FutureBuilder(
          future: Api.changeStatus(Userdata),
          builder: (context,snapshot)=> snapshot.hasData ?
              RefreshIndicator(child: alert2,
                onRefresh: () async {
//                  await Api.changeStatus(Userdata);
//                  setState(() {});
                  return Future.value(false);
                },
              )
              : RefreshIndicator(child: alert, onRefresh:()async{
                await Api.changeStatus(Userdata);
                setState(() {});
          })

        );
      },
    );
  }
}
