
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../Components/button.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';

class ImagePicker extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) {  return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text("Choose Image",style:Theme.of(context).textTheme.headline4,),
            SizedBox(height: 50,),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100,
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadiusDirectional.circular(100),
                      ),
                      child: CubitMainScreen.get(context)
                          .imageSignUp!=null?
                      Image.file(
                        CubitMainScreen.get(context)
                            .imageSignUp!,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ): Image.network("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
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
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 40,
                child:Button(context,() {

                },
                  fontWeight: FontWeight.w600,fontSize: 20.0,text: "Add ",
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100)
                ),
              ),
            ),
          ],
        ),
      ),
    );}, listener: (BuildContext context, Object? state) {  },
    );




  }
}
