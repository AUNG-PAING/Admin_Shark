import 'dart:convert';

import 'package:home_shop/global.dart';
import 'package:home_shop/models/AllOrderModel.dart';
import 'package:home_shop/models/Catemodels.dart';
import 'package:home_shop/models/Profile.dart';
import 'package:home_shop/models/UserModel.dart';
import 'package:home_shop/models/orderModel.dart';
import 'package:home_shop/models/productModel.dart';
import 'package:http/http.dart' as http;


class Api {
  static Future<bool> getCategoty() async {
    print("I am here");
    var url = "${Global.BASE_URL}/cate/";
    var response = await http.get(url);
//    print(response.runtimeType);
    List lisy = jsonDecode(response.body)['result'] as List;
    print(lisy);
    List <CategoryModel>categories = lisy.map((e) => CategoryModel.fromJson(e))
        .toList();
    Global.cateList = categories;
    return true;
  }

  static Future<List<ProductModels>> getProducts(_id) async {
    print(_id);
    var url = "${Global.BASE_URL}/product/getProduct/$_id";
    var response = await http.get(url);
    List lisy = jsonDecode(response.body)["result"] as List;
    List<ProductModels>products = lisy.map((e) => ProductModels.fromJson(e))
        .toList();
    Global.productList = products;
    print(products);
    return products;

  }

  static Future<bool> login(String userData) async {
    var url = "${Global.BASE_URL}/user/login";
    var respond = await http.post(url, body: userData, headers: Global.headers);

    var data = jsonDecode(respond.body);
    if (data["con"]) {
      Global.userData = UserModel.fromJson(data["result"]);
      print(Global.userData);
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> uploadImage(file) async {
    print("upload Image");
    var postUri = Uri.parse("${Global.BASE_URL}/gallery/photoSave");
    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
    http.MultipartFile responceMulti = await http.MultipartFile.fromPath('photo', file);
    request.files.add(responceMulti);

    await request.send().then((respond) =>
    {
      respond.stream.transform(utf8.decoder).listen((value) async{
        var resData = jsonDecode(value);

        Global.profileList = ProfileModel.fromJson(resData["result"]);
      })
    });
  }

  static Future<bool> Register(userData) async {
    var url = "${Global.BASE_URL}/user/reg";
    var respond = await http.post(url, body: jsonEncode(userData), headers: Global.headers);

    var data = jsonDecode(respond.body);
    if (data["con"]) {
      return true;
    } else {
      return false;
    }
  }
  static Future<bool>sendOrder()async{
    print("I am order");
    var url = "${Global.BASE_URL}/order/save";
    var body=jsonEncode(Global.loadtoOrderMap());
    var response=await http.post(url,body: body,headers: Global.TokenHeader);
    var res=jsonDecode(response.body);
    return res["con"];
  }
  static Future<List<OrderModel>>getOrder()async{
    var url="${Global.BASE_URL}/order/getOrder/${Global.userData.id}";
    var response=await http.get(url);
    print(response.body);
    var res=jsonDecode(response.body);
    List lisy=res["result"] as List;
    List <OrderModel>Orders=lisy.map((e) => OrderModel.fromJson(e)).toList();
    return Orders;

  }
  static Future<List<AllOrderModels>>getAllOrder()async{
    print("I am getalllllll");
    var url="${Global.BASE_URL}/order/getAllOrder";
    var response=await http.get(url);
    print(response.body);
    List lisy=jsonDecode(response.body)["result"] as List;
    List <AllOrderModels> Orders=lisy.map((e) => AllOrderModels.fromJson(e)).toList();
    print(Orders);
    print(Orders==null);
    Global.allOrder=Orders.reversed.toList();
//    print("${Global.allOrder}sddddddddd");
    return Global.allOrder;

  }
  static Future<bool>changeStatus(Userdata)async{
    print(Userdata);
    var url="${Global.BASE_URL}/order/updateStatus";
    var body=jsonEncode(Userdata);
    var response=await http.post(url,body:body,headers: Global.headers);
    bool bol =jsonDecode(response.body)['con'];
    var a=jsonDecode(response.body)['result'];
    print (a);
    if (bol== true ){
      return true ;
    }
    else{
      return false;
    }
  }

  static Future<bool> cateCreate(cateData) async {
    var url = "${Global.BASE_URL}/cate/createCate";
    var respond = await http.post(url, body: jsonEncode(cateData), headers: Global.headers);

    var data = jsonDecode(respond.body);
    if (data["con"]) {
      return true;
    } else {
      return false;
    }
  }
  static Future<bool>createProduct(body)async{
    print("i am create products");
    var url="${Global.BASE_URL}/product/create";
    var response=await http.post(url,body:jsonEncode(body),headers: Global.headers );
    print(response.body);
    var data=json.decode(response.body);
    if (data["con"]) {
      return true;
    } else {
      return false;
    }
  }
  static Future<bool>deleteProducts(id)async{
    var url="${Global.BASE_URL}/product/$id";
    var response=await http.delete(url);
    var data=json.decode(response.body);
    if (data["con"]) {
      return true;
    } else {
      return false;
    }

  }
  static Future<bool>updateProductObject(_id,objectBody)async{
    print("I am Api updateProductObject");
    var url="${Global.BASE_URL}/product/update/$_id";
    var body=jsonEncode(objectBody);
    var response=await http.patch(url,body:body,headers: Global.headers);
    bool bol =jsonDecode(response.body)['con'];
    var a=jsonDecode(response.body)['result'];
    print (a);
    if (bol== true ){
      return true ;
    }
    else{
      return false;
    }
  }

  static Future<bool>changeCategoriesStatus(_id)async{

    Map <String,int> data= {"status":0};
    var url="${Global.BASE_URL}/cate/$_id";
    var response=await http.patch(url,body:jsonEncode(data) ,headers: Global.headers);
    bool bol =jsonDecode(response.body)['con'];
    var a=jsonDecode(response.body)['result'];
    print (a);
    if (bol== true ){
      return true ;
    }
    else{
      return false;
    }
  }
  static Future<bool>updateCategoryBody(_id,body)async{
    print("updateCategoryBody");
    var url="${Global.BASE_URL}/cate/$_id";
    var response=await http.patch(url,body:jsonEncode(body) ,headers: Global.headers);
    bool bol =jsonDecode(response.body)['con'];
    var a=jsonDecode(response.body)['result'];
    print (a);
    if (bol== true ){
      return true ;
    }
    else{
      return false;
    }
  }
}


