
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Model/postView.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';

class CommentScreen extends StatelessWidget {
  late PostView postView;
  final comment = TextEditingController();

  CommentScreen(this.postView);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) {
        return Scaffold(
        appBar: AppBar(title:Text("Comments")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Spacer(),
            Row(
              children: [
                CircleAvatar(
                    radius: 20,
                    backgroundImage: MemoryImage(base64Decode(CubitMainScreen.get(context).userProfileValues.profilePicture!),) ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                    controller: comment,
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: () { print("hello");}, icon: Icon(IconlyLight.camera),),
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
                      hintText: "Add Comment....",
                      contentPadding: EdgeInsets.only(left: 8),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: .5),
                      ),
                    ),
                    maxLines: null,
                  ),
                ), IconButton(onPressed: () {

               CubitMainScreen.get(context).AddCommentText(body: comment.text,postId: postView.id);

                }, icon: Icon(IconlyLight.send,size: 25,color: Colors.red,),),

              ],
            ),



          ],),
        ),
      );  },
      listener: (BuildContext context, Object? state) {  },
    );
  }
}
