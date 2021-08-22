import 'package:flutter/material.dart';
import 'package:home_shop/api.dart';
import 'package:home_shop/utils.dart';

import '../global.dart';

class postOrder extends StatefulWidget {
  @override
  _postOrderState createState() => _postOrderState();
}

class _postOrderState extends State<postOrder> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Order Page"),backgroundColor: fourthColor,leading: GestureDetector(onTap: (){
         Navigator.pushReplacementNamed(context,"/home");
       },
           child: Container(child:Icon(Icons.backspace),)),),
           body: Container(
             width: MediaQuery.of(context).size.width,
//             color: Colors.brown[100],
             child: Column(children: [
               Expanded(child: Container(
                 child: ListView.builder(
                   padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                     itemCount: Global.orderList.length,
                     itemBuilder:(context,ind){
                       return Card(
                         elevation: 5,
                         child: Stack(
                           overflow: Overflow.visible,
                           children: [
                         Positioned(
                           child: InkWell(
                             onTap: ()async{
                               await delete(Global.orderList[ind].id);
                               setState(() {

                               });
                             },
                             child: Container(

                               decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.redAccent),
                               height: 30,
                               width: 30,
                               child: Icon(Icons.clear,color: Colors.white,),
                             ),
                           ),
                           top: -10,
                           right: -10,
                           ),
                         Container(
                         width: MediaQuery.of(context).size.width,
                           height: 100,
                           child:Row(children: [
                             Container(
                               margin: EdgeInsets.only(left: 5),
                               child: ClipOval(

                                 child: Container(
                                     width: 70,
                                     height: 70,
                                     child: Image.network(Global.orderList[ind].image)),
                               ),
                             ),
                             Container(
//                    color:fourthColor,
                               height: 80,
                               width: 170,
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Container(

                                     padding: EdgeInsets.fromLTRB(10,4,10,4),
                                     child: Text(Global.orderList[ind].name,style: TextStyle(color: Colors.white),),
                                     decoration: BoxDecoration(
                                         color: fourthColor,
                                         borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomLeft: Radius.circular(20))
                                     ),),
                                   SizedBox(height: 5,),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [Container(
                                         padding: EdgeInsets.fromLTRB(10,4,10,4),
                                         decoration: BoxDecoration(
                                             color: fourthColor,
                                             borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomLeft: Radius.circular(20))
                                         ),
                                         child: Text("${Global.orderList[ind].price}*${Global.orderList[ind].count.toString()}",style: TextStyle(color: Colors.white))),
                                       Container(
                                           padding: EdgeInsets.fromLTRB(10,4,10,4),
                                           decoration: BoxDecoration(
                                               color:Colors.redAccent,
                                               borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomLeft: Radius.circular(20))
                                           ),
                                           child: Text("${int.parse(Global.orderList[ind].price)*Global.orderList[ind].count}",style: TextStyle(color: Colors.white))
                                       )
                                     ],),

                                 ],),),

                             Container(
//                               color: Colors.red,
                               height: 80,
                               width: 100,
                               child: Column(children: [
                                 SizedBox(height: 30,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                                   children: [
                                     Container(
                                       child: IconButton(icon:Icon(Icons.remove), onPressed:(){
                                         if(Global.orderList[ind].count >1){
                                           Global.orderList[ind].count--;
                                           setState(() {

                                           });
                                         }
                                       },padding: EdgeInsets.only(bottom: 1),),
                                       height: 30,width: 30,color: secondColor,),
                                     Text(Global.orderList[ind].count.toString(),),
                                     Container(
                                       child: IconButton(icon:Icon(Icons.add), onPressed:(){
                                         Global.orderList[ind].count++;
                                         setState(() {

                                         });
                                       },padding: EdgeInsets.only(bottom: 1)),
                                       height: 30,width: 30,color: secondColor,),
                                   ],)
                               ],),)
                           ],)),
                         ],));
                     }),
               )),
               Container(
                 width: MediaQuery.of(context).size.width,
                 child: Column(children: [
                 Container(
                   padding: EdgeInsets.only(top: 10),
                     child: Text("Total ${totalAll().toString()} Ks",style: TextStyle(fontSize: 30,color: fourthColor),
                     ),
//                   color: Colors.red,
                 ),
                   SizedBox(height: 30,),
                   InkWell(
                     onTap: ()async{
                      if (Global.orderList.length == 0){
                        Navigator.pushReplacementNamed(context,"/home");
                      }
                      else {
                        Navigator.pushReplacementNamed(context,"/sendOrder");
                      }

                     },
                     child: Container(
                       alignment: Alignment.center,
                       child: Text("Order Now",style: TextStyle(fontSize: 27,color: firstColor),),
                       width: 250,
                       height: 50,
                       decoration: BoxDecoration(
                         color: fourthColor,
                         borderRadius: BorderRadius.circular(15)
                       ),
                     ),
                   )
               ],),
                 decoration: BoxDecoration(
                     color:firstColor,
                   borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30) )
                 ),

                 height:150,)
             ],)
           )
           );
  }
  totalAll(){
    int t=0;
    Global.orderList.forEach((index) {
      t+=int.parse(index.price)*index.count;
    });
    return t;
  }

  delete(id){
    print(id);
    var a;
    Global.orderList.firstWhere((element) => Global.orderList.remove(element));
//    for(var i =0;i <= Global.orderList.length;i++ ){
//      print(i);
//      if (Global.orderList[i].id==id){
//        a=i;
//        Global.orderList.remove(Global.orderList[i]);
//      }
//    }

  }

//   showAlertDialog(BuildContext context,String header,String body) {
//
//    // set up the buttons
////    Widget cancelButton = FlatButton(
////      child: Text("Cancel"),
////      onPressed:  () {},
////    );
//
//    Widget continueButton = FlatButton(
//      child: Text("Ok"),
//      onPressed:  () {
//        Navigator.pushNamed(context,"/Home");
//      },
//    );
//
//    // set up the AlertDialog
//    AlertDialog alert = AlertDialog(
//      scrollable: true,
//      title: Text(header),
//      content:Expanded(
//        child: Container(
//          height:MediaQuery.of(context).size.height,
//          width:MediaQuery.of(context).size.width,
//        ),
//      ),
//      actions: [
////        cancelButton,
//        continueButton,
//      ],
//    );
//
//    // show the dialog
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return alert;
//      },
//    );
//  }
}
