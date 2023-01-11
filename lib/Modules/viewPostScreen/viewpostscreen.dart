import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../../Model/CreatePost.dart';
import '../../Model/postView.dart';
class ViewPostScreen extends StatelessWidget {
  late PostView postViewData;
 ViewPostScreen(this.postViewData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>( builder: (BuildContext context, state){
      return Scaffold(
        appBar: AppBar(title:postViewData.title==""?Text(""):Text(postViewData.title)),
        body: postViewData.coverPicture == ""?
        Center(
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
                 Image.memory(base64Decode(postViewData.coverPicture!)),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("Created at : ${postViewData.createdDate}",style: TextStyle(color: Colors.grey,fontSize:13,fontFamily: "SubHead"),),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:  (context, index)=>ChunckItems(postViewData.postChunks[index],context),itemCount: postViewData.postChunks.length)
              ],
            ),
          ),
        ),);

    }, listener:  (BuildContext context, Object? state) {  }
    );
  }
  Widget ChunckItems(chunckList,context){
    if(chunckList.chunkType==1){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text("${chunckList.body}",style:TextStyle(fontSize: 60,fontWeight: FontWeight.bold,fontFamily: "SubHead"),softWrap: true,),
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
    return Image.memory(base64Decode(chunckList.body!),height: 200,width: 100,fit: BoxFit.cover,);

  }



}
