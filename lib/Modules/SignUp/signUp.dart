
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Components/TextField.dart';
import 'package:graduationproject1/Components/button.dart';
import 'package:graduationproject1/Cubit/StateMainScreen.dart';
import 'package:graduationproject1/Cubit/cubitMainScreen.dart';
import 'package:iconly/iconly.dart';

class SignUp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) =>Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sign Up",style:TextStyle(fontFamily: 'HeadFont',fontSize: 50),),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Here We Go !",style:TextStyle(fontFamily: 'SubHead',fontSize: 18,color: Colors.red),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: textField(context,obscureText:false,hintText:"Name",borderRadius:20.0,prefixIcon:IconlyLight.add_user),
                  ),
                  Padding(
                    padding:const EdgeInsets.symmetric(vertical: 10),
                    child: textField(context,obscureText:false,hintText:"Email",borderRadius:20.0,prefixIcon:Icons.email_outlined),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: textField(context,obscureText:false,hintText:"Identity Number",borderRadius:20.0,prefixIcon:Icons.perm_identity),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: textField(context,obscureText:true,hintText:"Password",borderRadius:20.0,prefixIcon:IconlyLight.password,suffix:Icons.visibility),
                  ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                 child:Button(context, (){},text:"Sign Up",fontSize: 20.0,fontWeight: FontWeight.w600)
                ),
              )
                ],
              ),
            ),
          ),
        ),


      ),

    );
  }
}
