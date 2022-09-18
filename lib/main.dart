import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/shared/bloc_observer.dart';
import 'package:graduationproject1/shared/shared_prefrences.dart';
import 'Cubit/StateMainScreen.dart';
import 'Modules/MainScreen/MainScreen.dart';
import 'Cubit/cubitMainScreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            home: MainScreen(),
            theme: ThemeData(
              primarySwatch: Colors.green,
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
                      fontSize: 20,fontWeight: FontWeight.bold
                  ),
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent
              ),
              textTheme: const TextTheme(
                caption: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                ),
                bodyText2: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
                bodyText1: TextStyle(
                  color: Colors.grey,
                ),

              )
            ),
            darkTheme: ThemeData(
                inputDecorationTheme: const InputDecorationTheme(
                    fillColor: Colors.red),
              scaffoldBackgroundColor: Color(0xff333739),
              primarySwatch: Colors.green,
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
                      fontSize: 20,fontWeight: FontWeight.bold
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  )
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xff333739),
                unselectedItemColor: Color(0xff333739),
              ),
              textTheme: const TextTheme(
                caption: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                ),
                bodyText2: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
                bodyText1: TextStyle(
                  color: Colors.grey,
                ),

              ),
              iconTheme: const IconThemeData(
                  color: Colors.white
              ),
            ),
            themeMode: cubic.themeChange?ThemeMode.light:ThemeMode.dark
          );},
        listener: (BuildContext context, Object? state) {  },
      ),
    );
  }
}

