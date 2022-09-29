import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject1/Components/TextField.dart';
import 'package:graduationproject1/Components/button.dart';

class PostCreate extends StatelessWidget {
  const PostCreate({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              Column(
                children: [
                  Card(
                    shadowColor:Colors.black,
                    borderOnForeground : true,
                    elevation: 10,
                    child:
                    ExpansionTile(
                      title: Text("Title"),
                      subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),)
                      // trailing: Icon(Icons.arrow_forward_ios),
                      ,leading: Icon(Icons.add_circle),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                          child: TextFormField(
                              decoration:new InputDecoration.collapsed(
                                hintText: 'Title .......',
                                /*prefixIcon: Icon(Icons.edit,color: Colors.grey[300],),
                        hintText: "Title....",*/
                                hintStyle: Theme.of(context).textTheme.bodyText1,
                              )             ),

                        ),

                      ],
                    ),
                  ),
                  Card(
                    shadowColor:Colors.black,
                    borderOnForeground : true,
                    elevation: 10,
                    child:
                    ExpansionTile(

                      title: Text("Description"),
                      subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),)
                      // trailing: Icon(Icons.arrow_forward_ios),
                      ,leading: Icon(Icons.add_circle),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                          child: TextFormField(
                              decoration:new InputDecoration.collapsed(
                                hintText: 'Description .......',
                                /*prefixIcon: Icon(Icons.edit,color: Colors.grey[300],),
                        hintText: "Title....",*/
                                hintStyle: Theme.of(context).textTheme.bodyText1,
                              )),

                        ),
                        Card(
                          shadowColor:Colors.black,
                          borderOnForeground : true,
                          elevation: 10,
                          margin: EdgeInsets.all(8),
                          shape:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey, width: 1)
                          ),
                          child:
                          ExpansionTile(
                            title: Text("Header1"),
                            subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),)
                            // trailing: Icon(Icons.arrow_forward_ios),
                            ,leading: Icon(Icons.add_sharp),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                                child: TextFormField(
                                    decoration:new InputDecoration.collapsed(
                                      hintText: 'Title .......',
                                      /*prefixIcon: Icon(Icons.edit,color: Colors.grey[300],),
                        hintText: "Title....",*/
                                      hintStyle: Theme.of(context).textTheme.bodyText1,
                                    )             ),

                              ),

                            ],
                          ),
                        ),
                        Card(
                          shadowColor:Colors.black,
                          borderOnForeground : true,
                          elevation: 10,
                          margin: EdgeInsets.all(8),
                          shape:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey, width: 1)
                          ),
                          child:
                          ExpansionTile(
                            title: Text("Header1"),
                            subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),)
                            // trailing: Icon(Icons.arrow_forward_ios),
                            ,leading: Icon(Icons.add_sharp),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                                child: TextFormField(
                                    decoration:new InputDecoration.collapsed(
                                      hintText: 'Title .......',
                                      /*prefixIcon: Icon(Icons.edit,color: Colors.grey[300],),
                        hintText: "Title....",*/
                                      hintStyle: Theme.of(context).textTheme.bodyText1,
                                    )             ),

                              ),

                            ],
                          ),
                        )



                      ],
                    ),
                  ),
                  Card(
                    shadowColor:Colors.black,
                    borderOnForeground : true,
                    elevation: 10,
                    child:
                    ExpansionTile(
                      title: Text("Image"),
                      subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),)
                      // trailing: Icon(Icons.arrow_forward_ios),
                      ,leading: Icon(Icons.add_circle),
                      children: [
                        ListTile(
                        onTap: (){},
                          leading: Icon(Icons.image),
                          title: Text("Image 1"),
                          subtitle:Text("Choose main Image  for your project!",style: TextStyle(color: Colors.grey),) ,
                        ),
                      Divider(height: 1,color: Colors.grey,),
                        ListTile(

                          onTap: (){},
                          leading: Icon(Icons.image_search),
                          title: Text("Image 2"),
                          subtitle:Text("Choose Multi  Image  for your project!",style: TextStyle(color: Colors.grey),) ,
                        ),
                      ],
                    ),
                  )
                ],
              ),


            ],

          ),
        ),
      ),
    );
  }
}


Widget xx(){
  return   ListTile(

    leading: Icon(Icons.add),
    trailing: Icon(Icons.arrow_forward_ios),
    title: Text("Title"),
    subtitle: Text("I dont know what it does ",style: TextStyle(color: Colors.grey),),
  );
}

/*InputDecoration(
prefixIcon: Icon(Icons.edit,color: Colors.grey[300],),
hintText: "Title....",
hintStyle: Theme.of(context).textTheme.bodyText1,
enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, ),))

*/
//


/*
*  Row(
            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100)
                ),
                child: const Image(image: NetworkImage("https://img.freepik.com/free-photo/woman-with-balloon-image-torn-paper-style_53876-128762.jpg?size=626&ext=jpg"),
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14,),
              Text("Noor Braik",style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style:  Theme.of(context).textTheme.subtitle2,
                decoration:  InputDecoration(
                  hintText: "What is in Your Mind ......",
                  hintStyle: Theme.of(context).textTheme.subtitle2,
                  border: InputBorder.none,

                ),

              ),
            ),
          ),*/