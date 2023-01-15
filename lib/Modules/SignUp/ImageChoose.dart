
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../Components/button.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';

class ImagePicker extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) {

        return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text("Profile Image",style:TextStyle(fontFamily: 'subHead',fontSize:40,color: Colors.grey[700] ),),
            SizedBox(height: 50,),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                    radius: 100,
                    backgroundImage: MemoryImage(base64Decode(CubitMainScreen.get(context).imageSignUpPath)!,
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(onPressed: (){
                   CubitMainScreen.get(context).SignUpImage();
                  },
                      icon: Icon(IconlyLight.camera
                        ,color: Colors.red,size:50,)),
                ),

              ],
            ),

          ],
        ),
      ),
    );}, listener: (BuildContext context, Object? state) {  },
    );




  }

}
