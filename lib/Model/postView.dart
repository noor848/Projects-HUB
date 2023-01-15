class PostView{
  String id="";
  String title="";
  String createdDate = "";
  String coverPicture = "";
  String authorId = "";
  int  usersWhoLiked=0;
 late List<PostChunks>postChunks;
 late List<Commnet>comments;
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
     comments=List<dynamic>.from(json['comments']).map((i) => Commnet.fromJson(i)).toList();
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


class Commnet{
  String userId="";
  String createdDate="";
  int id=0;
  late PostChunks postChunck;
  Commnet(this.id,this.userId);
  Commnet.fromJson(Map<String, dynamic> json)
  {
    userId=json['userId'];
    id=json['id'];
    createdDate=json['createdDate'];
    postChunck=PostChunks.fromJson(json['commentchunk']);
  }
}