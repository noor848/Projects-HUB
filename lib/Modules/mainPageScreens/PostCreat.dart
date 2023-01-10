import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';

class PostCreate extends StatelessWidget {
  ///final GlobalKey _menuKey = GlobalKey();
    final Title = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) {
        CubitMainScreen cubic= CubitMainScreen.get(context);
        return Scaffold(
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: Title,
                                style: TextStyle(fontSize: 50),
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
                            Visibility(
                              visible: cubic.isVisible,
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                child: MaterialButton(onPressed: (){
                                  cubic.ChangeVisibility();
                                },child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(IconlyBroken.image,color: Colors.red,size: 60,),
                                    SizedBox(width: 15,),
                                    Text("Choose Cover Image",style: TextStyle(
                                        color: Colors.grey,fontFamily: "SubHead",fontSize: 16
                                    ),),
                                  ],
                                )),
                              ),
                            ),
                            Visibility(
                                visible: !cubic.isVisible,
                                child:Image.memory(base64Decode(cubic.CoverImage),height: 200,width: double.infinity,fit: BoxFit.cover,)
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection:Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                cubic.listOfWholePostCreat[index], itemCount:cubic.listOfWholePostCreat.length),
                            PopupMenuButton(
                              icon: Icon(Icons.add,size: 35,),
                              offset: Offset(0, 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                      .copyWith(topLeft: Radius.circular(0))),
                              padding: EdgeInsets.all(0),
                              elevation: 10,
                              color: Colors.grey.shade100,
                              position: PopupMenuPosition.under,
                             /// key: _menuKey,
                              itemBuilder: (_) => <PopupMenuItem<String>>[
                                PopupMenuItem(
                                    height: 30,
                                    onTap: (){
                                      cubic.addHeaderText(context);
                                    },
                                    child:const Text("Header 1",style:TextStyle(
                                      fontFamily: 'SubHead',fontSize: 17,color: Colors.red,),textAlign: TextAlign.center,)),
                                PopupMenuItem(
                                    height: 30,
                                    onTap: (){
                                      cubic.addHeader2Text(context);
                                    },
                                    child:const Text("Header 2",style:TextStyle(
                                      fontFamily: 'SubHead',fontSize: 17,color: Colors.red,),textAlign: TextAlign.center,)),
                                PopupMenuItem(
                                    height: 30,
                                    onTap: (){
                                      cubic.AddNormalTextField(context);
                                    },
                                    child:const Text("Normal",style:TextStyle(
                                      fontFamily: 'SubHead',fontSize: 17,color: Colors.red,),textAlign: TextAlign.center,)),
                                PopupMenuItem(
                                    height: 30,
                                    onTap: (){
                                      cubic.GetImage();
                                    },
                                    child:const Text("Image",style:TextStyle(
                                      fontFamily: 'SubHead',fontSize: 17,color: Colors.red,),textAlign: TextAlign.center,)),
                              ],
                              onSelected: (_) {
                                Navigator.pop(context);
                              },),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              cubic.createPost(title:Title.text,coverPic: cubic.CoverImage,chunckList: cubic.PostChnk);
            },
            child: Icon(Icons.send),
          ),
        );},
      listener: (BuildContext context, Object? state) {

        if(state is PostCreated){
          Title.text="";
          Fluttertoast.showToast(
            msg: "Post Created !",
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



/*Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              Column(
                children: [
                  Card(
                    shadowColor:Colors.black,
                    borderOnForeground : true,
                    elevation: 10,
                    child:
                    ExpansionTile(
                      title: Text("Title"),
                      subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),)
                      // trailing: Icon(Icons.arrow_forward_ios),
                      ,leading: Icon(Icons.add_circle),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                          child: TextFormField(
                              decoration:new InputDecoration.collapsed(
                                hintText: 'Title .......',
                                /*prefixIcon: Icon(Icons.edit,color: Colors.grey[300],),
                        hintText: "Title....",*/
                                hintStyle: Theme.of(context).textTheme.bodyText1,
                              )             ),

                        ),

                      ],
                    ),
                  ),
                  Card(
                    shadowColor:Colors.black,
                    borderOnForeground : true,
                    elevation: 10,
                    child:
                    ExpansionTile(

                      title: Text("Description"),
                      subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),)
                      // trailing: Icon(Icons.arrow_forward_ios),
                      ,leading: Icon(Icons.add_circle),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                          child: TextFormField(
                              decoration:new InputDecoration.collapsed(
                                hintText: 'Description .......',
                                /*prefixIcon: Icon(Icons.edit,color: Colors.grey[300],),
                        hintText: "Title....",*/
                                hintStyle: Theme.of(context).textTheme.bodyText1,
                              )),

                        ),
                        Card(
                          shadowColor:Colors.black,
                          borderOnForeground : true,
                          elevation: 10,
                          margin: EdgeInsets.all(8),
                          shape:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey, width: 1)
                          ),
                          child:
                          ExpansionTile(
                            title: Text("Header1"),
                            subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),)
                            // trailing: Icon(Icons.arrow_forward_ios),
                            ,leading: Icon(Icons.add_sharp),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                                child: TextFormField(
                                    decoration:new InputDecoration.collapsed(
                                      hintText: 'Title .......',
                                      /*prefixIcon: Icon(Icons.edit,color: Colors.grey[300],),
                        hintText: "Title....",*/
                                      hintStyle: Theme.of(context).textTheme.bodyText1,
                                    )             ),

                              ),

                            ],
                          ),
                        ),
                        Card(
                          shadowColor:Colors.black,
                          borderOnForeground : true,
                          elevation: 10,
                          margin: EdgeInsets.all(8),
                          shape:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey, width: 1)
                          ),
                          child:
                          ExpansionTile(
                            title: Text("Header1"),
                            subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),)
                            // trailing: Icon(Icons.arrow_forward_ios),
                            ,leading: Icon(Icons.add_sharp),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                                child: TextFormField(
                                    decoration:new InputDecoration.collapsed(
                                      hintText: 'Title .......',
                                      /*prefixIcon: Icon(Icons.edit,color: Colors.grey[300],),
                        hintText: "Title....",*/
                                      hintStyle: Theme.of(context).textTheme.bodyText1,
                                    )             ),

                              ),

                            ],
                          ),
                        )



                      ],
                    ),
                  ),
                  Card(
                    shadowColor:Colors.black,
                    borderOnForeground : true,
                    elevation: 10,
                    child:
                    ExpansionTile(
                      title: Text("Image"),
                      subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),)
                      // trailing: Icon(Icons.arrow_forward_ios),
                      ,leading: Icon(Icons.add_circle),
                      children: [
                        ListTile(
                        onTap: (){},
                          leading: Icon(Icons.image),
                          title: Text("Image 1"),
                          subtitle:Text("Choose main Image  for your project!",style: TextStyle(color: Colors.grey),) ,
                        ),
                      Divider(height: 1,color: Colors.grey,),
                        ListTile(

                          onTap: (){},
                          leading: Icon(Icons.image_search),
                          title: Text("Image 2"),
                          subtitle:Text("Choose Multi  Image  for your project!",style: TextStyle(color: Colors.grey),) ,
                        ),
                      ],
                    ),
                  )
                ],
              ),


            ],

          ),
        ),
      ),
    );*/
/*
Widget xx(){
  return   ListTile(

    leading: Icon(Icons.add),
    trailing: Icon(Icons.arrow_forward_ios),
    title: Text("Title"),
    subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),),
  );
}
*/
/*InputDecoration(
prefixIcon: Icon(Icons.edit,color: Colors.grey[300],),
hintText: "Title....",
hintStyle: Theme.of(context).textTheme.bodyText1,
enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, ),))

*/
//
