class AllOrderModels{
  String created,orderId,userName,userPhoto,address,phoneNo;
  int subTotal,status;
  List <Items>items=[];
  AllOrderModels(this.subTotal,this.created,this.orderId,this.userName,this.userPhoto,this.address,this.phoneNo,this.items,this.status);
  factory AllOrderModels.fromJson(dynamic data){
    List lisy=data["items"] as List;
    List <Items> items=lisy.map((e) => Items.fromJson(e)).toList();
    return AllOrderModels(
      data["subtotal"],
      data["created"],
      data["_id"],
      data['user']["name"],
      data['user']['profile'],
      data["user"]["address"],
      data["user"]["phoneNo"],
      items,
      data["status"]
    );
  }

}
class Items{
  String itemId,price,count,pImage,pName,pDesc;
  Items(this.itemId,this.price,this.count,this.pImage,this.pName,this.pDesc);
  factory Items.fromJson(dynamic data){
    return Items(
      data['_id'],
      data['price'],
      data['count'],
      data['productId']['image'],
      data['productId']["name"],
      data['productId']["desc"]
    );
  }
}
//{
//"items": [
            //{
            //"_id": "5ffac75b8b1aa16a3227bc68",
            //"orderId": "5ffac75b8b1aa16a3227bc67",
            //"productId": {
                          //"_id": "5fb63e2360ca400e9ab038dc",
                          //"image": "http://192.168.1.10:3000/gallery/1605778128129-5616.jpg",
                          //"price": "3000",
                          //"desc": "Ayawaddy Rice",
                          //"cateId": "5fad67f81be22f0cec8fe884",
                          //"name": "Taung Pyan",
                          //"created": "2020-11-19T09:42:59.371Z",
                          //"updated": "2020-11-19T09:42:59.371Z",
                          //"__v": 0
                          //},
            //"price": "3000",
            //"count": "1",
            //"__v": 0
            //},

            //{
            //"_id": "5ffac75b8b1aa16a3227bc69",
            //"orderId": "5ffac75b8b1aa16a3227bc67",
            //"productId": {
                          //"_id": "5fb63e6160ca400e9ab038dd",
                          //"image": "http://192.168.1.10:3000/gallery/1605778128129-5616.jpg",
                          //"price": "2800",
                          //"desc": "Ayawaddy Rice",
                          //"cateId": "5fad67f81be22f0cec8fe884",
                          //"name": "Paw Sann Mway",
                          //"created": "2020-11-19T09:44:01.310Z",
                          //"updated": "2020-11-19T09:44:01.310Z",
                          //"__v": 0
                          //},
            //"price": "2800",
            //"count": "1",
            //"__v": 0
            //}
            //],


//"_id": "5ffac75b8b1aa16a3227bc67",

//"user": {
          //"_id": "5fca367e27ca6950d64c893e",
          //"name": "aung paing",
          //"profile": "http://192.168.1.10:3000/gallery/1607087658409-image_cropper_1607087651780.jpg",
          //"password": "$2b$10$WXMk0JhHEHoFjacgLSYneelpk3LHUXquoDxy5sJeEARe34e7QXiEe",
          //"phoneNo": "09764026626",
          //"address": "Yangon Isn 123",
          //"role": "user",
          //"created": "2020-12-04T13:15:42.369Z",
          //"updated": "2020-12-04T13:15:42.369Z",
          //"__v": 0

          //},
//"subtotal": 5800,
//"created": "2021-01-10T09:22:35.656Z",
//"updated": "2021-01-10T09:22:35.656Z",
//"__v": 0

//},