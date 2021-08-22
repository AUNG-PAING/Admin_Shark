class OrderModel{
  String id,subtotal,created;
  List<ItemsModel>items;
  OrderModel(this.id,this.subtotal,this.created,this.items);
  factory OrderModel.fromJson(dynamic data){
    List lisy=data['items'] as List;
    List<ItemsModel> items=lisy.map((e) => ItemsModel.fromJson(e)).toList();
    return OrderModel(
      data['_id'],
      data['subtotal'].toString(),
      data['created'],
      items
    );
  }
}
class ItemsModel{
  String id,count,price;
  ProductItemsModel Product;
  ItemsModel(this.id,this.count,this.price,this.Product);
  factory ItemsModel.fromJson(dynamic data){
    ProductItemsModel Product=ProductItemsModel.fromJson(data['productId']);
    return ItemsModel(
      data["_id"],
        data["count"],
      data["price"],
      Product
    );
  }
}

class ProductItemsModel{
  String image,name,desc;
  ProductItemsModel(this.image,this.name,this.desc);
  factory ProductItemsModel.fromJson(dynamic data){
    return ProductItemsModel(
      data['image'],
      data['name'],
      data["desc"]
    );
  }
}

//{items: [

// {_id: 5ff9781cc93687038bca1ae2,
// orderId: 5ff9781cc93687038bca1ae1,
// productId: {_id: 5fb63e2360ca400e9ab038dc,
//    image: http://192.168.1.10:3000/gallery/1605778128129-5616.jpg,
//    price: 3000,
//    desc: Ayawaddy Rice,
//    cateId: 5fad67f81be22f0cec8fe884,
//    name: Taung Pyan,
//    created: 2020-11-19T09:42:59.371Z,
//    updated: 2020-11-19T09:42:59.371Z, __v: 0},
// price: 3000,
// count: 2,
// __v: 0},

// {_id: 5ff9781cc93687038bca1ae3,
// orderId: 5ff9781cc93687038bca1ae1,
// productId: {_id: 5fb667ca59fe043eb7aebe01,
//    image: http://192.168.1.10:3000/gallery/1605789495329-chicken.jpg,
//    price: 1000,
//    desc: 100 kg,
//    cateId: 5fad72ac1be22f0cec8fe890,
//    name: Kyat tar Pownder,
//    created: 2020-11-19T12:40:42.267Z,
//    updated: 2020-11-19T12:40:42.267Z, __v: 0},
// price: 1000,
// count: 2,
// __v: 0}
// ],
// _id: 5ff9781cc93687038bca1ae1,
// user: 5fca367e27ca6950d64c893e,
// subtotal: 8000,
// created: 2021-01-09T09:32:12.183Z,
// updated: 2021-01-09T09:32:12.183Z, __v: 0},