import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import '../../Components/TextField.dart';
import '../../Components/button.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';
import 'ImageChoose.dart';

class SignUp extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();
  final FirstName = TextEditingController();
  final LastName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(

      listener: (BuildContext context, state) {
       if(state is SignedUpSuccess){
         Fluttertoast.showToast(
           msg: "Signed Up Successfully !",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 2,
           backgroundColor: Colors.green,
           textColor: Colors.white,
           fontSize: 16,
         );

        }
      else if(state is SignedUpFailed){
         Fluttertoast.showToast(
           msg: "Signed Up Failed !",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           timeInSecForIosWeb: 2,
           backgroundColor: Colors.redAccent,
           textColor: Colors.white,
           fontSize: 16,
         );
       }
      },
      builder: (BuildContext context, Object? state)
      {

        return Scaffold(
                appBar: AppBar(
                  actions: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ImagePicker()),
                        );


        }, child: Text("Next",style: TextStyle(
            fontSize: 18,fontFamily: 'SubHead'
        ),)),
                    )
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sign Up",
                              style:
                                  TextStyle(fontFamily: 'HeadFont', fontSize: 50),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Here We Go !",
                                style: TextStyle(
                                    fontFamily: 'SubHead',
                                    fontSize: 18,
                                    color: Colors.red),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: textField(context,
                                  obscureText: false,
                                  hintText: "First Name",
                                  borderRadius: 20.0,
                                  prefixIcon: IconlyLight.add_user,
                                  controller: FirstName),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: textField(context,
                                  obscureText: false,
                                  hintText: "Last Name",
                                  borderRadius: 20.0,
                                  prefixIcon: IconlyLight.user,
                                  controller: LastName),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: textField(context,
                                  obscureText: false,
                                  hintText: "Email",
                                  borderRadius: 20.0,
                                  prefixIcon: Icons.email_outlined,
                                  controller: email),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: textField(context,
                                  obscureText: true,
                                  hintText: "Password",
                                  borderRadius: 20.0,
                                  prefixIcon: IconlyLight.password,
                                  suffix: Icons.visibility,
                                  controller: password),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: Button(context, () {

                                  if (_formKey.currentState!.validate()) {

                                    CubitMainScreen.get(context).SignUp(
                                        LastName: LastName.text,
                                        FirstName: FirstName.text,
                                        email: email.text,
                                        password: password.text);}},
                                      text: "Sign Up",
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
  }
}
