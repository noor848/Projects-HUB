import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:iconly/iconly.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../../PDFView/pdfView.dart';

class ProjectCreate extends StatelessWidget {
  final title2 = TextEditingController();
  final abstract = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>
      (builder: (BuildContext context, state)
    { return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: title2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 50),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.headline2,
                    hintText: "Title",
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              TextField(
                controller: abstract,
                style: const TextStyle(fontSize: 18),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.subtitle2,
                  hintText: "Abstract",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                  visible: CubitMainScreen.get(context).isVisible2,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(onPressed: (){
                      CubitMainScreen.get(context).ChangeVisibilityProjectCreate();
                    },child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconlyBroken.image_2,color:Theme.of(context).scaffoldBackgroundColor,size: 30,),
                        SizedBox(width: 15,),
                        Text("Choose Cover Image",style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,fontFamily: "SubHead",fontSize: 16
                        ),),
                      ],
                    )),
                  ),
                ),
              ),
              Visibility(
                  visible: !CubitMainScreen.get(context).isVisible2,
                  child:FullScreenWidget(child: Image.memory(base64Decode(CubitMainScreen.get(context).CoverImage2),/*,height: 200,*/width: double.infinity,fit: BoxFit.cover,))
              ),


              /////////////
              Visibility(
                visible: !CubitMainScreen.get(context).visiblefileChoose,
                child: Container(
                  width: double.infinity,
                  height: 70,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:
                    FloatingActionButton.extended(
                      label: Text('Upload' ,style:TextStyle(fontFamily: 'SubHead')), // <-- Text
                      backgroundColor: Colors.red,
                      icon: Icon( // <-- Icon
                        Icons.upload,
                        size: 24.0,
                      ),
                      onPressed: () {
                CubitMainScreen.get(context).pickFiles();
                      },
                    ),
                  ),
                ),
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Visibility(
                  visible: CubitMainScreen.get(context).visiblefileChoose,
                  child: InkWell(
                   onTap: ()=> CubitMainScreen.get(context).pickFiles(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            child: Card(
                              color: Colors.red[400],
                              child:Center(child: Text(".${CubitMainScreen.get(context).file.extension??'none'}",style: TextStyle(color:Theme.of(context).scaffoldBackgroundColor,fontSize: 40, fontFamily: 'SubHead'))) ,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:8,horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${CubitMainScreen.get(context).file.name}",style: TextStyle(fontFamily: 'SubHead',fontWeight: FontWeight.bold),),
                                Text("Size : ${((CubitMainScreen.get(context).file.size/1024)/1024)>=1?((CubitMainScreen.get(context).file.size/1024)/1024).toStringAsFixed(2)+"MB":(CubitMainScreen.get(context).file.size/1024).toStringAsFixed(2)}Kb",style: TextStyle(fontFamily: 'SubHead'),),
                              ],
                            ),
                          )
                        ],

                      ),
                    ),
                  ),
                ),
             ),
            ],
          ),
        ),
      ) ,
      floatingActionButton: Builder(builder: (BuildContext context)=>
          FloatingActionButton(
            onPressed: () {
              var ShowBottomSheet=
              showBottomSheet(context:context,builder:
                  (context)=>Container(
                child: Container(
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 20),
                          child: ElevatedButton(onPressed: () {
                              ///CoverImage2
                              ///filepath
                              ///title
                              ///abstract
                            ///
                            ///
                            ///

                          }, child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconlyBroken.send, color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor, size: 30,),
                              SizedBox(width: 15,),
                              Text("Submit", style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .scaffoldBackgroundColor,
                                  fontFamily: "SubHead",
                                  fontSize: 16
                              ),),
                            ],
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2,
                              horizontal: 20),
                          child: ElevatedButton(onPressed: () {
                            CubitMainScreen.get(context).ChangeVisibilityProjectCreate();

                          }, child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconlyBold.image, color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor, size: 30,),
                              SizedBox(width: 15,),
                              Text("Pick Up Image", style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .scaffoldBackgroundColor,
                                  fontFamily: "SubHead",
                                  fontSize: 16
                              ),),
                            ],
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2,
                              horizontal: 20),
                          child: ElevatedButton(onPressed: () {
                            title2.text="";
                            abstract.text="";
                         CubitMainScreen.get(context).clearProjectStuff();
                           ///CubitMainScreen.get(context).visiblefileChoose=false;
                          }, child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete, color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor, size: 30,),
                              SizedBox(width: 15,),
                              Text("Erase", style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .scaffoldBackgroundColor,
                                  fontFamily: "SubHead",
                                  fontSize: 16
                              ),),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
              ShowBottomSheet.closed.then((value) => {
                /// Navigator.pop(context)
              });
            },
            child: Icon(IconlyBroken.send),

          ),

      ),
    ); },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}
