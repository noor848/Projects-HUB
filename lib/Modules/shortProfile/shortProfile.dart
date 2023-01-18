import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduationproject1/Modules/followsList/followers.dart';
import 'package:graduationproject1/Modules/sendmessagewindow/SendMessage.dart';
import 'package:iconly/iconly.dart';
import '../../Components/getPosts.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../ViewProjectScreen/viewProjectScreen.dart';
import '../allUserPost/allUserPosts.dart';
import '../followsList/following.dart';
import '../viewPostScreen/viewpostscreen.dart';

class ContactProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>
      (
        listener: (BuildContext context, state) {
          if(state is FollowedSuccessfully)
          {
            Fluttertoast.showToast(
              msg: "Followed Successfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );


          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: CubitMainScreen.get(context).checkTheIamfollowings==false?
                    TextButton(onPressed: (){
                      CubitMainScreen.get(context).follwoUnFollow(UserId: CubitMainScreen.get(context).ContactmodeUserProfile.id);

                    }, child: Icon(IconlyBold.add_user,size: 40,)):
                    TextButton(onPressed: (){
                      CubitMainScreen.get(context).follwoUnFollow(UserId: CubitMainScreen.get(context).ContactmodeUserProfile.id);
                    }, child: Icon(Icons.verified_user_rounded,color: Colors.green,size: 40,))
                  ),
                )

              ],
            ),
            body:CubitMainScreen.get(context).ContactmodeUserProfile.LastName==""?const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ): Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${"${CubitMainScreen.get(context).ContactmodeUserProfile.FirstName}'s"} Profile",style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'HeadFont'
                      ),),
                      SizedBox(height: 10,),
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
                                  borderRadius: BorderRadiusDirectional.circular(100),
                                ),
                                child: Image.memory(base64Decode(CubitMainScreen.get(context).ContactmodeUserProfile.profilePicture.toString()),
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("${CubitMainScreen.get(context).ContactmodeUserProfile.FirstName} ${CubitMainScreen.get(context).ContactmodeUserProfile.LastName}", style:Theme.of(context).textTheme.headline3,),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            child: Text("${CubitMainScreen.get(context).ContactmodeUserProfile.bio==""?"Yeeah This Me...":CubitMainScreen.get(context).ContactmodeUserProfile.bio}",style:Theme.of(context).textTheme.subtitle2,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // width: double.infinity,
                              child: Expanded(
                                child: OutlinedButton(onPressed: () {
                                  CubitMainScreen.get(context).AddContact(contactId:CubitMainScreen.get(context).ContactmodeUserProfile.id );
                                  CubitMainScreen.get(context).getMessages(receiverId:CubitMainScreen.get(context).ContactmodeUserProfile.id);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  SendMessage(CubitMainScreen.get(context).ContactmodeUserProfile.profilePicture, CubitMainScreen.get(context).ContactmodeUserProfile.FirstName!,CubitMainScreen.get(context).ContactmodeUserProfile.LastName!, CubitMainScreen.get(context).ContactmodeUserProfile.id)),
                                  );
                                },
                                  child: Text("Message",style: TextStyle(
                                    fontSize: 18,fontFamily: 'SubHead',
                                  ),),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              CubitMainScreen.get(context).getFollowingList(userId: CubitMainScreen.get(context).ContactmodeUserProfile.id);
                              CubitMainScreen.get(context).checktheIamfollowing(UserId: CubitMainScreen.get(context).ContactmodeUserProfile.id);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Following()));

                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(vertical:4, horizontal: 15 ),
                                      child: Text("Following",style:TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'SubHead'))),
                                  Text("${CubitMainScreen.get(context).ContactmodeUserProfile.following}",style:Theme.of(context).textTheme.labelMedium,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width:8)
                          , InkWell(
                            onTap: (){
                              CubitMainScreen.get(context).getFollowersrList(userId:CubitMainScreen.get(context).ContactmodeUserProfile.id );
                              CubitMainScreen.get(context).checktheIamfollowing(UserId: CubitMainScreen.get(context).ContactmodeUserProfile.id);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Followers()));

                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(vertical:4, horizontal: 15 ),
                                      child: Text("Followers",style:TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'SubHead'))),
                                  Text("${CubitMainScreen.get(context).ContactmodeUserProfile.followers}",style:Theme.of(context).textTheme.labelMedium,)
                                ],

                              ),

                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Thumb-Nails ", textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 25, fontFamily: 'HeadFont'),),
                          Spacer(),
                          TextButton(onPressed: () {
                            CubitMainScreen.get(context).getShortProfileFront(userId: CubitMainScreen.get(context).ContactmodeUserProfile.id);
                            CubitMainScreen.get(context).getUserAllProjectInProfileFront(userId: CubitMainScreen.get(context).ContactmodeUserProfile.id);

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
                                          getUserProjects(CubitMainScreen.get(context).allFrontProjectProfile[index],context),
                                      separatorBuilder: (context, index) =>
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: SizedBox(height: 1,
                                                child: Container(
                                                  color: Colors.grey[300],)),
                                          ), itemCount: CubitMainScreen.get(context).allFrontProjectProfile.length)
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
          );}
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
  Widget getUserProjects(list,context){
    return InkWell(
      onTap: (){
        CubitMainScreen.get(context).getSpecificProjectView(projectId: list.id);
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewProjectScreen(CubitMainScreen.get(context).projectViewData)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(list.title,
                overflow: TextOverflow.ellipsis,
                maxLines:2,
                style:Theme.of(context).textTheme.bodyText2,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(IconlyLight.star,color: Colors.yellow,size: 20,)),
                  Text("${list.usersWhoLiked}",style: TextStyle(fontSize: 12),),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
