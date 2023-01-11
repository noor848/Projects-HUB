class CreatePost{
  String title="";
  String coverPicture="";
  late List<PostChunks>postChunks;
  CreatePost.FromJson(Map<String,dynamic>json){
    this.title=json['title'];
    this.coverPicture=json['coverPicture'];
    this.postChunks=List<dynamic>.from(json['postChunks']).map((i) => PostChunks.fromJson(i)).toList();
    ///json['postChunks'];
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