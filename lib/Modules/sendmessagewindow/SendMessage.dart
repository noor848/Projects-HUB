import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Model/messageModel.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';

class SendMessage extends StatelessWidget {
  final boxFeildController = TextEditingController();
  String profilePicture="";
  String firstName="";
  String lastName="";
  String RcvId="";

  SendMessage(this.profilePicture, this.firstName, this.lastName,this.RcvId, {Key? key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(builder: (BuildContext context, state) {
      print(CubitMainScreen.get(context).messages.length);
      return   Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:   Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child:
                  profilePicture.toString().isEmpty?Image.asset('assets/images/profileImage.jpg', height: 50,
                    width: 50,
                    fit: BoxFit.fill,): Image.memory(base64Decode(CubitMainScreen.get(context).userProfileValues.profilePicture.toString()!),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Text("$firstName $lastName",style: Theme.of(context).textTheme.subtitle1,),
            ],
          ),

        ),
        body:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder:(context, index) {
                      var Message=CubitMainScreen.get(context).messages[index];
                      if(Message.senderId==CubitMainScreen.get(context).userProfileValues.id){
                        return MyMessage(Message);
                      }
                      return HisMessage(Message);
                    } , separatorBuilder:(context, index)=> SizedBox(
                  height: 15,
                ), itemCount: CubitMainScreen.get(context).messages.length),
              ),
              Container(
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
                      print(boxFeildController.text);
                      CubitMainScreen.get(context).sendMessages(RecieverId: RcvId, text: boxFeildController.text,);
                    },
                      minWidth: 1,
                      child: Icon(IconlyLight.send, color:Theme.of(context).errorColor,),

                    )
                  ],
                ),
              )
            ],
          ),
        )
      );
    },
    listener: (BuildContext context, Object? state) {  },
    );
  }

  Widget MyMessage(MessageModel model)=>Align(alignment: AlignmentDirectional.topEnd, child: Container(
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
        child: Text("${model.text}",
          style: TextStyle(color: Colors.red,fontFamily:'SubHead',fontSize: 16),
        ),
      ),);
  Widget HisMessage(MessageModel model)=> Align(
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
      child: Text(model.text,
        style: TextStyle(color: Colors.white70,fontFamily:'SubHead',fontSize: 17),
      ),
    ),
  );

}
