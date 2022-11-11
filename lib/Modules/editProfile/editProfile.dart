import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import '../../Components/TextField.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';

class ProfileEdit extends StatelessWidget {
  final Firstname = TextEditingController();
  final Lastname = TextEditingController();
  final bio = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state){
        Firstname.text= CubitMainScreen.get(context).userProfileValues.FirstName!;
        Lastname.text= CubitMainScreen.get(context).userProfileValues.LastName!;
        bio.text=CubitMainScreen.get(context).userProfileValues.bio??"This is Me...";
        return  Scaffold(
          appBar: AppBar(
            actions: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed: (){
                CubitMainScreen.get(context).UpdateBio(bio: bio.text);
                CubitMainScreen.get(context).UpdateUseName(FirstName: Firstname.text,LastName:Lastname.text);
              }, child: Text("Submit",style: TextStyle(
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
                    textField(context,hintText:"First Name",obscureText: false,prefixIcon:IconlyLight.user,borderRadius: 10.0,
                        controller: Firstname
                    ),
                    SizedBox(height: 10,),
                    textField(context,hintText:"Last Name",obscureText: false,prefixIcon:IconlyLight.profile,borderRadius: 10.0,
                        controller: Lastname
                    ),
                    SizedBox(height: 15,),
                    textField(context,hintText:"Bio",obscureText: false,prefixIcon:IconlyLight.edit,borderRadius: 10.0 ,
                      controller: bio,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if(state is GetUserProfile){
          Fluttertoast.showToast(
            msg: "Update Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );

        }

      },

    );
  }
}
