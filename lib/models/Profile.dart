class ProfileModel{
  String id,path;
  ProfileModel(this.id,this.path);

  factory ProfileModel.fromJson(dynamic data){

    return ProfileModel(
        data['_id'],
        data['path']);
  }
}

//_id: 5fc3e64cccd03b879c7b3523,
//path: 'http://192.168.1.10:3000/gallery/1606673996722-image_cropper_1606673988900.jpg',
//fileName: '1606673996722-image_cropper_1606673988900.jpg',