
class Contactmodl {
  late String id;
  late String Name="";
  late String FirstName="";
  late String LastName="";
  String profilePicture = "";

  Contactmodl.fromJson(Map json){
    id=json['_id'];
    FirstName=json['firstName'];
    LastName=json['lastName'];
    profilePicture=json['profilePic'];
  }
}