class LoginModel{
  bool ?status;
  String ?message;
  UserLoginData ?data;
 LoginModel.fromJson(Map<String,dynamic> map){
   status=map['status'];
   message=map['message'];
   data=map['data']!=null?UserLoginData.fromJson(map['data']) :null;
 }


}
class UserLoginData{
  int ?id;
  String ?name;
  String ?email;
  String ?phone;
  String ?image;
  int ?points;
  int ?credit;
  String ?token;
  UserLoginData.fromJson(Map<String,dynamic> map){
    id=map["id"];
    name=map["name"];
    email=map["email"];
    phone=map["phone"];
    image=map["image"];
    points=map["points"];
    credit=map["credit"];
    token=map["token"];


  }

}