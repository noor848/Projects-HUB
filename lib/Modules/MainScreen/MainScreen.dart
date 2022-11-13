import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../../Components/google_signIn.dart';
import '../../Constants.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../SignInScreen/signIn.dart';
import '../editProfile/editProfile.dart';
import '../mainPageScreens/profile.dart';

class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
        builder: (BuildContext context, state)
        { CubitMainScreen cubic= CubitMainScreen.get(context);
       return Scaffold(
         key: _key,
          appBar: AppBar(title: const Text("Projects Hub"),
          actions: [
         /*   PopupMenuButton(
              icon: IconButton(
                onPressed: (){
                  if(_key.currentState!.isDrawerOpen){
                    _key.currentState!.closeDrawer();
                    //close drawer, if drawer is open
                  }else{
                    _key.currentState!.openDrawer();
                    //open drawer, if drawer is closed
                  }


                },
                  icon:
                  Icon(IconlyBold.setting)),
              elevation: 5,
              color: Colors.grey.shade100,
              position: PopupMenuPosition.under,
              itemBuilder: (_) => <PopupMenuItem<String>>[
                PopupMenuItem(
                    onTap: ()async {
                      await GoogleSignInOutApi.logOut(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child:Text("Logout",style: TextStyle(
                          fontFamily: 'SubHead',fontSize: 18,color: Colors.red
                      ),),
                     ),
              ],
              onSelected: (_) {
                Navigator.pop(context);
              },),*/
            IconButton(onPressed: (){
            cubic.changeThem();
          }, icon:const Icon(Icons.brightness_4_outlined,))],
            leading: IconButton(onPressed:(){

            },icon:Icon(Icons.menu)),
          ),
          body:cubic.PagesScreen[CubitMainScreen.get(context).pageIndex],
          bottomNavigationBar: CurvedNavigationBar(
            index: CubitMainScreen.get(context).pageIndex,
            backgroundColor: Colors.transparent,
            color: SecondaryColor,

            onTap:(value){
              cubic.changeScreenIndex(value);
            },
            items: const[
              Icon(IconlyLight.home),
              Icon(IconlyLight.plus),
              Icon(IconlyLight.chat),],
            height: 60,
          ),


        drawer: Drawer(
          width: 250,
        child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
         DrawerHeader(
          decoration: BoxDecoration(
          color: Colors.red[500],
            borderRadius: BorderRadius.circular(30)
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                      radius: 50,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadiusDirectional.circular(100),
                        ),
                        child:CubitMainScreen.get(context).userProfileValues.profilePicture.toString().isEmpty?Image.asset('assets/images/profileImage.jpg',
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,): Image.memory(base64Decode(CubitMainScreen.get(context).userProfileValues.profilePicture.toString()!),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${CubitMainScreen.get(context).userProfileValues.FirstName} ${CubitMainScreen.get(context).userProfileValues.LastName}", style:Theme.of(context).textTheme.subtitle1,),
              ),
            ],
          ),
          ),
          ListTile(
          leading:  Icon(IconlyLight.profile,size:25,),
          title: const Text('View Profile'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          },
          ),
          ListTile(
            leading:  Icon(IconlyLight.edit,size:25,),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ProfileEdit()),
              );
            },
          ),
          ListTile(
            leading:  Icon(IconlyLight.logout,size:25,),
            title: const Text('Log Out'),
            onTap: () async {
    await GoogleSignInOutApi.logOut(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignIn()));}
          ),

        ],
        ),
          ),
        );}
      , listener: (BuildContext context, Object? state) {  },
    );
  }
}
