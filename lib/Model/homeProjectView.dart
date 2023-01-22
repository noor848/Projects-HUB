class ProjectM{

  String id="";
  String title="";
  String createdDate="";
  String coverPicture="";
  int usersWhoLiked=0;
  bool isLiked=false;
  late Author author;
  bool isAuthorFollowed=false;
  ProjectM();
  ProjectM.fromJson(Map<String, dynamic> json)
  {
    id=json['_id'];
    title=json['title'];
    createdDate=json['createdDate'];
    coverPicture=json['coverPicture'];
    usersWhoLiked=json['usersWhoLiked'];
    isLiked=json['isLiked'];
    isAuthorFollowed=json['isAuthorFollowed'];
    author=Author.fromJson(json['author']);
  }

}

class Author{
  String userId="";
  String firstName="";
  String lastName="";
  String profilePic="";

  Author.fromJson(Map<String, dynamic> json)
  {
    userId=json['_id'];
    firstName=json['firstName'];
    lastName=json['lastName'];
    profilePic=json['profilePic'];

  }

}