import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{

   String senderId="";
   String  receiverId="";
   String ?text="";
   String ?image="";
   late Timestamp date;

   MessageModel({
     required this.receiverId,
     required this.senderId,
     required this.text,
     required this.image,
     required this.date
       });

   MessageModel.FromJson(Map<String,dynamic>json){
     senderId=json['senderId'];
     receiverId=json['receiverId'];
     text=json['text'];
     date=json['date'];
     image=json['image'];

   }

   Map<String,dynamic>toMap(){
     return {
       "senderId":senderId,
       "receiverId":receiverId,
       "text":text,
       "image":image,
       "date":Timestamp.now()
     };}
}