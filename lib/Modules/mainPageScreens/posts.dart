import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                  prefixIcon: Icon(Icons.search,color: Colors.grey[300],),
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
           child: ListView.separated(
             physics: AlwaysScrollableScrollPhysics(),
               itemBuilder: (context, index)=>getPosts(context),
               separatorBuilder:(context, index)=>Padding(
                 padding: const EdgeInsets.only(left:20,right:20),
                 child: SizedBox(height:1,child: Container(color: Colors.grey[300],)),
               ), itemCount: 10),
         )
      ],
    );

  }
  Widget getPosts(context){
      return InkWell(
        
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                          child: const Image(image: NetworkImage("https://img.freepik.com/free-photo/woman-with-balloon-image-torn-paper-style_53876-128762.jpg?size=626&ext=jpg"),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10,),
                         Text("Noor Braik",style: Theme.of(context).textTheme.caption),
                        const SizedBox(width: 10,),
                        const Text("OCT.30.2018",style: TextStyle(fontSize: 10,color: Colors.grey),)
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
                          SizedBox(width: 8,),
                          Image(image: NetworkImage("https://assets.entrepreneur.com/content/3x2/2000/1391122457-10-most-have-ingredients-successful-invention.jpg"),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:10 ),
                            child: IconButton(constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(Icons.chat,)),
                          ),
                          const Text("205"),
                          const SizedBox(width: 20,),
                          Padding(
                            padding: const EdgeInsets.only(right:10 ),
                            child: IconButton(constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,onPressed: (){}, icon:Icon(Icons.recommend,)),
                          ),
                          const Text("300")
                        ],
                      ),
                    )
                  ],
                ),
              )

          ),
        ),
      );
  }
}
