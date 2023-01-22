import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../../Model/CreatePost.dart';
import '../../Model/postView.dart';
import '../Comment/Comment.dart';
class ViewPostScreen extends StatelessWidget {
  late PostView postViewData;
 ViewPostScreen(this.postViewData, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(postViewData.id);
    return BlocConsumer<CubitMainScreen,MainScreenState>( builder: (BuildContext context, state){
      return Scaffold(
        appBar: AppBar(title:postViewData.title==""?const Text(""):Text(postViewData.title),
        actions: [
          postViewData.title!=""?IconButton(onPressed: (){
            CubitMainScreen.get(context).getListOfComments(postId:postViewData.id );
            CubitMainScreen.get(context).getListOfComments(postId:postViewData.id );

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  CommentScreen(postViewData.id,postViewData.authorId)));
          },icon: const Icon(IconlyBold.chat,size:30),color: Colors.grey,):const Text(""),
          postViewData.title!=""?Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed: (){
              CubitMainScreen.get(context).likeDisLike(userId:postViewData.authorId );
              //CubitMainScreen.get(context).getShortProfileFront();
            }
            ,icon:postViewData.isLiked==false?const Icon(IconlyLight.heart,size:30):const Icon(IconlyBold.heart,size:30),color: Colors.pinkAccent,),
          ):const Text(""),

        ],
        ),
        body: postViewData.coverPicture == ""?
        const Center(
          child: CircularProgressIndicator(
            color: Colors.red
          ),
        ):Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FullScreenWidget(child: Container( height: 300,
                    width: double.infinity,child: Image.memory(base64Decode(postViewData.coverPicture!),fit: BoxFit.cover,))),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10),
                  child: Row(
                    children: [
                      Text("${postViewData.createdDate}",style: TextStyle(color: Colors.grey,fontSize:13,fontFamily: "SubHead"),),
                      SizedBox(width:15),
                      Icon(IconlyBold.time_circle,color: Colors.grey,size: 18,),
                      SizedBox(width:1),
                      Text("${CubitMainScreen.get(context).timeAgo}",style: TextStyle(color: Colors.grey,fontSize:14,fontFamily: "SubHead"),),
                    ],
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:  (context, index)=>ChunckItems(postViewData.postChunks[index],context),itemCount: postViewData.postChunks.length),
              ],
            ),
          ),
        ),);

    }, listener:  (BuildContext context, Object? state) {
      if(state is ViewDataPost){
      ///  CubitMainScreen.get(context).likeDisLike();
      }

    }
    );
  }
  Widget ChunckItems(chunckList,context){
    if(chunckList.chunkType==1){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Text("${chunckList.body}",style:TextStyle(fontSize: 55,fontWeight: FontWeight.bold,fontFamily: "SubHead"),softWrap: true,),
      );
    }
    else if(chunckList.chunkType==2){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text("${chunckList.body}",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w600,fontFamily: "SubHead"),softWrap: true,),
      );
    }
    else if(chunckList.chunkType==3){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text("${chunckList.body}",style:TextStyle(fontFamily: "SubHead",height:1.4),softWrap: true,
        ),
      );
    }
    return FullScreenWidget(
        child: Container( height: 200,
            width: 100,child: Image.memory(base64Decode(chunckList.body!),fit: BoxFit.cover,)));

  }

}
