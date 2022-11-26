
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';

class ContactProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>
      (
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${CubitMainScreen.get(context).Contactmode.Name+"'s"} Profile",style: TextStyle(
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
                      Text("${CubitMainScreen.get(context).Contactmode.Name}", style:Theme.of(context).textTheme.headline3,),
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
                        padding: const EdgeInsets.all(0.0),
                        child: Divider(
                          color: Colors.grey,
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
