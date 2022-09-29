
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Components/TextField.dart';
import 'package:graduationproject1/Components/button.dart';
import 'package:graduationproject1/Cubit/StateMainScreen.dart';
import 'package:graduationproject1/Cubit/cubitMainScreen.dart';
import 'package:graduationproject1/Modules/MainScreen/MainScreen.dart';
import 'package:graduationproject1/Modules/SignUp/signUp.dart';
import 'package:iconly/iconly.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class SignIn extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) =>Scaffold(
          appBar: AppBar(),
          body:
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign In",style:TextStyle(fontFamily: 'HeadFont',fontSize: 50),),
                    SizedBox(height: 10,),
                    Text("Would you like to contribute your own projects to Projects Hub? Share your project with us your Ideas and Questions we will work with you !",
                        style:TextStyle(fontFamily: 'SubHead',fontSize: 13,color: Colors.black),)
                   , Form(
                      key: null,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: textField(context,hintText: "Email",borderRadius:20.0,prefixIcon:Icons.email,obscureText: false),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(bottom:20),
                            child: textField(context,hintText: "Password",borderRadius:20.0,obscureText: true,prefixIcon:IconlyLight.password,suffix:Icons.visibility_sharp),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              child:Button(context,() {
                              /*  if (_formKey.currentState!=null)
                                    if(_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data')),
                                  );
                                }*/
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>MainScreen()));
                              },

                                fontWeight: FontWeight.w600,fontSize: 20.0,text: "Sign In",
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Or", style:TextStyle(fontFamily: 'SubHead',fontSize: 20,color: Colors.black),),
                          ),
                          SocialLoginButton(
                            buttonType: SocialLoginButtonType.google,
                            onPressed: () {},

                          ),

                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  SignUp()),
                            );
                          },
                              child: Text("New User ? Register Here",style:TextStyle(fontFamily: 'SubHead',fontSize: 13),)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
      listener: (BuildContext context, Object? state) {  },
    );
  }
}
