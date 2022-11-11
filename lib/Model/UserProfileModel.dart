class UserProfileModel{

  late String id;
  String ?FirstName;
  String ?LastName;
  String profilePicture="";
  String ?bio;
  int  following=0;
  int followers=0;
  List<dynamic>? projects;
  List<dynamic>?posts;

 UserProfileModel.fromJson(Map json){
   id=json['_Id'];
   FirstName=json['name'];
   FirstName=json['firstName'];
   LastName=json['lastName'];
   profilePicture=json['profilePicture'];
   bio=json['bio'];
   following=json['following'];
   followers=json['followers'];
   projects=json['projects'];
   posts=json['posts'];
 }
}