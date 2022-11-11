import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{

   String senderId="";
   String  receiverId="";
   String text="";
   late Timestamp date;

   MessageModel({
     required this.receiverId,
     required this.senderId,
     required this.text,
     required this.date
       });

   MessageModel.FromJson(Map<String,dynamic>json){
     senderId=json['senderId'];
     receiverId=json['receiverId'];
     text=json['text'];
     date=json['date'];

   }

   Map<String,dynamic>toMap(){
     return {
       "senderId":senderId,
       "receiverId":receiverId,
       "text":text,
       "date":Timestamp.now()
     };}
}