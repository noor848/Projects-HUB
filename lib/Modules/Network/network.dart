
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../../Model/Network.dart';
import '../../Service/DioHelper/Dio.dart';
import '../shortProfile/shortProfile.dart';

class Network extends StatelessWidget {
var scroll=ScrollController();
  @override
  Widget build(BuildContext context) {
    ///setupScrollController(context);
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) {
      return Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 50,
                  child: TextField(
                    onSubmitted: (value){
                      CubitMainScreen.get(context).getPaginatedNetworkwithQuery(pageNumber: 0,query: value);
                    },
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      prefixIcon: Icon(IconlyLight.search,color: Colors.grey[300],),
                      hintText: "Search",
                      hintStyle: Theme.of(context).textTheme.bodyText1,
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, ),borderRadius: BorderRadius.circular(100.0),),
                      focusedBorder:OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  )
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CubitMainScreen.get(context).NetworkData.isEmpty?Center(child: CircularProgressIndicator()):GridView.builder(
                controller: scroll,
                  itemCount : CubitMainScreen.get(context).NetworkData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
                  itemBuilder: (context, index) {
                      return user(context,CubitMainScreen.get(context).NetworkData[index]);
                  }),
            ),
          ),
        ],
      );
    },
      listener: (BuildContext context, Object? state) {  },

    );
  }

}

Widget user(context,NetworkData) {
  return InkWell(
    onTap: (){
      CubitMainScreen.get(context).getContactProfile(RcvId:NetworkData.id);
      CubitMainScreen.get(context).checktheIamfollowing(UserId:NetworkData.id);
      ///  CubitMainScreen.get(context).getProfile(UserId: null);
      CubitMainScreen.get(context).getShortProfileUserPostandProjects(userId: NetworkData.id);
      CubitMainScreen.get(context).getUserAllProjectInProfileFront(userId: NetworkData.id);
      CubitMainScreen.get(context).getPaginatedNetwork(pageNumber: 0);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ContactProfile()),
      );
    },
    child: Card(
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.red[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: MemoryImage(
                        base64Decode(NetworkData.profilePic)
                    ),),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("${NetworkData.firstName} ${NetworkData.lastName}",
              style: TextStyle(fontSize: 16, fontFamily: 'SubHead'),),
          ),
          ElevatedButton(
            onPressed: () {

              CubitMainScreen.get(context).FollowUser(UserId: NetworkData.id);
              CubitMainScreen.get(context).getPaginatedNetwork(pageNumber: 0);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Theme
                  .of(context)
                  .scaffoldBackgroundColor),

              /// side: MaterialStateProperty.all( BorderSide(color:Colors.grey)),
            ),
            child: Text("+ Follow", style: TextStyle(color: Colors.red),),
          )

        ],
      ),
    ),
  );
}
