import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Model/UserProfileModel.dart';
import 'package:graduationproject1/Model/messageModel.dart';
import 'package:graduationproject1/Service/DioHelper/Dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../Modules/mainPageScreens/PostCreat.dart';
import '../Modules/mainPageScreens/posts.dart';
import '../Modules/mainPageScreens/profile.dart';
import '../Modules/mainPageScreens/userchatlist.dart';
import '../Remote/end_points.dart';
import '../shared/postImageText.dart';
import '../shared/shared_prefrences.dart';
import 'ContactList.dart';
import 'StateMainScreen.dart';

class CubitMainScreen extends Cubit<MainScreenState> {
  CubitMainScreen() : super(MainScreenIntialState());

  static CubitMainScreen get(context) => BlocProvider.of(context);
  var listOfWholePostCreat = [];
  List<Widget> PagesScreen = [Posts(), PostCreate(),ChatList()];
  int pageIndex = 0;
  bool themeChange = false;
  bool VisibleIcon = true;
  var ImagePath = "";
  int textFieldIndex = 0;
  List<TextEditingController> textFieldController = [];
  List textFieldCreate = [];
  List objectImageText = [];

  /////Generate TextFied
  void CreateTextFeildController() {
    textFieldController.add(new TextEditingController());
    emit(CreateController());
  }

