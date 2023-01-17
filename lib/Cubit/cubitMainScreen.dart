import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:graduationproject1/Model/UserProfileModel.dart';
import 'package:graduationproject1/Model/messageModel.dart';
import 'package:graduationproject1/Service/DioHelper/Dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:open_file/open_file.dart';
import '../Constants.dart';
import '../Model/comment.dart';
import '../Model/contactModel.dart';
import '../Model/postView.dart';
import '../Model/shortPost.dart';
import '../Modules/TappedCreatePost/tabWindos.dart';
import '../Modules/mainPageScreens/posts.dart';
import '../Modules/mainPageScreens/userchatlist.dart';
import '../shared/postImageText.dart';
import '../shared/shared_prefrences.dart';
import 'StateMainScreen.dart';
import 'contactModel.dart';
enum ChunksTypeEnumeration{
  Image,
  Header1,
  Header2,
  Normal
}
class CubitMainScreen extends Cubit<MainScreenState> {
  CubitMainScreen() : super(MainScreenIntialState());

  static CubitMainScreen get(context) => BlocProvider.of(context);
  var listOfWholePostCreat = [];
  List<Widget> PagesScreen = [Posts(), /*PostCreate()*/ Tap(),ChatList()];
  int pageIndex = 0;
  bool themeChange = false;
  bool VisibleIcon = true;
  var ImagePath = "";
  int textFieldIndex = 0;
  List<TextEditingController> textFieldController = [];
  List textFieldCreate = [];
  List objectImageText = [];
  bool isVisible=true;
  bool bottomModal=true;
  String CoverImage="";
  Uint8List? CoverImageunit;
  Uint8List? normalImageUnit;
  String normalImage="";


  void changebottomModalVisibility(){
    if(bottomModal){
      bottomModal=false;
    }
    else{
      bottomModal=true;
    }
    emit(ChangeBottomModalSheetVisibility());
  }

   Future<void> ChangeVisibility() async { ////// web need to be fixed
     if (kIsWeb) {
      final temp = (await ImagePicker().getImage(source: ImageSource.camera, imageQuality:80));
      if (temp == null) return;
      isVisible=false;
      CoverImageunit = await temp?.readAsBytes();
      CoverImage=base64Encode(CoverImageunit!);
      emit(ImagePickerLoad());
     }
     else{
       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
       if (image == null) return;
       isVisible=false;
       final imageTemporarly = File(image.path);
       CoverImageunit = imageTemporarly.readAsBytesSync();
        CoverImage=base64Encode(CoverImageunit!);
       emit(ImagePickerLoad());
     }
   }

  /////Generate TextFied
  void CreateTextFeildController() {
    textFieldController.add(new TextEditingController());
    emit(CreateController());
  }

  List PostChnk=[];
  List LastUpdatePostChnk=[];
  void AddNormalTextField(context) {
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
    listOfWholePostCreat.add(field);///list of whole element in the post
    PostChnk.add(  {
      "chunkType": 3,
      "body": textFieldController[textFieldIndex - 1].text
    } );
    emit(TextFieldCreated());
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

   /// objectImageText.add(TextPost(
        ///value: textFieldController[textFieldIndex - 1].text, style: "h1"));
   /// print(textFieldController[textFieldIndex - 1].text);
    listOfWholePostCreat.add(field);
    PostChnk.add({
      "chunkType": 1,
      "body": textFieldController[textFieldIndex - 1].text
    } );
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
    PostChnk.add({
      "chunkType": 2,
      "body": textFieldController[textFieldIndex - 1].text
    } );    listOfWholePostCreat.add(field);///list of whole elemnt in the post
    emit(TextHeaderFieldCreated());
  }

/////imagePicker
  File? _image;
  var ImagesList = [];

