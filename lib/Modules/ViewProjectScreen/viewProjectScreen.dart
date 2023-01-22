import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../../Model/projectModel.dart';

class ViewProjectScreen extends StatelessWidget {
  ProjectModel projectData;
  ViewProjectScreen(this.projectData);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(builder: (BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(title: Text(projectData.title),
        actions: [
          projectData.isLiked? IconButton(onPressed: (){
            CubitMainScreen.get(context).UnLikeProject(userId:projectData.author.userId,projectId: projectData.id );
          }, icon: Icon(IconlyBold.star,color: Colors.yellow,
          size: 30,)):
          IconButton(onPressed: (){
            CubitMainScreen.get(context).LikeProject(userId:projectData.author.userId,projectId: projectData.id );
            CubitMainScreen.get(context).getPaginatedProject(pageNumber:1);
          },
              icon: Icon(IconlyBroken.star,color: Colors.yellow,
            size: 30,))
        ]),
        body:projectData.coverPicture==""?Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ):SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FullScreenWidget(
                    child: Image.memory(base64Decode(projectData.coverPicture!),fit: BoxFit.cover,height: 300,width: double.infinity,)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(projectData.abstract,style: TextStyle(fontSize: 20),),
                ),
                SizedBox(height: 10,),
                Center(child: Container(
                    color: Colors.red,
                    width: double.infinity,
                    child: TextButton(onPressed: (){
                      CubitMainScreen.get(context).openFile(projectData.projectFile);
                    },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Work file",style: TextStyle(fontSize: 20,color: Theme.of(context).scaffoldBackgroundColor)),
                            SizedBox(width:10,),
                            Icon(Icons.cloud_download,color:Theme.of(context).scaffoldBackgroundColor,size: 30,)
                          ],
                        ))))
              ],
            ),
          ),
        ) ,
      );

    },


      listener: (BuildContext context, Object? state) {  },

    );
  }
}
