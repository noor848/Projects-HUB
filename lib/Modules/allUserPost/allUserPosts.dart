import 'dart:convert';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            initialIndex: CubitMainScreen.get(context).indexCratePostChanged,
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
                        onTap: () =>CubitMainScreen.get(context).ChangeIndexpage0(),
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
                        onTap: () =>CubitMainScreen.get(context).ChangeIndexpage1(),
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
                    children: <Widget>[
                      CubitMainScreen.get(context).frontShortPost.length==0?  Container(
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
                      )
                     /* Center(
                        child: ProjectCreate(),
                      ),*/
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
                        Text("${list.author.firstName} ${list.author.lastName}",style: Theme.of(context).textTheme.caption,),
                        const SizedBox(width: 10,),
                         Text("${list.createdDate}",style: TextStyle(fontSize: 10,color: Colors.grey),),
                        Spacer(),
                        TextButton(onPressed: (){
                        CubitMainScreen.get(context).deletPost(postId: list.id);
                        }, child: Text("Delete"))
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
}
