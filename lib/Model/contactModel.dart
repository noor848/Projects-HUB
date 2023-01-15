class Contactmodl {
  late String id;
  late String FirstName="";
  late String LastName="";
  String profilePicture = "";
  Contactmodl(){

  }

  Contactmodl.fromJson(Map json){
    id=json['_id'];
    FirstName=json['firstName'];
    LastName=json['lastName'];
    profilePicture=json['profilePic'];
  }
}