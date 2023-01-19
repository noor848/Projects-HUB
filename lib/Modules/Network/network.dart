
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Network extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ),
        children: [
          user1(context),
          user2(context),
          user3(context),
          user(context),
          user4(context),

        ],
    ),
      );
  }

  Widget user(context){

    return Card(
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
                  backgroundImage:NetworkImage('https://images.unsplash.com/photo-1456379771252-03388b5adf1a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=887&q=80'),),
              ),
            ),
          ],
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("Noor Braik",style: TextStyle(fontSize: 16,fontFamily: 'SubHead'),),
          ),
          ElevatedButton(
            onPressed: (){},
            style: ButtonStyle(
              backgroundColor:  MaterialStatePropertyAll<Color>(Theme.of(context).scaffoldBackgroundColor),
             /// side: MaterialStateProperty.all( BorderSide(color:Colors.grey)),
            ),
            child: Text("+ Follow",style: TextStyle(color: Colors.red),),
          )

        ],
      ),
    );

  }
  Widget user1(context){

    return Card(
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
                  backgroundImage:NetworkImage('https://images.unsplash.com/photo-1557862921-37829c790f19?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80'),),
              ),
            ),
          ],
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("Ali Ahmad",style: TextStyle(fontSize: 16,fontFamily: 'SubHead'),),
          ),
          ElevatedButton(
            onPressed: (){},
            style: ButtonStyle(
              backgroundColor:  MaterialStatePropertyAll<Color>(Theme.of(context).scaffoldBackgroundColor),
             /// side: MaterialStateProperty.all( BorderSide(color:Colors.grey)),
            ),
            child: Text("+ Follow",style: TextStyle(color: Colors.red),),
          )

        ],
      ),
    );

  }
  Widget user2(context){

    return Card(
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
                  backgroundImage:NetworkImage('https://i.picsum.photos/id/64/4326/2884.jpg?hmac=9_SzX666YRpR_fOyYStXpfSiJ_edO3ghlSRnH2w09Kg'),),
              ),
            ),
          ],
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("Sara ALi",style: TextStyle(fontSize: 16,fontFamily: 'SubHead'),),
          ),
          ElevatedButton(
            onPressed: (){},
            style: ButtonStyle(
              backgroundColor:  MaterialStatePropertyAll<Color>(Theme.of(context).scaffoldBackgroundColor),
             /// side: MaterialStateProperty.all( BorderSide(color:Colors.grey)),
            ),
            child: Text("+ Follow",style: TextStyle(color: Colors.red),),
          )

        ],
      ),
    );

  }
  Widget user3(context){

    return Card(
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
                  backgroundImage:NetworkImage('https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),),
              ),
            ),
          ],
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("Othman Othman",style: TextStyle(fontSize: 16,fontFamily: 'SubHead'),),
          ),
          ElevatedButton(
            onPressed: (){},
            style: ButtonStyle(
              backgroundColor:  MaterialStatePropertyAll<Color>(Theme.of(context).scaffoldBackgroundColor),
             /// side: MaterialStateProperty.all( BorderSide(color:Colors.grey)),
            ),
            child: Text("+ Follow",style: TextStyle(color: Colors.red),),
          )

        ],
      ),
    );

  }
  Widget user4(context){

    return Card(
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
                    backgroundImage:NetworkImage('https://images.unsplash.com/photo-1556157382-97eda2d62296?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'
                        '',),),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("Basem ALi",style: TextStyle(fontSize: 16,fontFamily: 'SubHead'),),
          ),
          ElevatedButton(
            onPressed: (){},
            style: ButtonStyle(
              backgroundColor:  MaterialStatePropertyAll<Color>(Theme.of(context).scaffoldBackgroundColor),
              /// side: MaterialStateProperty.all( BorderSide(color:Colors.grey)),
            ),
            child: Text("+ Follow",style: TextStyle(color: Colors.red),),
          )

        ],
      ),
    );

  }


}
