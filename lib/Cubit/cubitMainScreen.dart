import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Modules/mainPageScreens/PostCreat.dart';
import 'package:graduationproject1/Modules/mainPageScreens/posts.dart';
import 'package:graduationproject1/Modules/mainPageScreens/profile.dart';
import 'package:graduationproject1/shared/shared_prefrences.dart';
import 'package:image_picker/image_picker.dart';
import '../Modules/mainPageScreens/userchatlist.dart';
import '../shared/postImageText.dart';
import 'StateMainScreen.dart';

class CubitMainScreen extends Cubit<MainScreenState>{
  CubitMainScreen() : super(MainScreenIntialState());
  static CubitMainScreen get(context)=>BlocProvider.of(context);
  var listOfWholePostCreat=[];
  List<Widget>PagesScreen=[Posts(),ChatList(),PostCreate(),Profile()];
  int pageIndex=0;
  bool themeChange=false;
  bool VisibleIcon=true;
  var ImagePath="";
  int textFieldIndex=0;
  List<TextEditingController> textFieldController = [];
  List  textFieldCreate=[];
  List objectImageText=[];
  /////Generate TextFied
  void CreateTextFeildController(){
    textFieldController.add(new TextEditingController());
    emit(CreateController());
  }
  void AddTextField(context){
    CreateTextFeildController();
    var field=TextField(controller:textFieldController[textFieldIndex++],
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration:InputDecoration(
        hintStyle:Theme.of(context).textTheme.subtitle2,hintText:"Text......",enabledBorder:const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey,),),),);
    objectImageText.add(TextPost(value:textFieldController[textFieldIndex-1].text,style:"normal"));
    textFieldCreate.add(field);//list of textFeild
    listOfWholePostCreat.add(field);///list of whole elemnt in the post
    emit(TextFieldCreated());
  }
/////imagePicker
  File?_image;
  var ImagesList=[];
  Future GetImage()async{
    final image= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null) return;
    final imageTemporarly=File(image.path);
    _image=imageTemporarly;
    if(_image!=null){
      createImagePath(image.path).then((value) {
        print(value.toString());
        objectImageText.add(ImagePost(value));
        ImagesList.add(Image.file(_image!,fit: BoxFit.cover,height: 200,width: 200,));
        listOfWholePostCreat.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(_image!,fit: BoxFit.cover,height: 200,width: 200,)
              ),
            )));
      });
    }
    emit(ImagePickerLoad());
  }

  void  ChangeEyePasswordIcon(){
    VisibleIcon=!VisibleIcon;
    print(VisibleIcon);
    emit(ChangePsswordEyeICon());
  }
  Widget changeMainPageScreens(int index){
    emit(ChangeHomePageChioce());
    return PagesScreen[index];
  }
  void changeScreenIndex(int index){
    pageIndex=index;
    emit(ChangeBottomNavigationBarIndexState());
  }
  void changeThem({shared}) {
    if (shared != null) {
      themeChange = shared;
      emit(ThemChangeState());
    }
    else {
      themeChange = !themeChange;
      CacheHelper.setBool(key: "theme", value: themeChange);
      emit(ThemChangeState());
    }
  }

  void addHeaderText(context){
    CreateTextFeildController();
    var field=TextField(controller:textFieldController[textFieldIndex++],
      style: TextStyle(fontSize:60),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration:InputDecoration(
        hintStyle:Theme.of(context).textTheme.headline2,hintText:"Header1......",
        enabledBorder:const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey,),),),);

    objectImageText.add(TextPost(value:textFieldController[textFieldIndex-1].text,style:"h1"));
    listOfWholePostCreat.add(field);///list of whole elemnt in the post
    emit(TextHeaderFieldCreated());
  }
  void addHeader2Text(context){
    CreateTextFeildController();
    var field=TextField(controller:textFieldController[textFieldIndex++],
      style: TextStyle(fontSize:40),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration:InputDecoration(
        hintStyle:Theme.of(context).textTheme.headline4,hintText:"Header2......",
        enabledBorder:const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey,),),),);
    objectImageText.add(TextPost(value:textFieldController[textFieldIndex-1].text,style:"h2"));
    listOfWholePostCreat.add(field);///list of whole elemnt in the post
    emit(TextHeaderFieldCreated());
  }


  Future<String> createImagePath(imagepath) async {
    File imagefile = File(imagepath); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    return base64.encode(imagebytes); //convert bytes to base64 string
  }




}