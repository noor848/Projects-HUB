import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Cubit/StateMainScreen.dart';
import 'package:graduationproject1/Cubit/cubitMainScreen.dart';
import '../../Constants.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
        builder: (BuildContext context, state)
        { CubitMainScreen cubic= CubitMainScreen.get(context);
       return Scaffold(
          appBar: AppBar(title: const Text("SearchApp"),
          actions: [IconButton(onPressed: (){
            cubic.changeThem();
          }, icon:const Icon(Icons.brightness_4,))],
            leading: IconButton(onPressed:(){

            },icon:Icon(Icons.menu)),
          ),
          body:cubic.PagesScreen[CubitMainScreen.get(context).pageIndex],
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: SecondaryColor,
            onTap:(value){
              cubic.changeScreenIndex(value);
            },
            items: const[
              Icon(Icons.home),
              Icon(Icons.now_wallpaper),
              Icon(Icons.perm_identity)],
            height: 60,
          ),
        );}
      , listener: (BuildContext context, Object? state) {  },
    );
  }
}
