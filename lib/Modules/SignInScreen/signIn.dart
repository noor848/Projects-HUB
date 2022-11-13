
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../Components/TextField.dart';
import '../../Components/button.dart';
import '../../Components/google_signIn.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import '../MainScreen/MainScreen.dart';
import '../SignUp/signUp.dart';

class SignIn extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      listener: (BuildContext context, Object? state) {

        if(state is LoginSuccess){
          Fluttertoast.showToast(
            msg: "Log In Success !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  MainScreen()),
          );}
        else{
          if(state is LoginFailed) {
            Fluttertoast.showToast(
              msg: "Log In Failed !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        }
      },
      builder: (BuildContext context, state) =>Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body:
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sign In",style:TextStyle(fontFamily: 'HeadFont',fontSize: 50),),
                      SizedBox(height: 10,),
                      Text("Would you like to contribute your own projects to Projects Hub? Share your project with us your Ideas and Questions we will work with you !",
                          style:Theme.of(context).textTheme.headline5,)
                     , Form(
                        key: null,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child:

                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter some text';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                controller:email,
                                obscureText:false,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email,color: Colors.grey[300],),
                                  hintText: "Email",
                                  hintStyle:Theme.of(context).textTheme.subtitle2,
                                  //TextStyle(fontFamily: 'SubHead',fontSize: 13),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),borderRadius: BorderRadius.circular(20.0),),
                                  focusedBorder:OutlineInputBorder(
                                    borderSide:  BorderSide(color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),

                              )
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(bottom:20),
                              child: textField2(context,hintText: "Password",borderRadius:20.0,obscureText: true,prefixIcon:IconlyLight.password,suffix:Icons.visibility_sharp,controller: password),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                child:Button(context,() {
                        if (_formKey.currentState!.validate()) {
                          CubitMainScreen.get(context).Login(
                              password:password.text.trim(),
                              email: email.text.trim()
                          );
                        }
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
                              child: Text("Or", style:Theme.of(context).textTheme.headline5,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SocialLoginButton(
                                height: 50,
                                buttonType: SocialLoginButtonType.google,
                                onPressed: () {
                                  GoogleSignInOutApi.login(context);
                                },

                              ),
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
            ),
          )
      ),

    );
  }
}
