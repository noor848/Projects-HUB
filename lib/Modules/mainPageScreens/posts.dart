import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';

import '../../Components/getPosts.dart';

class Posts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 50,
            child: TextField(
              onChanged: (value){
                print(value);
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
           child: ListView.builder(
             physics: AlwaysScrollableScrollPhysics(),
               itemBuilder: (context, index)=>getPosts(context),
         ))
      ],
    );

  }

}
