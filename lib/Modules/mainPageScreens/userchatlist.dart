import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
          return Center(
              child:
          CubitMainScreen.get(context)
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

  }, listener: (BuildContext context, Object? state) {
          if(state is DeletContactSuccessfully){
            Center(
              child: TextButton(
                child: const Text('Confirm Dialog'),
                onPressed: () async {
                  if (await confirm(context)) {
                    return print('pressedOK');
                  }
                  return print('pressedCancel');
                },
              ),
            );
            Fluttertoast.showToast(
              msg: "Deleted Successfully!",
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

  Widget Contacts(context,contactInfo){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      Dismissible(
        key: Key(contactInfo.id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction){
           CubitMainScreen.get(context).DeleteContact(RcvId:contactInfo.id);
           CubitMainScreen.get(context).deleteFirebaseMyMessage(receiverId: contactInfo.id);
        },
        background: Container(
          alignment: Alignment.centerRight,
          color:Colors.redAccent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.delete,color: Colors.white,size: 40,),
          ),
        ),
        child: InkWell(
          onTap: (){
          CubitMainScreen.get(context).getMessages(receiverId:contactInfo.id);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return SendMessage(contactInfo.profilePicture.toString()!,contactInfo.FirstName,contactInfo.LastName,contactInfo.id);}),
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
                        Image.memory(base64Decode(contactInfo.profilePicture.toString()!),
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
        ),
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
               // title: const Text("Delete Confirmation"),
                content: const Text("Are you sure you want to delete this item?"),
                actions: <Widget>[
                  MaterialButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Delete",style: TextStyle(color: Colors.red),)
                  ),
                  MaterialButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel",style: TextStyle(color: Colors.red),),
                  ),
                ],
              );
            },
          );
        },
      ),);


  }

}
