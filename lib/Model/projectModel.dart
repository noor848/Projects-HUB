class ProjectModel{

  String id="";
  String title="";
  String createdDate="";
  String coverPicture="";
  int usersWhoLiked=0;
  bool isLiked=false;
  late Author author;
  String  abstract="";
  String projectFile="";
  ProjectModel();
  ProjectModel.fromJson(Map<String, dynamic> json)
  {
    id=json['_id'];
    title=json['title'];
    createdDate=json['createdDate'];
    coverPicture=json['coverPicture'];
    usersWhoLiked=json['usersWhoLiked'];
    isLiked=json['isLiked'];
    abstract=json["abstract"];
    projectFile=json['projectFile'];
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