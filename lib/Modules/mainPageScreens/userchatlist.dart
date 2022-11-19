
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Cubit/StateMainScreen.dart';
import 'package:graduationproject1/Cubit/cubitMainScreen.dart';
import 'package:graduationproject1/Modules/sendmessagewindow/SendMessage.dart';
import 'package:iconly/iconly.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CubitMainScreen,MainScreenState>(
        builder: (BuildContext context, state) {
          return Center(child: CubitMainScreen
              .get(context)
              .UserProfileValues.length!=0?ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  Contacts(context, CubitMainScreen
                      .get(context)
                      .UserProfileValues[index]),
              separatorBuilder: (context, index) => SizedBox(height: 0,),
              itemCount: CubitMainScreen
                  .get(context)
                  .UserProfileValues
                  .length):Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.archive,size: 200,color: Colors.redAccent,),
              Text("No Message Yet",style: TextStyle(fontSize: 15),)
            ],
          ));
        }, listener: (BuildContext context, Object? state) {  });
  }

  Widget Contacts(context,contactInfo){

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          CubitMainScreen.get(context).getMessages(receiverId:contactInfo.id);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  SendMessage(contactInfo.profilePicture,contactInfo.FirstName,contactInfo.LastName,contactInfo.id)),
          );
        },
        child: ClipPath(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.red, width: 5),
              ),
            ),
            child: Card(
              shadowColor:Colors.red,
              elevation: 5,
              shape:const RoundedRectangleBorder( //<-- SEE HERE
              ),
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child:
                      contactInfo.profilePicture.toString().isEmpty?Image.asset('assets/images/profileImage.jpg', height: 60,
                        width: 60,
                        fit: BoxFit.fill,): Image.memory(base64Decode(CubitMainScreen.get(context).userProfileValues.profilePicture.toString()!),
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Text("${contactInfo.FirstName} ${contactInfo.LastName}",style: Theme.of(context).textTheme.subtitle1,),
                    Spacer(),
                    IconButton(onPressed: (){}, icon: Icon(IconlyLight.send))
                    ,SizedBox(width: 10,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),);


  }

}
