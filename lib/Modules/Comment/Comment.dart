
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:graduationproject1/Model/postView.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../shortProfile/shortProfile.dart';

class CommentScreen extends StatelessWidget {
  late PostView postView;
  final comment = TextEditingController();
  CommentScreen(this.postView);

  @override
  Widget build(BuildContext context) {
    print(postView.comments.length);
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) {
        return Scaffold(
        appBar: AppBar(title:Text("Comments")),
        body: CubitMainScreen.get(context).CommentList.length==0?
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Icon(IconlyBroken.chat,color: Colors.red,size: 250,),
                  Text("No Comments",style: TextStyle(fontSize: 18),),],),

              )),
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
            ],
          ),
        ): Padding(
          padding: const EdgeInsets.all(8.0),
          child:CubitMainScreen.get(context).CommenterImage.length != CubitMainScreen.get(context).CommentList.length &&CubitMainScreen.get(context).CommenterFirstName.length != CubitMainScreen.get(context).CommentList.length &&CubitMainScreen.get(context).CommenterLastName.length != CubitMainScreen.get(context).CommentList.length?Center(child: CircularProgressIndicator(color: Colors.red,)): Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.separated(
                      scrollDirection:Axis.vertical,
                      shrinkWrap:true,
                      itemBuilder: (context, index)
                       {
                         print(CubitMainScreen.get(context).CommentList[index].userId);
                         return
                           CubitMainScreen.get(context).CommentList[index].userId== CubitMainScreen.get(context).userProfileValues.id?
                           Row(
                             children: [
                               CircleAvatar(
                                   radius: 20,
                                   backgroundImage:
                                   MemoryImage(base64Decode(CubitMainScreen.get(context).CommenterImage[index]!),)),
                               const SizedBox(width: 20,),
                               Expanded(
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     ChunckItems(CubitMainScreen
                                         .get(context)
                                         .CommentList[index].postChunck,CubitMainScreen.get(context).CommenterFirstName[index],CubitMainScreen.get(context).CommenterLastName[index],context),
                                     Padding(
                                       padding: const EdgeInsets.only(left: 8,),
                                       child: Text(
                                         CubitMainScreen.get(context).PastTimeAgo(
                                             CubitMainScreen
                                                 .get(context)
                                                 .CommentList[index].createdDate),
                                         style: TextStyle(color: Colors.grey,fontSize: 12),),
                                     )
                                   ],
                                 ),
                               ),
                               CubitMainScreen
                                   .get(context)
                                   .CommentList[index].userId== CubitMainScreen.get(context).userProfileValues.id ? IconButton(onPressed: (){

                                 CubitMainScreen.get(context).DeleteComment(postId: postView.id,commentNumbr: CubitMainScreen
                                     .get(context)
                                     .CommentList[index].id,index: index);


                               }, icon: Icon(Icons.delete_outlined,color: Colors.red,)):Container()
                             ],
                           ):
                           InkWell(
                           onTap: (){
                             CubitMainScreen.get(context).getContactProfile(RcvId: CubitMainScreen
                                 .get(context)
                                 .CommentList[index].userId);

                           Navigator.push(context, MaterialPageRoute(builder: (context) => ContactProfile()));

                           },
                           child: Row(
                        children: [
                            CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                MemoryImage(base64Decode(CubitMainScreen.get(context).CommenterImage[index]!),)),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ChunckItems(CubitMainScreen
                                      .get(context)
                                      .CommentList[index].postChunck,CubitMainScreen.get(context).CommenterFirstName[index],CubitMainScreen.get(context).CommenterLastName[index],context),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8,),
                                    child: Text(
                                      CubitMainScreen.get(context).PastTimeAgo(
                                          CubitMainScreen
                                              .get(context)
                                              .CommentList[index].createdDate),
                                      style: TextStyle(color: Colors.grey,fontSize: 12),),
                                  )
                                ],
                              ),
                            ),
                            CubitMainScreen
                                .get(context)
                                .CommentList[index].userId== CubitMainScreen.get(context).userProfileValues.id ? IconButton(onPressed: (){

                                  CubitMainScreen.get(context).DeleteComment(postId: postView.id,commentNumbr: CubitMainScreen
                                      .get(context)
                                      .CommentList[index].id,index: index);


                            }, icon: Icon(Icons.delete_outlined,color: Colors.red,)):Container()
                        ],
                      ),
                         );},
                      separatorBuilder:  (context, index)=> Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Container(height:1,color: Colors.grey,width: double.infinity,),
                      ), itemCount: CubitMainScreen.get(context).CommentList.length),
                ),
              ),
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
            ],
          ),
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
        if(state is CommentDeletedSuccess){
          CubitMainScreen.get(context).getListOfComments(postView.comments);
        }
      },
    );
  }

  Widget ChunckItems(chunckList,firstName,LastName,context){
    if(chunckList.chunkType==3){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$firstName $LastName",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text("${chunckList.body}",style:TextStyle(fontFamily: "SubHead",height:1.4),softWrap: true,
            ),
          ),
        ],
      );
    }
    return FullScreenWidget(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("$firstName $LastName",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
              ),
              Container( height: 200,
                  width: double.infinity,child: Image.memory(base64Decode(chunckList.body!),fit: BoxFit.cover,)),
            ],
          ),
        ));
  }

}
