class ProductModels{
  String id,image,price,desc,cateId,name,created,updated;
  int count=1;

  ProductModels(this.id,this.image,this.price,this.desc,this.cateId,this.name,this.created,this.updated);

  factory ProductModels.fromJson(dynamic data){
    return ProductModels(
      data['_id'],
      data['image'],
      data['price'],
      data['desc'],
      data['cateId'],
      data['name'],
      data['created'],
      data['updated'],
    );
  }
}