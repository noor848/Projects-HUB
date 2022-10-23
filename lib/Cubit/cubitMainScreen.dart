import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Model/messageModel.dart';
import 'package:graduationproject1/Service/DioHelper/Dio.dart';
import 'package:image_picker/image_picker.dart';
import '../Modules/mainPageScreens/PostCreat.dart';
import '../Modules/mainPageScreens/posts.dart';
import '../Modules/mainPageScreens/profile.dart';
import '../Modules/mainPageScreens/userchatlist.dart';
import '../Remote/end_points.dart';
import '../shared/postImageText.dart';
import '../shared/shared_prefrences.dart';
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

  void sendMessages({required RecieverId,required text}){
      MessageModel model = MessageModel(
        text: text,
        receiverId: RecieverId,
        senderId: "1234",
        date:Timestamp.now()
      );
      ////my chat part
    FirebaseFirestore.instance.collection("users").doc("1234").collection('chat')
      .doc(RecieverId).collection("messages").add(model.toMap()).then((value){
        emit(SocialSendMessageSuccess());
    }).onError((error, stackTrace){
      emit(SocialSendMessageError());
    });
      //receiver chat part
      FirebaseFirestore.instance.collection("users").doc(RecieverId).collection('chat')
          .doc("1234").collection("messages").add(model.toMap()).then((value){
        emit(SocialSendMessageSuccess());
      }).onError((error, stackTrace){
        emit(SocialSendMessageError());
      });

      getMessages(receiverId: "2");

  }

  List<MessageModel>messages=[];
  List<MessageModel>messagesLocal=[];
  void getMessages({
    required receiverId
  }){
    FirebaseFirestore.instance.collection("users").
    doc("1234").collection("chat").
    doc(receiverId)
        .collection('messages').orderBy("date")
    .snapshots().listen((event) {
      messages=[];
      event.docs.forEach((element) {
        messages.add(MessageModel.FromJson(element.data()));
      });
      emit(SocailGetMessageSuccessSate());
    });

  }
  void GetUserChatWith(){

    FirebaseFirestore.instance.collection("users").get().then((value){


      value.docs.forEach((element) {
        print(element.id);
      });
    });

  }
  
  void Login({
    password,
    email
}){
    DioHelpr.PostData(
        Url:LOGIN,data:
        {
          'password':password,
          'email':email
        }
    ).then((value) {

      print("Connected");
      emit(LoginSuccess());

    }).catchError((onError){
      print(onError.toString());
    });
    
    
  }
}