
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
            body:CubitMainScreen.get(context).Contactmode==null?const Center(
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
                      Text("${CubitMainScreen.get(context).Contactmode.FirstName+"'s"} Profile",style: const TextStyle(
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
                                child:CubitMainScreen.get(context).Contactmode.profilePicture.toString().isEmpty?Image.asset('assets/images/profileImage.jpg', height: 200,
                                  width: 200,
                                  fit: BoxFit.fill,): Image.memory(base64Decode(CubitMainScreen.get(context).Contactmode.profilePicture.toString()!),
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("${CubitMainScreen.get(context).Contactmode.FirstName} ${CubitMainScreen.get(context).Contactmode.LastName}", style:Theme.of(context).textTheme.headline3,),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            child: Text("${CubitMainScreen.get(context).userProfileValues.bio ?? "Yeeah This is Me...."}",style:Theme.of(context).textTheme.subtitle2,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              child: OutlinedButton(onPressed: () {
                              CubitMainScreen.get(context).AddContact(contactId:CubitMainScreen.get(context).Contactmode.id );
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  SendMessage(CubitMainScreen.get(context).Contactmode.profilePicture, CubitMainScreen.get(context).Contactmode.FirstName,CubitMainScreen.get(context).Contactmode.LastName, CubitMainScreen.get(context).Contactmode.id)),
                              );
                              },
                                child: Text("Message",style: TextStyle(
                                    fontSize: 18,fontFamily: 'SubHead',
                                ),),),
                            ), SizedBox(width: 5,),
                            Container(

                              child: CubitMainScreen.get(context).checkTheIamfollowings==false?
                              OutlinedButton(onPressed: () {
                                CubitMainScreen.get(context).FollowUser(UserId: CubitMainScreen.get(context).Contactmode.id);
                               // CubitMainScreen.get(context).getFollowings(UserId: null);
                                CubitMainScreen.get(context).checktheIamfollowing(UserId: CubitMainScreen.get(context).Contactmode.id);
                                },
                                child: Text("+ Follow",style: TextStyle(
                                  fontSize: 18,fontFamily: 'SubHead',
                                ),),):
                              OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.red),
                                ),
                                onPressed: () {
                                //CubitMainScreen.get(context).FollowUser(UserId: CubitMainScreen.get(context).Contactmode.id);
                                CubitMainScreen.get(context).followUNfollow(UserId: CubitMainScreen.get(context).Contactmode.id);
                              },
                                child: Text("Following",style: TextStyle(
                                  fontSize: 18,fontFamily: 'SubHead',color: Colors.white
                                ),),),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );}
    );
  }
}
