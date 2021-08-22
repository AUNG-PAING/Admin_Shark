class UserModel{
  String id,name,profile,phoneNo,address,role,token;

  UserModel(this.id,this.name,this.profile,this.phoneNo,this.address,this.token,this.role);

  factory UserModel.fromJson(dynamic data){
    return UserModel(
      data['_id'],
      data['name'],
      data['profile'],
      data['phoneNo'],
      data['address'],
      data['token'],
      data['role'],
    );
  }
}

//"result": {
//"_id": "5faa803102fab409ef7806b5",
//"name": "aung paing",
//"profile": "http://localhost:3000/gallery/1604602724955-6.jpg",
//"phoneNo": "09764026626",
//"address": "isn yangon isnwww",
//"role": "user",
//"created": "2020-11-10T11:57:37.539Z",
//"updated": "2020-11-10T11:57:37.539Z",
//"__v": 0,
//"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmFhODAzMTAyZmFiNDA5ZWY3ODA2YjUiLCJuYW1lIjoiYXVuZyBwYWluZyIsInByb2ZpbGUiOiJodHRwOi8vbG9jYWxob3N0OjMwMDAvZ2FsbGVyeS8xNjA0NjAyNzI0OTU1LTYuanBnIiwicGhvbmVObyI6IjA5NzY0MDI2NjI2IiwiYWRkcmVzcyI6ImlzbiB5YW5nb24gaXNud3d3Iiwicm9sZSI6InVzZXIiLCJjcmVhdGVkIjoiMjAyMC0xMS0xMFQxMTo1NzozNy41MzlaIiwidXBkYXRlZCI6IjIwMjAtMTEtMTBUMTE6NTc6MzcuNTM5WiIsIl9fdiI6MCwiaWF0IjoxNjA2Mjk2OTkzfQ.VhDehhyizfJB2cjEdfgaWoyK10cdlyEnHHNAbBVLHwQ"
//}