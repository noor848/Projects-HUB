import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../Components/TextField.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(onPressed: (){}, child: Text("Submit",style: TextStyle(
            fontSize: 18,fontFamily: 'SubHead'
          ),)),
        )],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Edit Profile",style: TextStyle(
              fontSize: 40,
                    fontFamily: 'HeadFont'
            ),),
                ),
                SizedBox(height: 10,),
                textField(context,hintText:"Name",obscureText: false,prefixIcon:IconlyLight.edit_square,borderRadius: 10.0,
                ),
                SizedBox(height: 15,),
                textField(context,hintText:"Bio",obscureText: false,prefixIcon:IconlyLight.edit,borderRadius: 10.0 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
