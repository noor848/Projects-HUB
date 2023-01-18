import 'dart:convert';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduationproject1/Modules/ViewProjectScreen/viewProjectScreen.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../viewPostScreen/viewpostscreen.dart';

class UserPost extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(builder: (BuildContext context, state){

      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: DefaultTabController(
           /// initialIndex: CubitMainScreen.get(context).ShowAll,
            length: 2,
            child: Column(
              children: <Widget>[
                ButtonsTabBar(
                  backgroundColor: Colors.red,
                  unselectedBackgroundColor: Colors.grey[300],
                  unselectedLabelStyle: TextStyle(color: Colors.black,fontFamily: 'SubHead'),
                  labelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontFamily: 'SubHead'),
                  tabs:[
                    Tab(
                      icon: InkWell(
                       /// onTap: () =>CubitMainScreen.get(context).ChangeIndexpage0(),
                        child:
                        Row(
                          children: const[
                            Icon(Icons.style),
                            SizedBox(width: 5,),
                            Text("post",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                            SizedBox(width: 5,),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      icon: InkWell(
                       onTap: () =>CubitMainScreen.get(context).ShowAllpage1(),
                        child:Row(
                          children: const[
                            Icon(Icons.star_border),
                            SizedBox(width: 5,),
                            Text("Project",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                            SizedBox(width: 5,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                  Container(
                    child: CubitMainScreen.get(context).frontShortPost.length==0?  Container(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(IconlyBroken.discovery,color: Colors.red,size: 250,),
                          Text("No Post",style: TextStyle(fontSize: 18),),],),

                    ) :SingleChildScrollView(
                      child:
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index)=>getPostsUserFront(context,CubitMainScreen.get(context).frontShortPost[index]),
                        itemCount: CubitMainScreen.get(context).frontShortPost.length,
                      ),
                    ),
                  ),
                      Container(
                        child: CubitMainScreen.get(context).allFrontProjectProfile.length==0?  Container(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(IconlyBroken.time_circle,color: Colors.red,size: 250,),
                              Text("No Projects",style: TextStyle(fontSize: 18),),],),

                        ) :SingleChildScrollView(
                          child:
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                getProjects(CubitMainScreen.get(context).allFrontProjectProfile[index],context),
                            itemCount: CubitMainScreen.get(context).allFrontProjectProfile.length,
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }, listener: (BuildContext context, state){

      if(state is DeletePostSuccess){
        Fluttertoast.showToast(
          msg: "Delete Success !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );

      }

    });
  }



  Widget getPostsUserFront(context,list){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: (){
            CubitMainScreen.get(context).getViewPost(postId: list.id);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewPostScreen(CubitMainScreen.get(context).viewDataPost)));
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
                          child:  Image(image:MemoryImage(base64Decode(list.author.profilePic!)),
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${list.author.firstName} ${list.author.lastName}",style: Theme.of(context).textTheme.caption,),
                            const SizedBox(height:2,),
                            Text("${list.createdDate}",style: TextStyle(fontSize: 10,color: Colors.grey),),
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
                        CubitMainScreen.get(context).userProfileValues.id==list.author.userId?
                        TextButton(onPressed: (){
                          CubitMainScreen.get(context).deletPost(postId: list.id,userid: list.author.userId);
                        }, child: Text("Delete")):
                        TextButton(onPressed: (){
                          CubitMainScreen.get(context).follwoUnFollow(UserId: list.author.userId);
                          CubitMainScreen.get(context).getShortProfileFront(userId:list.author.userId);
                          CubitMainScreen.get(context).getUserAllProjectInProfileFront(userId:list.author.userId);

                        }, child: list.isAuthorFollowed==false?Text("+ Follow"):Text("Following"))

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${list.title}",
                            style:Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 10,),
                          Image(image: MemoryImage(base64Decode(list.coverPicture!)),
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:10 ),
                            child: IconButton(constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(
                                    IconlyLight.heart,color: Colors.pinkAccent)),
                          ),
                           Text("${list.usersWhoLiked}"),
                          const SizedBox(width: 20,),
                          Padding(
                            padding: const EdgeInsets.only(right:10 ),
                            child: IconButton(constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(
                                    IconlyLight.chat,color: Colors.blueGrey)),
                          ),
                          Text("${list.comments}"),
                          const SizedBox(width: 20,),

                          /* Padding(
                            padding: const EdgeInsets.only(right:10 ),
                            child: IconButton(constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(IconlyLight.star,color: Colors.yellow,)),
                          ),
                          const Text("300")*/
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



  Widget getProjects(list,context){
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
                  CubitMainScreen.get(context).userProfileValues.id==list.author.userId?
                  TextButton(onPressed: (){
                   CubitMainScreen.get(context).deleteProject(projectId: list.id,userid: list.author.userId);
                  }, child: Text("Delete")):
                  TextButton(onPressed: (){
                    CubitMainScreen.get(context).follwoUnFollow(UserId: list.author.userId);
                    CubitMainScreen.get(context).getShortProfileFront(userId:list.author.userId);
                    CubitMainScreen.get(context).getUserAllProjectInProfileFront(userId:list.author.userId);
                    print(list.isAuthorFollowed);

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


/*

  */