
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../ViewProjectScreen/viewProjectScreen.dart';

class Projectview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(builder: (BuildContext context, state){
      return  Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 50,
                  child: TextField(
                    onSubmitted: (value){
                      CubitMainScreen.get(context).PP=1;
                      CubitMainScreen.get(context).getPaginatedProjecttwithQuery(pageNumber: 1,query: value);
                    },
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      prefixIcon: Icon(IconlyLight.search,color: Colors.grey[300],),
                      hintText: "Search",
                      hintStyle: Theme.of(context).textTheme.bodyText1,
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, ),borderRadius: BorderRadius.circular(100.0),),
                      focusedBorder:OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  )
              )),
          CubitMainScreen.get(context).ProjectData.length==0?
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.list,size: 150,color: Colors.red,),
                Text("No Projects",style: TextStyle(fontFamily: 'SubHead',fontSize: 20),)
              ],
            ),
          ):Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index)=>getProjects(context,CubitMainScreen.get(context).ProjectData[index]),
                itemCount: 1,
              ))
        ],
      );

    }, listener: (BuildContext context, state){});


}
  Widget getProjects(context,list){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: (){
            CubitMainScreen.get(context).getSpecificProjectView(projectId: list.id);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewProjectScreen(CubitMainScreen.get(context).projectViewData)));
          },
          splashColor: Colors.red,
          child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child:  Image(image:MemoryImage(base64Decode(list.author.profilePic)),
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${list.author.firstName} ${list.author.lastName}",style: Theme.of(context).textTheme.caption,),
                            const SizedBox(height:2,),
                            Text(" ${list.createdDate}",style: TextStyle(fontSize: 10,color: Colors.grey),),
                            const SizedBox(height:2,),
                            Row(
                              children: [
                                Icon(IconlyBold.time_circle,size: 12,color: Colors.grey,),
                                SizedBox(width: 2,),
                                Text("${CubitMainScreen.get(context).PastTimeAgo(
                                    list.createdDate)}",style: TextStyle(fontSize: 10,color: Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        TextButton(onPressed: (){
                          CubitMainScreen.get(context).follwoUnFollow(UserId: list.author.userId);
                          CubitMainScreen.get(context).getShortProfileFront(userId:list.author.userId);
                          CubitMainScreen.get(context).getUserAllProjectInProfileFront(userId:list.author.userId);
                          CubitMainScreen.get(context).getPaginatedPost(pageNumber: 1);
                          CubitMainScreen.get(context).getPaginatedProject(pageNumber: 1);

                          CubitMainScreen.get(context).PP=1;
                        }, child: list.isAuthorFollowed==false?Text("+ Follow"):Text("Following"))

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child:
                            Text(list.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style:Theme.of(context).textTheme.bodyText2,
                            ),),
                          SizedBox(width:5,),
                          Image(image: MemoryImage(base64Decode(list.coverPicture)),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:10 ),
                            child: IconButton(constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(
                                    IconlyLight.star,color: Colors.yellow)),
                          ),
                          Text("${list.usersWhoLiked}"),

                        ],
                      ),
                    )
                  ],
                ),
              )

          ),
        ),
      ),
    );
  }



}
