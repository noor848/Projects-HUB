
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduationproject1/Modules/sendmessagewindow/SendMessage.dart';
import 'package:iconly/iconly.dart';

import '../../Components/button.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';

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
            appBar: AppBar(),
            body:CubitMainScreen.get(context).ContactmodeUserProfile==""?const Center(
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
                      SizedBox(height: 30,),
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
                      SizedBox(height: 15,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(vertical:4, horizontal: 15 ),
                                    child: Text("Following",style:TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'SubHead'))),
                                Text("${CubitMainScreen.get(context).ContactmodeUserProfile.following}",style:Theme.of(context).textTheme.labelMedium,)
                              ],
                            ),
                          ),
                          SizedBox(width:8)
                          , Container(
                            child: Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(vertical:4, horizontal: 15 ),
                                    child: Text("Followers",style:TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'SubHead'))),
                                Text("${CubitMainScreen.get(context).ContactmodeUserProfile.followers}",style:Theme.of(context).textTheme.labelMedium,)
                              ],

                            ),

                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
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
                            ), const SizedBox(width: 5,),
                            Container(

                              child: CubitMainScreen.get(context).checkTheIamfollowings==false?
                              OutlinedButton(onPressed: () {
                                CubitMainScreen.get(context).FollowUser(UserId: CubitMainScreen.get(context).ContactmodeUserProfile.id);
                                CubitMainScreen.get(context).checktheIamfollowing(UserId: CubitMainScreen.get(context).ContactmodeUserProfile.id);
                                },
                                child: const Text("+ Follow",style: TextStyle(
                                  fontSize: 18,fontFamily: 'SubHead',
                                ),),):
                              OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.red),
                                ),
                                onPressed: () {
                                CubitMainScreen.get(context).checktheIamfollowing(UserId: CubitMainScreen.get(context).ContactmodeUserProfile.id);
                              },
                                child: Text("Following",style: TextStyle(
                                  fontSize: 18,fontFamily: 'SubHead',color: Colors.white
                                ),),),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );}
    );
  }
}
