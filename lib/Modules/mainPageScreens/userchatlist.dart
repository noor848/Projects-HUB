
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
        builder: (BuildContext context, state) =>
        ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>  Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          CubitMainScreen.get(context).getMessages(receiverId:  "19f5f493-1c56-47e3-ad71-b4aed335de22");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  SendMessage()),
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
                      child:  Image(image:NetworkImage("https://images.unsplash.com/photo-1664207251296-569bacae6f04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Text("Noor Braik",style: Theme.of(context).textTheme.subtitle1,),
                    Spacer(),
                    IconButton(onPressed: (){}, icon: Icon(IconlyLight.send))
                    ,SizedBox(width: 10,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),),
        separatorBuilder: (context, index) => SizedBox(height: 0,), itemCount: 10)
      , listener: (BuildContext context, Object? state) {  });
  }
}