  Future GetImage() async {
    if (kIsWeb) {
      final temp = (await ImagePicker().getImage(source: ImageSource.camera, imageQuality:80));
      if (temp == null) return;
      normalImageUnit = await temp?.readAsBytes();
      PostChnk.add({
        "chunkType": 0,
        "body": base64Encode(normalImageUnit!)
      } );
      listOfWholePostCreat.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FullScreenWidget(
                  child: Container(
                     height: 200,
                      width: 200,
                    child: Image.memory(
                      base64Decode(base64Encode(normalImageUnit!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          )));
      emit(TextFieldCreated());
      emit(ImagePickerLoad());
    }
    else{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      PostChnk.add({
        "chunkType": 0,
        "body": base64Encode(File(image.path).readAsBytesSync())
      } );
      listOfWholePostCreat.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: FullScreenWidget(
            child: Container(
              height: 200,
              width: 200,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    base64Decode(base64Encode(File(image.path).readAsBytesSync())),
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  )),
            ),
          )));
      emit(TextFieldCreated());
      emit(ImagePickerLoad());

  }
  }
  Future<void> UpdateUserImage({imagePath})  async {
    DioHelper.PutUserImage(
      idToken: userProfileValues.id,
      imagepath: base64Encode(imagePath).toString(),
    ).then((value) {
      emit(UpdateImageProfile());
      getProfile(UserId: null);

    }).catchError((onError){
      emit(UpdateImageProfile());
    });
  }

  Uint8List? ProfileImage;
  Future ProfileImageUpdate() async {
    if(kIsWeb){
      final temp = (await ImagePicker().
      getImage(source:ImageSource.camera,imageQuality:
      80));
      ProfileImage= await temp?.readAsBytes();
      DioHelper.PutUserImage(
        idToken: userProfileValues.id,
        imagepath: base64.encode(ProfileImage!),
      ).then((value) {
        emit(UpdateImageProfile());
        getProfile(UserId: null);
      }).catchError((onError){
        emit(UpdateImageProfile());
      });

      emit(ImagePickerLoad());

    }



    else{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporarly = File(image.path);
    ProfileImage = imageTemporarly.readAsBytesSync();
    UpdateUserImage(imagePath: ProfileImage);
    emit(ImagePickerLoad());
    }
  }
  Future<String> createImagePath64(imagepath) async {
    File imagefile = File(imagepath); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    return base64.encode(imagebytes); //convert bytes to base64 string
  }
  void ChangeEyePasswordIcon() {
    VisibleIcon = !VisibleIcon;
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

  void sendMessages({required RecieverId,text,image}) {
    MessageModel model = MessageModel(
        text: text,
        image: image,
        receiverId: RecieverId,
        senderId: userProfileValues.id,
        date: Timestamp.now());
    ////my chat part
    FirebaseFirestore.instance
        .collection(userProfileValues.id)
        .doc('chat')
        .collection(RecieverId)
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).onError((error, stackTrace) {
      emit(SocialSendMessageError());
    });
    //receiver chat part
    FirebaseFirestore.instance
        .collection(RecieverId)
        .doc('chat')
        .collection(userProfileValues.id)
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).onError((error, stackTrace) {
      emit(SocialSendMessageError());
    });
    getMessages(receiverId: RecieverId);

    AddContact(contactId: RecieverId);


  }

  List<MessageModel> messages = [];
  List<MessageModel> messagesLocal = [];

  void getMessages ({required receiverId}) async{

    FirebaseFirestore.instance
        .collection(userProfileValues.id)
        .doc("chat")
        .collection(receiverId)
        .orderBy("date")
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.FromJson(element.data()));

        emit(SocailGetMessageSuccessSate());
      });

    });
    emit(SocailGetMessageSuccessSate());
  }

  bool checkvValidUrl(link){
   bool checkUrl= Uri.parse(link).isAbsolute;
  emit(CheckUrlValid());
   return checkUrl;
  }



  void GetUserChatWith() {
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
      });
    });
  }
  void Login({password, email}) {
    DioHelper.LogIn(
      password: password.toString(),
      email: email.toString(),
    ).then((value) {
   ///   print(value);
      if (value == "User Not Found") {
        emit(LoginFailed());
        return;
      }
      setToken(token: value.toString());
      emit(LoginSuccess());
     ////print(loggedInUserId);
      getProfile(UserId: null);
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginFailed());
    });
  }

  String loggedInUserId = "";
  late UserProfileModel userProfileValues =UserProfileModel();
  void setToken({token}){

    Map<String, dynamic> payload = Jwt.parseJwt(token);
    loggedInUserId = payload["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];
    UserToken=token;
    getProfile(UserId: null);
    emit(TokenSet());
  }

  String imageSignUpPath="";
  File? imageSignUp;

  Future<void> SignUpImage() async {

    if(kIsWeb){
      final temp = (await ImagePicker().
      getImage(source:ImageSource.camera,imageQuality:
      80));
      if(temp==null) {
        return;
      }
      Uint8List? x= await temp?.readAsBytes();
      imageSignUpPath=base64.encode(x!);

    emit(ImagePickerLoad());
    }else{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporarly = File(image.path);
      imageSignUpPath=base64Encode(imageTemporarly.readAsBytesSync()!);

    emit(ImagePickerLoad());
    }

  }

  Future<void> SignUp({FirstName, LastName, email, password}) async {
    if(imageSignUpPath==""){
      ByteData byteData = await rootBundle.load("assets/images/profile.png");
      Uint8List bytes = byteData.buffer.asUint8List();
      imageSignUpPath = base64.encode(bytes);
      print(imageSignUpPath);
      emit(DefualtImage());
      DioHelper.SignUp(
          password: password,
          email: email,
          image: imageSignUpPath,
          FirstName: FirstName,
          LastName: LastName)
          .then((value) {
        if (value.toString() == "User Already Exists") {
          emit(SignedUpFailed());
          return;
        } else {
          ///setToken(token:value.toString());
          imageSignUp = null;
          emit(SignedUpSuccess());
        }
      }).catchError((onError) {
        emit(SignedUpFailed());
      });
    }


  }

  Future<void> putDefulatImage() async {
    if(imageSignUpPath==""){
      ByteData byteData = await rootBundle.load("assets/images/profile.png");
      Uint8List bytes = byteData.buffer.asUint8List();
      imageSignUpPath = base64.encode(bytes);
      print(imageSignUpPath);
      emit(DefualtImage());

    }
  }

  void SetValues({email, pass, firstname, lastname}) {
    email = email;
    pass = pass;
    firstname = firstname;
    lastname = lastname;
    emit(KeepValuesFieldUpdated());
  }

  void UpdateBio({bio}){
    DioHelper.PutUserBio(idToken: loggedInUserId,bio: bio).then((value) {
      print(value.statusCode);
     /// getProfile(UserId: loggedInUserId);
      emit(UpdateBioText());
    });}
  void UpdateUseName({FirstName,LastName}){
    DioHelper.PutUserName(idToken: loggedInUserId,FirstName: FirstName,lastName:LastName).then((value) {
      print(value.statusCode);
    /// getProfile(UserId: loggedInUserId);
      emit(UpdateUserFirasLstName());
    });}


  void UpdatePassword({NewPassword,OldPassword}){
    DioHelper.PutUserPassword(idToken: loggedInUserId,NewPassword: NewPassword,oldPassword:OldPassword).then((value) {
      if(value.statusCode==401||value.statusCode==400||value.statusCode==404){
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
  }

  List ContactList =[];
  List<UserProfileModel> UserProfileValues =[];
void getContactList(){
  UserProfileValues =[];
  ContactList =[];

  DioHelper.GetUserContacts().then((value) {
    ContactList = json.decode(value.body);
    print(ContactList);
    for(int i=0;i<ContactList.length;i++){
      ///var ContactItem= ContactModel.fromJson(ContactList[i]);

      DioHelper.GetUserProfile(idToken:ContactList[i]).then((value) async {
        var user =  await json.decode(value.body);
        UserProfileValues.add(UserProfileModel.fromJson(user));
        emit(GetUserProfile());
      });
    }
    emit(GetContactList());
  });


}
Future GetImageChat({RecieverId}) async {
  if(kIsWeb){
    final temp = (await ImagePicker().
    getImage(source:ImageSource.camera,imageQuality:
    80));
    Uint8List? x= await temp?.readAsBytes();
    sendMessages(RecieverId:RecieverId,image: base64.encode(x!),text:"");
    emit(ImagePickerLoad());
  }else{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporarly = File(image.path);
    _image = imageTemporarly;
    if (_image != null) {
      createImagePath64(image.path).then((value) {
        sendMessages(RecieverId:RecieverId,image:value,text:"");
      });
    }
    emit(ImagePickerLoad());
  }}




void DeleteContact({RcvId}){

  DioHelper.DeleteContact(Token: loggedInUserId,ContactId: RcvId).then((value) {

      deleteFirebaseMyMessage(receiverId: RcvId);
      getContactList();
      emit(DeletContactSuccessfully());

  }).onError((error, stackTrace){
    emit(DeletContactFailed());

  });

  }

  void deleteFirebaseMyMessage({required receiverId})async{
   var collection = FirebaseFirestore.instance.collection(userProfileValues.id).doc('chat').collection(receiverId);
   var snapshots = await collection.get();
   for (var doc in snapshots.docs) {
     await doc.reference.delete();
   }
   emit(DeleteFirebaseMyPartOfMessage());
  }




  late Contactmodl Contactmode = Contactmodl();

  late UserProfileModel ContactmodeUserProfile = UserProfileModel();

  void getContactProfile({RcvId}){
    DioHelper.GetUserProfile(idToken: RcvId).then((value) {
       var user = json.decode(value.body);
       ContactmodeUserProfile = UserProfileModel.fromJson(user);
      emit(GetContactProfile());
    }).catchError((onError){
      print(onError.toString());
    });

  }
  void AddContact({contactId}) {
    DioHelper.AddContact(ContactId: contactId, idToken: loggedInUserId).then((value) {
      emit(AddContactSuccessfully());
    }).catchError((onError) {});
  }


  void getFollowers({UserId}){
    DioHelper.GetFollowers(UserId: UserId).then((value){
      follower=json.decode(value.body);
      emit(GetFollowers());
    }).catchError((onError) {});
  }


  void uNFollowUser({UserId}){
    DioHelper.UnFollowUser(UserId: UserId).then((value){
      emit(UnfollowSuccess());
      getContactProfile(RcvId: UserId);
      getShortProfileFront(userId:UserId);
    getProfile();

    }).catchError((onError) {});
  }

  void FollowUser({UserId}){
    DioHelper.FollowUser(UserId: UserId).then((value){
      print(value.body);
      emit(FollowedSuccessfully());
      getContactProfile(RcvId: UserId);
     getProfile();
      getShortProfileFront(userId:UserId);

    }).catchError((onError) {});
  }
bool checkTheIamfollowings=false;
bool x=false;

  void follwoUnFollow({UserId}){///the guy
    x=false;
    DioHelper.GetFollowing().then((value){///My followings --when i follow the guy so means i have it as a following
     List following =json.decode(value.body);
     following.forEach((element) {
       if(element==UserId){ // I do so unfllow him
         x=true;
       }
     });

     if(x){
       checkTheIamfollowings=false;
       uNFollowUser(UserId: UserId);
      // GetContactProfile();
       ///ChecktheIamfollowing
     }
     else{
       checkTheIamfollowings=true; /// idont so follow him
       FollowUser(UserId: UserId);
       print(checkTheIamfollowings);
      /// GetContactProfile();
     }
     emit(FollwoUnFollow());
    }).catchError((onError) {
      print(onError.toString());
    });
  }

bool followedOrNot=false;
 void checktheIamfollowing({UserId}){
   followedOrNot=false;
   print("${UserId}+++jjj");
   DioHelper.GetFollowing().then((value){///My followings --when i follow the guy so means i have it as a following
     List following =json.decode(value.body);
     following.forEach((element) {
       if(element==UserId){ // I do so unfllow him
         followedOrNot=true;
         followedOrNot=true;
         emit(ChecktheIamfollowing());
       }
     });
     if(followedOrNot){
       checkTheIamfollowings=true; // i do
       getContactProfile(RcvId: UserId);
       emit(ChecktheIamfollowing());

     }
     else{
       checkTheIamfollowings=false; /// idont
       getContactProfile(RcvId: UserId);
       emit(ChecktheIamfollowing());

     }

  ///   print(checkTheIamfollowings);
     emit(ChecktheIamfollowing());
   }).catchError((onError) {
     print(onError.toString());
   });

 }


/*
List xx=[];
List profileData=[];
  void checktheIamfollowingNotMe({UserId}){
    xx=[];
    profileData=[];

    DioHelper.GetFollowing().then((value){
      profileData=json.decode(value.body);
    emit(ChecktheIamfollowing());

    });
    DioHelper.GetFollowing(UserId: UserId).then((value){///My followings --when i follow the guy so means i have it as a following
      List following =json.decode(value.body);

      for(int i=0;i<profileData.length;i++){
        for(int j=0;j<following.length;j++){
          if(profileData[i]== following[j]){ // I do so unfllow him
            followedOrNot=true;
            xx.add(true);
          }else{
            xx.add(false);
          }

        }

      }


      if(followedOrNot){
        checkTheIamfollowings=true; // i do
        getContactProfile(RcvId: UserId);
      }
      else{
        checkTheIamfollowings=false; /// idont
        getContactProfile(RcvId: UserId);
      }
print(xx);
      ///   print(checkTheIamfollowings);
      emit(ChecktheIamfollowing());
    }).catchError((onError) {
      print(onError.toString());
    });

  }

*/



 List following=[];

  List <UserProfileModel> followingProfile=[];

 void getFollowingList({userId}){
   following=[];
   followingProfile=[];

   DioHelper.GetFollowing(UserId: userId).then((value){
     following=json.decode(value.body);
     for(int i=0;i<following.length;i++){
       ///var ContactItem= ContactModel.fromJson(ContactList[i]);
       DioHelper.GetUserProfile(idToken:following[i]).then((value) async {
         var user =  await json.decode(value.body);
         followingProfile.add(UserProfileModel.fromJson(user));
         emit(GetUserProfile());
       });
     }
     emit(GetFollowings());
   }).catchError((onError) {});


 }


  List follower=[];
  List <UserProfileModel> FollowerProfile=[];
 void getFollowersrList({userId}){
   follower=[];
   FollowerProfile=[];
   DioHelper.GetFollowers(UserId: userId).then((value){
     follower=json.decode(value.body);
     for(int i=0;i<follower.length;i++){
       ///var ContactItem= ContactModel.fromJson(ContactList[i]);
       DioHelper.GetUserProfile(idToken:follower[i]).then((value) async {
         var user =  await json.decode(value.body);
         FollowerProfile.add(UserProfileModel.fromJson(user));
         emit(GetUserProfile());
       });
     }
     emit(GetFollowings());
   }).catchError((onError) {});


 }





  void getProfile({UserId}){
    DioHelper.GetUserProfile(idToken: UserId).then((value) async {
      var user = await json.decode(value.body);
      userProfileValues = UserProfileModel.fromJson(user);
      emit(GetUserProfile());
    });

  }

  void AssignUserProfileModel({user}){

    userProfileValues = UserProfileModel.fromJson(user);

  }



  void createPost({
  title,coverPic,chunckList
}){
    DioHelper.CreatePost(
      title: title,
      coverPicture: coverPic,
      chunkList: chunckList
    ).then((value) {
      print(value.body);
     ClearPostData();
     emit(PostCreated());
  emit(TextFieldCreated());
    }).onError((error, stackTrace){
    print(error.toString());
    });

  }
  List RedoList=[];
  List RedoListObjects=[];

  void Undo(){
    if(PostChnk.isNotEmpty) {
      RedoList.add(PostChnk.last);
      RedoListObjects.add(listOfWholePostCreat.last);
      listOfWholePostCreat.removeLast();
      PostChnk.removeLast();
    }
    else {
      if(!isVisible){ ////image shows
      //  CoverImage="";
        isVisible=true;   /////disappear
      }
    }
   //// print(PostChnk);
    emit(TextFieldCreated());
  }
  void Redo(){
    ////print(listOfWholePostCreat);
    if(RedoList.isNotEmpty) {
      listOfWholePostCreat.add(RedoListObjects.last);
      RedoListObjects.remove(RedoListObjects.last);
      PostChnk.add(RedoList.last);
      RedoList.remove(RedoList.last);
    }else{
      if(isVisible && CoverImage!=""){ ///button and we have image
       // CoverImage="";
        isVisible=false;/// show the image
      }else if (CoverImage!="" &&isVisible==false){
        isVisible=false;/// show the image
      }else{
        isVisible=true;/// show the button
      }
    }
    ///print(PostChnk);
    emit(TextFieldCreated());
  }




  void ClearPostData(){
    PostChnk=[];
    textFieldController = [];
    textFieldCreate = [];
    objectImageText = [];
    listOfWholePostCreat = [];
    isVisible=true;
    textFieldIndex =0;
    LastUpdatePostChnk=[];
    RedoList=[];
    CoverImage="";
     RedoList=[];
     RedoListObjects=[];
    emit(TextFieldCreated());

  }

  String  PastTimeAgo(timestamp){
    final DateTime docDateTime = DateTime.parse(timestamp);
    var date = DateTime.fromMicrosecondsSinceEpoch(docDateTime.microsecondsSinceEpoch);
    final date2=DateTime.now();
    final difference=date2.difference(date);
    if (difference.inDays>8) {
      return DateFormat("dd-MM-yyyy HH:mm:ss").format(date);
    } else if((difference.inDays/7).floor()>=1)
    {
      return "Last week";
    }else if(difference.inDays>=2){
      return "${difference.inDays} days ago";
    }
    else if(difference.inDays>=1){
      return "1 day ago";
    }
    else if( difference.inHours>=2){
      return "${difference.inHours} hours ago";
    }
    else if(difference.inHours>=1){
      return "1 hour ago";
    }
    else if( difference.inMinutes>=2){
      return "${difference.inMinutes} minutes ago";
    }
    else if(difference.inMinutes>=1){
      return "1 minute ago";
    }
    else if(difference.inSeconds>=3){
      return "${difference.inSeconds} seconds ago";
    }
    return "Just now";
  }

  String  PastTimeAgo2(timestamp){
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    final date2=DateTime.now();
    final difference=date2.difference(date);
    if (difference.inDays>8) {
      return DateFormat("dd-MM-yyyy HH:mm:ss").format(date);
    } else if((difference.inDays/7).floor()>=1)
    {
      return "Last week";
    }else if(difference.inDays>=2){
      return "${difference.inDays} days ago";
    }
    else if(difference.inDays>=1){
      return "1 day ago";
    }
    else if( difference.inHours>=2){
      return "${difference.inHours} hours ago";
    }
    else if(difference.inHours>=1){
      return "1 hour ago";
    }
    else if( difference.inMinutes>=2){
      return "${difference.inMinutes} minutes ago";
    }
    else if(difference.inMinutes>=1){
      return "1 minute ago";
    }
    else if(difference.inSeconds>=3){
      return "${difference.inSeconds} seconds ago";
    }
    return "Just now";
  }


  late PostView viewDataPost=new PostView();
  var timeAgo="";


  void getViewPost({postId}){ /// loop according to the size then pass each id to it
    DioHelper.GetViewPost(PostId: "$postId").then((value){
     viewDataPost=PostView.fromJson(json.decode(value.body));
     timeAgo=PastTimeAgo(viewDataPost.createdDate);
  emit(ViewDataPost());
  emit(TimePassedAgo());
    }).catchError((onError){});
  }



   PlatformFile file = new PlatformFile(name: 'd',size: 50) ;
   bool visiblefileChoose =false;

  Uint8List? f;
  Uint8List? ff;
  Future<void> pickFiles() async {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["pdf"]
      );
      if(result==null)return;
      visiblefileChoose=true;
      file =result.files.first;
     /* print(file.path);
      print(file.bytes);*/
      if(kIsWeb){
        f=file.bytes;
        print(f);
      }else{
      ///  ff=result.files.first.bytes;
       // print(ff);
        OpenFile.open(file.path!);
      }
      emit(PickFile());
    }

  void openFile(PlatformFile file){
   OpenFile.open(file.path!);
  }




  int indexCratePostChanged=0;
  void ChangeIndexpage0(){
    indexCratePostChanged=0;
    emit(Page0());

  }
   void ChangeIndexpage1(){
    indexCratePostChanged=1;
    emit(Page1());

  }

  bool isVisible2=true;
  String CoverImage2="";
  Uint8List? CoverImageunit2;
  Future<void> ChangeVisibilityProjectCreate() async { ////// web need to be fixed
    if (kIsWeb) {
      final temp = (await ImagePicker().getImage(source: ImageSource.camera, imageQuality:80));
      if (temp == null) return;
      isVisible2 = false;
      CoverImageunit2 = await temp?.readAsBytes();
      CoverImage2=base64Encode(CoverImageunit2!);
      emit(ImagePickerLoad());
    }
    else{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      isVisible2 = false;
      final imageTemporarly = File(image.path);
      CoverImageunit2 = imageTemporarly.readAsBytesSync();
      CoverImage2 = base64Encode(CoverImageunit2!);
      emit(ImagePickerLoad());
    }
  }

  void clearProjectStuff(){
     CoverImage2="";
     CoverImageunit2=null;
     isVisible2=true;
     visiblefileChoose =false;
     ///file= "";
     emit(ClearProjectStuff());

  }
  void likeDisLike(){
    if(viewDataPost.isLiked==false){
      DioHelper.LikeviewPost(postId: viewDataPost.id).then((value){
        emit(LikedSuccess());
        getViewPost(postId:viewDataPost.id );
      }).catchError((onError){
        emit(LikedError());
      });
    }else if(viewDataPost.isLiked==true){
      DioHelper.UnLikeviewPost(postId: viewDataPost.id).then((value){
        emit(ULikedSuccess());
        getViewPost(postId:viewDataPost.id );
      }).catchError((onError){
        emit(ULikedError());
      });
    }

  }

  void AddCommentText({postId,body}){

    DioHelper.AddComment(postId: postId,body: body,chuckType: 3).then((value){
      emit(CommentCreatedSuccess());
      getListOfComments(postId: postId);
    }).catchError((onError){
      print(onError.toString());
      emit(CommentCreatedFailed());
    });

  }

  String commentImage="";
  Uint8List? commentImageunit;
  Future<void> AddCommentImage({postId,body}) async {
    if (kIsWeb) {
      final temp = (await ImagePicker().getImage(source: ImageSource.camera, imageQuality:80));
    if (temp == null) return;
      commentImageunit = await temp?.readAsBytes();
      commentImage=base64Encode(commentImageunit!);
    emit(ImagePickerLoad());
    }
    else{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporarly = File(image.path);
    commentImageunit = imageTemporarly.readAsBytesSync();
    commentImage=base64Encode(commentImageunit!);
    emit(ImagePickerLoad());
    }
    DioHelper.AddComment(postId: postId,body: commentImage,chuckType: 0).then((value){
      emit(CommentCreatedSuccess());
      getListOfComments(postId:postId );
    }).catchError((onError){
      print(onError.toString());
    emit(CommentCreatedFailed());});


  }


  void DeleteComment({postId,commentNumbr,}){
    DioHelper.DeleteComment(postId: postId,commentNum: commentNumbr).then((value){
      emit(CommentDeletedSuccess());
      getListOfComments(postId: postId);
    }).catchError((onError){print(onError.toString());});
  }


  List <dynamic> Comment=[];

  List <dynamic> CommentsData=[];
  void getListOfComments({postId}) {
    Comment=[];
   /// CommentsData=[];
    DioHelper.GetComments(PostId:postId ).then((value){
      CommentsData=[];
      Comment = json.decode(value.body);
      for(int i=0;i<Comment.length;i++){
         CommentsData.add(Commnet.fromJson(Comment[i]));
      }
    emit(GetCommentList());
    }).catchError((onError){
      print(onError.toString());
    });
  }



  List <ShortProfileModel> shortPostUserProfile=[];
  List SHortPost=[];

  void getShortProfileUserPost({userId}){

    DioHelper.GetUserProfile(idToken: userId).then((value) async {
      SHortPost=[];
      shortPostUserProfile=[];
      var user = await json.decode(value.body);
      var xx = UserProfileModel.fromJson(user);
     /// print(xx.posts);
      emit(GetUserProfile());

      xx.posts?.forEach((element) {
        DioHelper.GetShorPostUser(PostId: element).then((value){
          var post=json.decode(value.body);
          shortPostUserProfile.add(ShortProfileModel.fromJson(post));
          emit(GetShortProfileUser());

        }).catchError((onError){});

      });

    });
  }

List <dynamic>frontShortPost=[];


  void getShortProfileFront({userId}){
    frontShortPost=[];
    DioHelper.GetShorPostUserfrontPage(userId: userId).then((value){
      frontShortPost=[];
      List post=json.decode(value.body);
      post.forEach((element) {
        frontShortPost.add(ShortProfileModel.fromJson(element));
        print(ShortProfileModel.fromJson(element).isAuthorFollowed);
      });

      emit(GetShortFrontProfileUser());

    }).catchError((onError){});

  }

  void deletPost({postId,userid}){
    DioHelper.DeletePost(postId: postId).then((value) {
      emit(DeletePostSuccess());
      getShortProfileFront(userId: userid);
      getShortProfileUserPost(userId: userid);
    }).catchError((onError){});

  }


  void SignOut(){
    frontShortPost=[];
    SHortPost=[];
    shortPostUserProfile=[];
    Comment=[];
     CommentsData=[];
     commentImage="";
   commentImageunit;
     isVisible2=true;
     CoverImage2="";
    CoverImageunit2;
    indexCratePostChanged=0;
    file = new PlatformFile(name: 'd',size: 50) ;
     visiblefileChoose =false;
     PostView viewDataPost=new PostView();
     timeAgo="";
     RedoList=[];
     RedoListObjects=[];
    follower=[];
    FollowerProfile=[];
    following=[];
    followingProfile=[];
    followedOrNot=false;
     checkTheIamfollowings=false;
     x=false;

      Contactmode = Contactmodl();
      ContactmodeUserProfile = UserProfileModel();
    UserProfileValues =[];
    ContactList =[];
    NewPassword="";
     imageSignUpPath="";
     imageSignUp;
    loggedInUserId = "";
     messages = [];
   messagesLocal = [];
    ProfileImage;
    _image;
     ImagesList = [];
     PostChnk=[];
     LastUpdatePostChnk=[];

     listOfWholePostCreat = [];
     pageIndex = 0;
     VisibleIcon = true;
     ImagePath = "";
     textFieldIndex = 0;
   textFieldController = [];
     textFieldCreate = [];
     objectImageText = [];
     isVisible=true;
     bottomModal=true;
     CoverImage="";
     CoverImageunit;
     normalImageUnit;
     normalImage="";

     emit(LogOut());
  }


}
