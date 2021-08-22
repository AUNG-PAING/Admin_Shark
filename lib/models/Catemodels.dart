class CategoryModel{
  String id,name,image;

  CategoryModel(this.id,this.name,this.image);

  factory CategoryModel.fromJson(dynamic data){
    return CategoryModel (
      data['_id'],
      data['name'],
      data['image']
    );
  }

}

//{_id: 5fab948bb17cb5094c945a57,
//name: Rice,
//image: http://localhost:3000/gallery/1605080068549-5616.jpg,
//created: 2020-11-11T07:36:43.784Z,
//updated: 2020-11-11T07:36:43.784Z, __v: 0},
