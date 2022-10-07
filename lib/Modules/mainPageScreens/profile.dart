import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Components/getPosts.dart';
import 'package:graduationproject1/Cubit/StateMainScreen.dart';
import 'package:graduationproject1/Cubit/cubitMainScreen.dart';
import 'package:iconly/iconly.dart';

import '../allUserPost/allUserPosts.dart';
import '../editProfile/editProfile.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) =>
          Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ProfileEdit()),
                    );
                  }, icon: Icon(IconlyLight.edit,size:25,)),
                ),
              ],
              automaticallyImplyLeading: false,
            ),
            body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                            child: Image.network("https://www.freeiconspng.com/thumbs/profile-icon-png/profile-icon-9.png"),
                          )
                      ),
                      IconButton(onPressed: (){},
                          icon: Icon(IconlyLight.camera
                            ,color: Colors.red,size:40,))
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("Noor Braik", style:Theme.of(context).textTheme.headline3,),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        child: Text("Yeeah This is Me....",style:Theme.of(context).textTheme.subtitle2,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Thumb-Nails ",textAlign: TextAlign.end,style: TextStyle(fontSize: 25,fontFamily: 'HeadFont'),),
                        Spacer(),
                        TextButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  UserPost()),
                          );

                        }, child: Text("Show All",style: TextStyle(
                            fontFamily: 'SubHead',fontSize: 15
                        ),)),
                        SizedBox(width: 10,)
                      ],
                    ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          borderOnForeground: true,
                          child: Container(
                              height: 200,
                              width: 150,
                              child: ListView.separated(
                                  itemBuilder: (context, index)=>getUserPosts(context),
                                  separatorBuilder:(context, index)=>Padding(
                                    padding: const EdgeInsets.only(left:20,right:20),
                                    child: SizedBox(height:1,child: Container(color: Colors.grey[300],)),
                                  ), itemCount: 5)
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: Container(
                              height: 200,
                              width: 150,
                              child: ListView.separated(
                                  itemBuilder: (context, index)=>getUserQuestions(context),
                                  separatorBuilder:(context, index)=>Padding(
                                    padding: const EdgeInsets.only(left:20,right:20),
                                    child: SizedBox(height:1,child: Container(color: Colors.grey[300],)),
                                  ), itemCount: 5)
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
          ),
        ),
      ),
          ),

    );
  }
}
