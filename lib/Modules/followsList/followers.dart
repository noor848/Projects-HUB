import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../shortProfile/shortProfile.dart';

class Followers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(title:const Text("Followers")),
            body:
            CubitMainScreen.get(context).FollowerProfile.length==0?Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(IconlyBroken.paper_fail,color: Colors.red,size: 250,),
                  Text("No Followeres",style: TextStyle(fontSize: 18),),],),
            ) :Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListView.separated(
                            scrollDirection:Axis.vertical,
                            shrinkWrap:true,
                            itemBuilder: (context, index)
                            {
                              return
                                CubitMainScreen.get(context).userProfileValues.id==CubitMainScreen.get(context).FollowerProfile[index].id?
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                        children: [
                                          CircleAvatar(
                                              radius: 20,
                                              backgroundImage:
                                              MemoryImage(base64Decode(CubitMainScreen.get(context).FollowerProfile[index].profilePicture!),)),
                                          const SizedBox(width: 20,),
                                          Text("${ CubitMainScreen.get(context).FollowerProfile[index].FirstName} ${CubitMainScreen.get(context).FollowerProfile[index].LastName}"
                                            ,style: TextStyle(fontSize: 18),

                                          ),
                                          Spacer(),
                                        ]),
                                  ),
                                ):
                                InkWell(
                                    onTap: (){
                                      CubitMainScreen.get(context).getContactProfile(RcvId: CubitMainScreen.get(context).FollowerProfile[index].id);
                                      CubitMainScreen.get(context).checktheIamfollowing(UserId: CubitMainScreen.get(context).FollowerProfile[index].id);
                                      CubitMainScreen.get(context).getShortProfileUserPost(userId: CubitMainScreen.get(context).FollowerProfile[index].id);
                                      CubitMainScreen.get(context).getShortProfileUserPost(userId: CubitMainScreen.get(context).FollowerProfile[index].id);
                                      CubitMainScreen.get(context).getUserAllProjectInProfileFront(userId: CubitMainScreen.get(context).FollowerProfile[index].id);

                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactProfile()));
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                            children: [
                                              CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage:
                                                  MemoryImage(base64Decode(CubitMainScreen.get(context).FollowerProfile[index].profilePicture!),)),
                                              const SizedBox(width: 20,),
                                              Text("${ CubitMainScreen.get(context).FollowerProfile[index].FirstName} ${CubitMainScreen.get(context).FollowerProfile[index].LastName}"
                                                ,style: TextStyle(fontSize: 18),
                                              ),
                                              Spacer(),
                                              Container(
                                                child: Text("View Profile",style: TextStyle(
                                                    fontSize: 15,fontFamily: 'SubHead',color: Colors.red
                                                ),),
                                              ),


                                            ]),
                                      ),
                                    ));},
                            separatorBuilder:  (context, index)=> Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Container(height:1,color: Colors.grey,width: double.infinity,),
                            ), itemCount: CubitMainScreen.get(context).FollowerProfile.length),
                      ),
                    ),

                  ],
                ),
              ),)
        ); },


      listener: (BuildContext context, Object? state) {
        if(state is CommentCreatedSuccess){
          Fluttertoast.showToast(
            msg: "Thank You !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );
        }
        if(state is CommentDeletedSuccess){
          Fluttertoast.showToast(
            msg: "Deleted Success !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );


        }
      },
    );
  }
}
