import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../mainPageScreens/PostCreat.dart';
import '../mainPageScreens/ProjectCreate.dart';

class Tap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) {
        return  Scaffold(
          body: SafeArea(
            child: DefaultTabController(
              initialIndex: CubitMainScreen.get(context).indexCratePostChanged,
              length: kIsWeb?1:2,
              child: Column(
                children: <Widget>[
                  ButtonsTabBar(
                    backgroundColor: Colors.red,
                    unselectedBackgroundColor: Colors.grey[300],
                    unselectedLabelStyle: TextStyle(color: Colors.black,fontFamily: 'SubHead'),
                    labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontFamily: 'SubHead'),
                    tabs:kIsWeb?[
                      Tab(
                        icon: InkWell(
                          onTap: () =>CubitMainScreen.get(context).ChangeIndexpage0(),
                          child:
                          Row(
                            children: const[
                              Icon(Icons.style),
                              SizedBox(width: 5,),
                              Text("post",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                              SizedBox(width: 5,),
                            ],
                          ),
                        ),
                      ),
                    ]:[
                      Tab(
                        icon: InkWell(
                          onTap: () =>CubitMainScreen.get(context).ChangeIndexpage0(),
                          child:
                          Row(
                            children: const[
                              Icon(Icons.style),
                              SizedBox(width: 5,),
                              Text("post",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                              SizedBox(width: 5,),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        icon: InkWell(
                          onTap: () =>CubitMainScreen.get(context).ChangeIndexpage1(),
                          child:Row(
                            children: const[
                              Icon(Icons.star_border),
                              SizedBox(width: 5,),
                              Text("Project",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                              SizedBox(width: 5,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children:kIsWeb? [
                        Center(
                          child: PostCreate(),
                        )
                      ]: [
                        Center(
                          child: PostCreate(),
                        ),
                        Center(
                          child: ProjectCreate(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}
