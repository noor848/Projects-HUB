import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Modules/mainPageScreens/viewPost.dart';
import 'package:iconly/iconly.dart';
import '../../Components/getPosts.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../viewPostScreen/viewpostscreen.dart';
import 'ProjectCreate.dart';
import 'ProjectView.dart';

class Posts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(builder: (BuildContext context, state) {
      return
        DefaultTabController(
          length:kIsWeb?1:2,
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                  TabBar(
                    tabs:kIsWeb?[
                    Tab(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(IconlyBold.paper,color: Colors.red,),
                        SizedBox(width: 5,),
                        Text("Post",style: Theme.of(context).textTheme.subtitle2,)
                      ],
                    )),
                    ]: [
                      Tab(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(IconlyBold.paper,color: Colors.red,),
                          SizedBox(width: 5,),
                          Text("Post",style: Theme.of(context).textTheme.subtitle2,)
                        ],
                      )),
                      Tab(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.panorama_photosphere,color: Colors.yellow,),
                          SizedBox(width: 5,),
                          Text("Project",style: Theme.of(context).textTheme.subtitle2)
                        ],
                      )),
                    ],
                  ),
                ],
              ),
              automaticallyImplyLeading: false,

            ),
       body :
       TabBarView(
         children:kIsWeb? [
           Postview(),
         ]: [
           Postview(),
           Projectview()
         ],
       )



          ),
        );
    }, listener: (BuildContext context, Object? state) {  },

    );

  }


  Widget getPosts(context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: (){
            CubitMainScreen.get(context).getViewPost();
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewPostScreen(CubitMainScreen.get(context).viewDataPost)));
          },
          splashColor: Colors.red,
          child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child:  Image(image:NetworkImage("https://images.unsplash.com/photo-1664207251296-569bacae6f04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text("Noor Braik",style: Theme.of(context).textTheme.caption,),
                        const SizedBox(width: 10,),
                        const Text("OCT.30.2018",style: TextStyle(fontSize: 10,color: Colors.grey),),
                        Spacer(),
                        TextButton(onPressed: (){}, child: Text("+ Follow"))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child:
                            Text("The action of inventing something, typically a process or device"+
                                "the invention of printing in the 15th century",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style:Theme.of(context).textTheme.bodyText2,
                            ),),
                          SizedBox(width:5,),
                          Image(image: NetworkImage("https://assets.entrepreneur.com/content/3x2/2000/1391122457-10-most-have-ingredients-successful-invention.jpg"),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:10 ),
                            child: IconButton(constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(
                                    IconlyLight.heart,color: Colors.pinkAccent)),
                          ),
                          const Text("205"),
                          const SizedBox(width: 20,),
                          Padding(
                            padding: const EdgeInsets.only(right:10 ),
                            child: IconButton(constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(
                                    IconlyLight.chat,color: Colors.blueGrey)),
                          ),
                          const Text("205"),
                          const SizedBox(width: 20,),

                         /* Padding(
                            padding: const EdgeInsets.only(right:10 ),
                            child: IconButton(constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(IconlyLight.star,color: Colors.yellow,)),
                          ),
                          const Text("300")*/
                        ],
                      ),
                    )
                  ],
                ),
              )

          ),
        ),
      ),
    );
  }


}
