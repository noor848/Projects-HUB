import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Modules/followsList/following.dart';
import 'package:iconly/iconly.dart';

import '../../Components/getPosts.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../../Model/shortPost.dart';
import '../allUserPost/allUserPosts.dart';
import '../editProfile/editProfile.dart';
import '../followsList/followers.dart';
import '../viewPostScreen/viewpostscreen.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen, MainScreenState>
      (listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Your Profile", style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'HeadFont'
                      ),),
                      SizedBox(height: 20,),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60,
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadiusDirectional
                                      .circular(100),
                                ),
                                child: Image.memory(base64Decode(CubitMainScreen
                                    .get(context)
                                    .userProfileValues
                                    .profilePicture
                                    .toString()!),
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              )
                          ),
                          IconButton(onPressed: () {
                            CubitMainScreen.get(context).ProfileImageUpdate();
                            print(CubitMainScreen
                                .get(context)
                                .userProfileValues
                                .id);
                            CubitMainScreen
                                .get(context)
                                .userProfileValues;
                          },
                              icon: Icon(IconlyLight.camera
                                , color: Colors.red, size: 40,))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("${CubitMainScreen
                          .get(context)
                          .userProfileValues
                          .FirstName} ${CubitMainScreen
                          .get(context)
                          .userProfileValues
                          .LastName}", style: Theme
                          .of(context)
                          .textTheme
                          .headline3,),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            child: Text("${CubitMainScreen
                                .get(context)
                                .userProfileValues
                                .bio == ""
                                ? "Yeeah This is Me...."
                                : CubitMainScreen
                                .get(context)
                                .userProfileValues
                                .bio}", style: Theme
                                .of(context)
                                .textTheme
                                .subtitle2,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              CubitMainScreen.get(context).getFollowingList();

                              ///CubitMainScreen.get(context).checktheIamfollowing(UserId: CubitMainScreen.get(context).userProfileValues.id);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Following()));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 15),
                                      child: Text("Following", style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontFamily: 'SubHead'))),
                                  Text("${CubitMainScreen
                                      .get(context)
                                      .userProfileValues
                                      .following}", style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelMedium,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8)
                          , InkWell(
                            onTap: () {
                              CubitMainScreen.get(context).getFollowersrList();
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Followers()));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 15),
                                      child: Text("Followers", style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontFamily: 'SubHead'))),
                                  Text("${CubitMainScreen
                                      .get(context)
                                      .userProfileValues
                                      .followers}", style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelMedium,)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Thumb-Nails ", textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 25, fontFamily: 'HeadFont'),),
                          Spacer(),
                          TextButton(onPressed: () {
                            CubitMainScreen.get(context).getShortProfileFront();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPost()),
                            );
                          }, child: Text("Show All", style: TextStyle(
                              fontFamily: 'SubHead', fontSize: 15
                          ),)),
                          SizedBox(width: 10,)
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              borderOnForeground: true,
                              child:Container(
                                  height: 180,
                                  width: 150,
                                  child: ListView.separated(
                                      itemBuilder: (context, index)
                                      {
                                        print(CubitMainScreen.get(context).shortPostUserProfile[index]);
                                            return getUserPosts(
                                                context,
                                                CubitMainScreen.get(context)
                                                        .shortPostUserProfile[
                                                    index]);
                                          },
                                      separatorBuilder: (context, index) =>
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: SizedBox(height: 1,
                                                child: Container(
                                                  color: Colors.grey[300],)),
                                          ), itemCount: CubitMainScreen.get(context)
                                      .shortPostUserProfile.length)
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: Container(
                                  height: 180,
                                  width: 150,
                                  child: ListView.separated(
                                      itemBuilder: (context, index) =>
                                          getUserQuestions(context),
                                      separatorBuilder: (context, index) =>
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: SizedBox(height: 1,
                                                child: Container(
                                                  color: Colors.grey[300],)),
                                          ), itemCount: 5)
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
  Widget getUserPosts(context,list){
    return InkWell(
      onTap: (){
        CubitMainScreen.get(context).getViewPost(postId: list.id);
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewPostScreen(CubitMainScreen.get(context).viewDataPost)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image(image: MemoryImage(base64Decode(list.coverPicture!)),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 5,),
              Text("${list.title}",
                overflow: TextOverflow.ellipsis,
                maxLines:2,
                style:Theme.of(context).textTheme.bodyText2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:5 ),
                      child: IconButton(constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,onPressed: (){},icon:Icon(IconlyLight.chat,color: Colors.blueGrey,)),
                    ),
                     Text("${list.comments}",style: TextStyle(fontSize: 12),),
                     SizedBox(width: 15,),
                    Padding(
                      padding: const EdgeInsets.only(right:5 ),
                      child: IconButton(constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(IconlyLight.heart,color: Colors.pinkAccent)),
                    ),
                     Text("${list.usersWhoLiked}",style:  TextStyle(fontSize: 12),)
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