  void AddTextField(context) {
    CreateTextFeildController();
    var field = TextField(
      controller: textFieldController[textFieldIndex++],
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.subtitle2,
        hintText: "Text......",
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
    objectImageText.add(TextPost(
        value: textFieldController[textFieldIndex - 1].text, style: "normal"));
    textFieldCreate.add(field); //list of textFeild
    listOfWholePostCreat.add(field);

    ///list of whole elemnt in the post
    emit(TextFieldCreated());
  }

/////imagePicker
  File? _image;
  var ImagesList = [];

  Future GetImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporarly = File(image.path);
    _image = imageTemporarly;
    if (_image != null) {
      createImagePath64(image.path).then((value) {
        objectImageText.add(ImagePost(value));
        ImagesList.add(Image.file(
          _image!,
          fit: BoxFit.cover,
          height: 200,
          width: 200,
        ));
        listOfWholePostCreat.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  )),
            )));
      });
    }
    emit(ImagePickerLoad());
  }

  void UpdateUserImage({imagePath})  {
    //print(base64Encode(imagePath).toString());
    DioHelper.PutUserImage(
      idToken: userProfileValues.id,
      imagepath: base64Encode(imagePath).toString(),
    ).then((value) {
      emit(UpdateImageProfile());
      DioHelper.GetUserProfile(idToken: Token).then((value) {
        var user = json.decode(value.body);
        userProfileValues = UserProfileModel.fromJson(user);
        emit(GetUserProfile());
      });

    }).catchError((onError){
      print(onError.toString());
      emit(UpdateImageProfile());
    });
  }

  Uint8List? ProfileImage;

  Future ProfileImageUpdate() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporarly = File(image.path);
    ProfileImage = imageTemporarly.readAsBytesSync();
   // print(ProfileImage);
    UpdateUserImage(imagePath: ProfileImage);
    emit(ImagePickerLoad());
  }

  Future<String> createImagePath64(imagepath) async {
    File imagefile = File(imagepath); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    return base64.encode(imagebytes); //convert bytes to base64 string
  }

  void ChangeEyePasswordIcon() {
    VisibleIcon = !VisibleIcon;
    print(VisibleIcon);
    emit(ChangePsswordEyeICon());
  }

  Widget changeMainPageScreens(int index) {
    emit(ChangeHomePageChioce());
    return PagesScreen[index];
  }

  void changeScreenIndex(int index) {
    pageIndex = index;
    if(index==2){
    getContactList();

    }
    emit(ChangeBottomNavigationBarIndexState());
  }

  void changeThem({shared}) {
    if (shared != null) {
      themeChange = shared;
      emit(ThemChangeState());
    } else {
      themeChange = !themeChange;
      CacheHelper.setBool(key: "theme", value: themeChange);
      emit(ThemChangeState());
    }
  }

  void addHeaderText(context) {
    CreateTextFeildController();
    var field = TextField(
      controller: textFieldController[textFieldIndex++],
      style: TextStyle(fontSize: 60),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.headline2,
        hintText: "Header1......",
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );

    objectImageText.add(TextPost(
        value: textFieldController[textFieldIndex - 1].text, style: "h1"));
    listOfWholePostCreat.add(field);

    ///list of whole elemnt in the post
    emit(TextHeaderFieldCreated());
  }

  void addHeader2Text(context) {
    CreateTextFeildController();
    var field = TextField(
      controller: textFieldController[textFieldIndex++],
      style: TextStyle(fontSize: 40),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.headline4,
        hintText: "Header2......",
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
    objectImageText.add(TextPost(
        value: textFieldController[textFieldIndex - 1].text, style: "h2"));
    listOfWholePostCreat.add(field);

    ///list of whole elemnt in the post
    emit(TextHeaderFieldCreated());
  }

  void sendMessages({required RecieverId, required text}) {
    MessageModel model = MessageModel(
        text: text,
        receiverId: RecieverId,
        senderId: userProfileValues.id,
        date: Timestamp.now());
    ////my chat part
    FirebaseFirestore.instance
        .collection("users")
        .doc(userProfileValues.id)
        .collection('chat')
        .doc(RecieverId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).onError((error, stackTrace) {
      emit(SocialSendMessageError());
    });
    //receiver chat part
    FirebaseFirestore.instance
        .collection("users")
        .doc(RecieverId)
        .collection('chat')
        .doc(userProfileValues.id)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).onError((error, stackTrace) {
      emit(SocialSendMessageError());
    });
    getMessages(receiverId: RecieverId);

  }

  List<MessageModel> messages = [];
  List<MessageModel> messagesLocal = [];

  void getMessages({required receiverId}) {

    FirebaseFirestore.instance
        .collection("users")
        .doc(userProfileValues.id)
        .collection("chat")
        .doc(receiverId)
        .collection('messages')
        .orderBy("date")
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.FromJson(element.data()));
      });

    });
    emit(SocailGetMessageSuccessSate());
  }


  void GetUserChatWith() {
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        print(element.id);
      });
    });
  }

  void Login({password, email}) {
    DioHelper.LogIn(
      password: password.toString(),
      email: email.toString(),
    ).then((value) {
      if (value == "User Not Found") {
        print("not foud insrif i3ml signup");
        emit(LoginFailed());
        return;
      }
      print("Signed In !");
      setToken(token: value.toString());
      emit(LoginSuccess());
      DioHelper.GetUserProfile(idToken: Token).then((value) {
        var user = json.decode(value.body);
        userProfileValues = UserProfileModel.fromJson(user);
        print(userProfileValues.FirstName);
        emit(GetUserProfile());
      });
    }).catchError((onError) {
      emit(LoginFailed());
      print(onError.toString());
    });
  }

  String Token = "";
  late UserProfileModel userProfileValues;
  void setToken({token}) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    print(payload[
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"]);
    Token = payload[
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];
    DioHelper.GetUserProfile(idToken: Token).then((value) {
      var user = json.decode(value.body);
      userProfileValues = UserProfileModel.fromJson(user);
      print(userProfileValues);
      emit(GetUserProfile());
    });
    emit(TokenSet());
  }
  var imageSignUpPath;
  File? imageSignUp;

  void SignUp({FirstName, LastName, email, password}) {
    DioHelper.SignUp(
            password: password,
            email: email,
            image: "",
            FirstName: FirstName,
            LastName: LastName)
        .then((value) {
      print("Signed Up Succefully!");
      if (value.toString() == "User Already Exists") {
        emit(SignedUpFailed());
        print("User Already Exists");
        return;
      } else {
        ///setToken(token:value.toString());
        imageSignUp = null;
        emit(SignedUpSuccess());
      }
    }).catchError((onError) {
      emit(SignedUpFailed());
      print(onError.toString());
    });
  }

  var email, pass, firstname, lastname;

  void SetValues({email, pass, firstname, lastname}) {
    email = email;
    pass = pass;
    firstname = firstname;
    lastname = lastname;
    emit(KeepValuesFieldUpdated());
  }
  void UpdateBio({bio}){
    DioHelper.PutUserBio(idToken: Token,bio: bio).then((value) {
      emit(UpdateBioText());

      DioHelper.GetUserProfile(idToken: Token).then((value) {
        var user = json.decode(value.body);
        userProfileValues = UserProfileModel.fromJson(user);
        print(userProfileValues.profilePicture);
        emit(GetUserProfile());
      });

    });}
  void UpdateUseName({FirstName,LastName}){
    DioHelper.PutUserName(idToken: Token,FirstName: FirstName,lastName:LastName).then((value) {
      emit(UpdateUserFirasLstName());
      DioHelper.GetUserProfile(idToken: Token).then((value) {
        var user = json.decode(value.body);
        userProfileValues = UserProfileModel.fromJson(user);
        emit(GetUserProfile());
      });
    });}
  void UpdatePassword({NewPassword,OldPassword}){
    DioHelper.PutUserPassword(idToken: Token,NewPassword: NewPassword,oldPassword:OldPassword).then((value) {
      print(value.statusCode);
      if(value.statusCode==401||value.statusCode==400){
        emit(BadRequestPassword());
      }
      else {
        emit(updatepassword());
      }    }).onError((error, stackTrace){
      emit(ErrorUpadatingPasssword());
    });}

  var NewPassword;
  void setNewPassword({NewPassword}){

    NewPassword=NewPassword;
    emit(DisableAndNotDiasbledPassword());
  }
  var isSamePassword;
  void Validate({confirmPassword}){

    if(confirmPassword.toString()==NewPassword.toString()){
      isSamePassword=true;
      emit(DisableAndNotDiasbledPassword());

    }
    else{
      isSamePassword=false;
      emit(DisableAndNotDiasbledPassword());

    }
    print(isSamePassword);

  }

  List<String> ContactList =[];
  List<UserProfileModel> UserProfileValues =[];
void getContactList(){
  UserProfileValues =[];
  ContactList =[];
  DioHelper.GetUserContacts(idToken: Token).then((value) {
    ContactList = List<String>.from(json.decode(value.body));
    print(ContactList.length);
    for(int i=0;i<ContactList.length;i++){
      DioHelper.GetUserProfile(idToken:ContactList[i]).then((value) {
        var user = json.decode(value.body);
        UserProfileValues.add(UserProfileModel.fromJson(user));
        print(UserProfileValues[i].FirstName);
        emit(GetUserProfile());
      });
    }
    emit(GetContactList());
  });


}


}
