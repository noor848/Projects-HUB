import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../Modules/viewPostScreen/viewpostscreen.dart';


Widget getUserPosts(context){
  return InkWell(
    onTap: (){
    ///  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewPostScreen()));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image(image: NetworkImage("https://assets.entrepreneur.com/content/3x2/2000/1391122457-10-most-have-ingredients-successful-invention.jpg"),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 5,),
          Text("The action of inventing something, typically a process or device"+
              "the invention of printing in the 15th century",
            overflow: TextOverflow.ellipsis,
            maxLines:2,
            style:Theme.of(context).textTheme.bodyText2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:5 ),
                  child: IconButton(constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,onPressed: (){},icon:Icon(IconlyLight.chat,color: Colors.blueGrey,size: 20,)),
                ),
                const Text("205",style: TextStyle(fontSize: 12),),
                const SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.only(right:5 ),
                  child: IconButton(constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(IconlyLight.star,color: Colors.yellowAccent)),
                ),
                const Text("300",style: TextStyle(fontSize: 12),)
              ],
            ),
          )

        ],
      ),
    ),
  );
}


Widget getUserQuestions(context){
  return InkWell(
    onTap: (){
     /// Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewPostScreen()));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("The action of inventing something, typically a process or device"+
              "the invention of printing in the 15th century",
            overflow: TextOverflow.ellipsis,
            maxLines:2,
            style:Theme.of(context).textTheme.bodyText2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:5 ),
                  child: IconButton(constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(IconlyLight.chat,color: Colors.blueGrey,size: 20,)),
                ),
                const Text("205",style: TextStyle(fontSize: 12),),
                const SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.only(right:5 ),
                  child: IconButton(constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(IconlyLight.star,color: Colors.yellow)),
                ),
                const Text("300",style: TextStyle(fontSize: 12),)
              ],
            ),
          )

        ],
      ),
    ),
  );
}