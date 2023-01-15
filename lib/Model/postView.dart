class PostView{
  String id="";
  String title="";
  String createdDate = "";
  String coverPicture = "";
  String authorId = "";
  int  usersWhoLiked=0;
 late List<PostChunks>postChunks;
 int comments=0;
 bool isLiked=false;
 PostView();
  PostView.fromJson(Map<String, dynamic> json)
  {
        id=json['_id'];
        title=json['title'];
        createdDate=json['createdDate'];
        coverPicture=json['coverPicture'];
        authorId=json['authorId'];
      usersWhoLiked=json['usersWhoLiked'];
      isLiked=json['isLiked'];
      postChunks=List<dynamic>.from(json['postChunks']).map((i) => PostChunks.fromJson(i)).toList();
     comments=json['comments'];
  }

}
class PostChunks{
  late int chunkType;
  String body="";
  PostChunks(this.body, this.chunkType);
  PostChunks.fromJson(Map<String, dynamic> json)
  {
    body = json['body'];
    chunkType = json['chunkType'];
  }

  Map<String, dynamic> toJson() => {
    'chunkType': chunkType,
    'body': body,
  };

}


