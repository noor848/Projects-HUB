class ImagePost{
  String type="Image";
  String imagePath="";
  ImagePost(String imagepath){
  imagePath=imagepath;
}
}

class TextPost{
  String type="Text";
  String style="";
  String value="";
  TextPost({style,value}){
    style=style;
    value=value;
  }
}