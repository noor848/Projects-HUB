import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Service/DioHelper/Dio.dart';
import 'package:graduationproject1/shared/bloc_observer.dart';
import 'package:graduationproject1/shared/shared_prefrences.dart';
import 'Constants.dart';
import 'Cubit/StateMainScreen.dart';
import 'Cubit/cubitMainScreen.dart';
import 'Modules/SignInScreen/signIn.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();

 if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions( apiKey: "AIzaSyAudSusTqJP9QF_B6GyYZ96r3wkXFfMmho",
          authDomain: "projecth-3d059.firebaseapp.com",
          projectId: "projecth-3d059",
          storageBucket: "projecth-3d059.appspot.com",
          messagingSenderId: "546075392066",
          appId: "1:546075392066:web:3406a983bbadc54f8f55db",
          measurementId: "G-1VNGZ997PK")
    );

 }else
   {await Firebase.initializeApp();}

  ///DioHelpr.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool?isDark;
  CacheHelper.getBool(key:"theme").then((value){
    isDark=value!;
  });
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  bool?isDark;
  MyApp(isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) =>CubitMainScreen()..changeThem(shared: isDark),
      child:BlocConsumer<CubitMainScreen,MainScreenState>(
        builder: (BuildContext context, state) {
          CubitMainScreen cubic = CubitMainScreen.get(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: AnimatedSplashScreen(
                splash:Image.asset('assets/images/logo.png',width: double.infinity,fit: BoxFit.cover
                  ,
                ),
                nextScreen: SignIn(),
                backgroundColor: SecondaryColor,

              ),

              theme: ThemeData(
                  primarySwatch: Colors.red,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                      actionsIconTheme: IconThemeData(color: Colors.black),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'HeadFont'

                      ),
                      iconTheme: IconThemeData(
                          color: Colors.black
                      )

                  ),
                  dialogTheme: DialogTheme(
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                  ),

                  cardTheme:const CardTheme(
                    color: Colors.white,elevation: 20,
                    shadowColor: Colors.grey,
                    clipBehavior: Clip.antiAlias,
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.transparent
                  ),
                  textTheme: const TextTheme(
                    caption: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SubHead'
                    ),
                    bodyText2: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'SubHead'
                    ),
                    headline6: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 5,
                        fontFamily: 'SubHead'
                    ),
                    bodyText1: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'SubHead'
                    ),
                    subtitle1: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'SubHead'
                    ),
                    subtitle2: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: 'SubHead'
                    ),
                    headline3: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SubHead'
                    ),
                    headline5: TextStyle(
                        color: Colors.black54,fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.2,
                        fontFamily: 'SubHead',

                    ),
                    headline2: TextStyle(
                        color: Colors.grey,
                        fontSize: 50,
                        fontFamily: 'SubHead'
                    ),
                    labelMedium: TextStyle(
                        color: Colors.black54,fontWeight: FontWeight.bold,
                        fontSize: 16,
                        height: 1.3,
                        fontFamily: 'SubHead'
                    ),



                  ),
                  drawerTheme: DrawerThemeData(
                      backgroundColor: Colors.white
                  )
              ),
              darkTheme: ThemeData(
                inputDecorationTheme: const InputDecorationTheme(
                    fillColor: Colors.red),
                scaffoldBackgroundColor: Color(0xff333739),
                primarySwatch: Colors.red,
                  dialogTheme: DialogTheme(
                    backgroundColor: Color(0xff333739),
                    elevation: 0.0,

                  ),
                appBarTheme: const AppBarTheme(
                    elevation: 0.0,
                    backgroundColor: Color(0xff333739),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color(0xff333739),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    actionsIconTheme: IconThemeData(
                        color: Colors.white
                    ),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'HeadFont'
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    )
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Color(0xff333739),
                  unselectedItemColor: Color(0xff333739),
                ),cardTheme: CardTheme(
                color: Color(0xff333739),elevation: 8,
                shadowColor: Colors.red,
                clipBehavior: Clip.antiAlias,
              ),
                textTheme: const TextTheme(
                  caption: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                     /// fontWeight: FontWeight.bold,
                      fontFamily: 'SubHead'
                  ),
                  bodyText2: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'SubHead'
                  ),
                  bodyText1: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'SubHead'
                  ),
                  subtitle1: TextStyle(
                      color: Colors.grey,
                     /// fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'SubHead'
                  ),
                  subtitle2: TextStyle(
                      color: Colors.grey,
                      ///fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'SubHead'
                  ),
                  headline2: TextStyle(
                      color: Colors.grey,
                      fontSize: 50,
                      fontFamily: 'SubHead'
                  ),

                  headline5: TextStyle(
                      color: Colors.grey,
                      ////fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'SubHead',
                    height: 1.2,
                  ),
                  headline3: TextStyle(
                      color: Colors.white70,///fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'SubHead'
                  ),
                  headline4: TextStyle(
                      color: Colors.grey,
                      fontSize: 40,
                     /// fontWeight: FontWeight.bold,
                      fontFamily: 'SubHead'
                  ),
                  labelMedium: TextStyle(
                      color: Colors.white,////fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.3,
                      fontFamily: 'SubHead'
                  ),

                ),
                iconTheme: const IconThemeData(
                    color: Colors.white
                ),
                drawerTheme: DrawerThemeData(
                  backgroundColor: Color(0xff333739)
                )
              ),
              themeMode: cubic.themeChange?ThemeMode.light:ThemeMode.dark
          );},
        listener: (BuildContext context, Object? state) {  },
      ),
    );
  }
}
