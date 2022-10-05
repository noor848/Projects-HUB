import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduationproject1/Modules/MainScreen/MainScreen.dart';
import 'package:graduationproject1/Modules/SignInScreen/signIn.dart';

class GoogleSignInOutApi{

  static final _clientIdWeb='137007676432-o1vns9ih0b6560cbvo9dhu0j8dbs0r95.apps.googleusercontent.com';
  static final _googleSignIn=GoogleSignIn(clientId:_clientIdWeb);
    static Future login(context)=>_googleSignIn.signIn().then((value) {
      if(value!=null) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()));
        print("Print Email${value.email}");
      }
    });

    static  Future<void> logOut(context)=>_googleSignIn.signOut();
}