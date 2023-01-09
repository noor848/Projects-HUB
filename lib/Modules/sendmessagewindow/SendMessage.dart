import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:graduationproject1/Model/messageModel.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../shortProfile/shortProfile.dart';

class SendMessage extends StatelessWidget {
  final boxFeildController = TextEditingController();
  String profilePicture="";
  String firstName="";
  String lastName="";
  String RcvId="";

  SendMessage(this.profilePicture, this.firstName, this.lastName,this.RcvId, {Key? key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) {
        return  Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: InkWell(
              onTap: (){
                CubitMainScreen.get(context).getContactProfile(RcvId:RcvId);
                CubitMainScreen.get(context).checktheIamfollowing(UserId: RcvId);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactProfile(
                  )),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:   Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child:
                      profilePicture.isEmpty?Image.asset('assets/images/profileImage.jpg', height: 40,
                        width: 40,
                        fit: BoxFit.fill,): Image.memory(base64Decode(profilePicture),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text("$firstName $lastName",style: Theme.of(context).textTheme.subtitle1,),
                ],
              ),
            ),
            actions: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: (){}, icon: Icon(Icons.error,color: Colors.grey[500],)),
            )],
          ),
          body:  Padding(
              padding: const EdgeInsets.all(10.0),
              child:
              StreamBuilder(
                stream:  FirebaseFirestore.instance
                    .collection(CubitMainScreen.get(context).userProfileValues.id)
                    .doc("chat")
                    .collection(RcvId)
                    .orderBy("date")
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CubitMainScreen.get(context).messages.length!=0 ?
                      Expanded(
                        child: ListView.separated(
                            itemBuilder:(context, index) {
                              var Message=CubitMainScreen.get(context).messages[index];
                              if(Message.senderId==CubitMainScreen.get(context).userProfileValues.id){
                                return MyMessage(Message,context);
                              }
                              return HisMessage(Message,context);
                            } , separatorBuilder:(context, index)=> SizedBox(
                          height: 15,
                        ), itemCount: CubitMainScreen.get(context).messages.length),
                      ):
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.zero,
                                  child: Icon(
                                    Icons.message_outlined,size: 300,color: Colors.redAccent[200],),
                                ),
                                Text("No Message Yet :)",style: TextStyle(
                                  fontSize: 18,fontFamily: 'SubHead',
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[200]!,
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: boxFeildController,
                                    /// focusNode: focusNode,
                                    textInputAction: TextInputAction.send,
                                    keyboardType: TextInputType.text,
                                    textCapitalization: TextCapitalization.sentences,
                                    style: Theme.of(context).textTheme.subtitle1,
                                    decoration: InputDecoration(
                                        border:InputBorder.none,
                                        hintText: "   Type Message Here.......",
                                        hintStyle: Theme.of(context).textTheme.subtitle1
                                    ),
                                  ),
                                ),
                              ),
                              MaterialButton(onPressed: (){
                                //CubitMainScreen.get(context).sendMessages(RecieverId: RcvId, text: boxFeildController.text,);
                                CubitMainScreen.get(context).GetImageChat(RecieverId: RcvId,);
                              },
                                minWidth: 1,
                                child: Icon(IconlyLight.image, color:Theme.of(context).errorColor,),

                              ),
                              MaterialButton(onPressed: (){
                               CubitMainScreen.get(context).sendMessages(RecieverId: RcvId, text: boxFeildController.text,);
                                //CubitMainScreen.get(context).deleteFirebaseMyMessage(receiverId: RcvId);

                                //CubitMainScreen.get(context).GetImageChat(RecieverId: RcvId,);
                              },
                                minWidth: 1,
                                child: Icon(IconlyLight.send, color:Theme.of(context).errorColor,),

                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              )

          )
      );
    },
    listener: (BuildContext context, Object? state) {


    },
    );
  }

  Widget MyMessage(MessageModel model,context)=>Align(alignment: AlignmentDirectional.topEnd, child: Container(
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
        ),
        padding:const  EdgeInsets.symmetric(
            vertical: 5,
            horizontal:10.0
        ),
        child:model.text!.isEmpty?
        Hero(
            tag: "hello",
            child: FullScreenWidget(child: Image.memory(base64Decode(model.image.toString()!),fit: BoxFit.cover,height: 200,width: 200,)),
        ):
          Text("${model.text}",
          style: TextStyle(color: Colors.red,fontFamily:'SubHead',fontSize: 16),
        ),
      ),);
  Widget HisMessage(MessageModel model,context)=> Align(
    alignment: AlignmentDirectional.topStart,
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      padding:const  EdgeInsets.symmetric(
          vertical: 5,
          horizontal:10.0
      ),
      child: model.text!.isEmpty? FullScreenWidget(child: Image.memory(base64Decode(model.image.toString()!),fit: BoxFit.cover,height: 200,width: 200,)):
      Text("${model.text}",
        style: TextStyle(color: Colors.white,fontFamily:'SubHead',fontSize: 16),
      ),
    ),
  );

}
