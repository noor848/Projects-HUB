
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                const SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                    controller: comment,
                    style: const TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: () {
                        CubitMainScreen.get(context).AddCommentImage(body: comment.text,postId: postView.id);


                      }, icon: const Icon(IconlyLight.camera),),
                      hintStyle: const TextStyle(color: Colors.grey,fontSize: 16),
                      hintText: "Add Comment....",
                      contentPadding: EdgeInsets.only(left: 8),
                      focusedBorder: const OutlineInputBorder(
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
      listener: (BuildContext context, Object? state) {
        if(state is CommentCreatedSuccess){
          Fluttertoast.showToast(
            msg: "Thank You !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );
        }
      },
    );
  }
}
