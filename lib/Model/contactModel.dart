
class Contactmodl {
  late String id;
  late String Name="";
  String profilePicture = "";

  Contactmodl.fromJson(Map json){
    id=json['_id'];
    Name=json['userName'];
    profilePicture=json['changeProfilePic'];
  }
}