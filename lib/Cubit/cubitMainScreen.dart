import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Modules/mainPageScreens/homeScreen.dart';
import 'package:graduationproject1/Modules/mainPageScreens/posts.dart';
import 'package:graduationproject1/Modules/mainPageScreens/profile.dart';
import 'package:graduationproject1/shared/shared_prefrences.dart';

import 'StateMainScreen.dart';

class CubitMainScreen extends Cubit<MainScreenState>{
  CubitMainScreen() : super(MainScreenIntialState());
  static CubitMainScreen get(context)=>BlocProvider.of(context);

  List<Widget>PagesScreen=[HomeScreen(),Posts(),Profile()];
  int pageIndex=0;
  bool themeChange=false;
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
}