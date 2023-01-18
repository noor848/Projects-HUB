import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                Image.memory(base64Decode(projectData.coverPicture!)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(projectData.abstract,style: TextStyle(fontSize: 20),),
                ),
                SizedBox(height: 10,),
                Center(child: Container(
                    color: Colors.red[100],
                    child: TextButton(onPressed: (){
                      CubitMainScreen.get(context).openFile(projectData.projectFile);
                    },
                        child: Text("Work PDF File",style: TextStyle(fontSize: 20)))))
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
