import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Model/messageModel.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';

class SendMessage extends StatelessWidget {
  final boxFeildController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ///CubitMainScreen.get(context).getMessages(receiverId:  "2");
    return BlocConsumer<CubitMainScreen,MainScreenState>(builder: (BuildContext context, state) {
      print(CubitMainScreen.get(context).messages.length);
      return   Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("https://images.unsplash.com/photo-1664207251296-569bacae6f04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                ),
              ),
              SizedBox(width: 10,),
              Text("My Name",style: Theme.of(context).textTheme.subtitle1,),
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
                      if(Message.senderId=="1234"){
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
                              hintText: "Type Message Here.......",
                              hintStyle: Theme.of(context).textTheme.subtitle1
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(onPressed: (){
                      print(boxFeildController.text);
                      CubitMainScreen.get(context).sendMessages(RecieverId: "2", text: boxFeildController.text,);
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
