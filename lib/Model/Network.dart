class NetworkModel{
  String id = "";
  String firstName= "";
  String lastName= "";
  String profilePic= "";
  String bio= "";
  bool isFollowed=false;
  NetworkModel();
  NetworkModel.fromJson(Map<String, dynamic> json)
  {
    id=json['_id'];
    firstName=json['firstName'];
    lastName=json['lastName'];
    profilePic=json['profilePic'];
    bio=json['bio'];
    isFollowed=json['isFollowed'];
  }



}