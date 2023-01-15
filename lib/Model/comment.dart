import 'package:graduationproject1/Model/postView.dart';

class Commnet{
  int id=0;
  late User user;
  String createdDate="";
  late PostChunks postChunck;

  Commnet();
  Commnet.fromJson(Map<String, dynamic> json)
  {
    id=json['id'];
    user= User.fromJson(json['user']);
    createdDate=json['createdDate'];
    postChunck=PostChunks.fromJson(json['commentchunk']);
  }
}


class User{
  String UserId="";
  String firstName="";
  String lastName="";
  String profilePic="";

  User.fromJson(Map<String, dynamic> json)
  {
    UserId=json['_id'];
    firstName=json['firstName'];
    lastName=json['lastName'];
    profilePic=json['profilePic'];
  }

}