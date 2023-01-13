import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import '../../Components/TextField.dart';
import '../../Components/button.dart';
import '../../Cubit/StateMainScreen.dart';
import '../../Cubit/cubitMainScreen.dart';

class ProfileEdit extends StatelessWidget {
  final Firstname = TextEditingController();
  final Lastname = TextEditingController();
  final bio = TextEditingController();
  final OldPassword = TextEditingController();
  final NewPassword = TextEditingController();
  final ConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state){
        Firstname.text= CubitMainScreen.get(context).userProfileValues.FirstName!;
        Lastname.text= CubitMainScreen.get(context).userProfileValues.LastName!;
        bio.text=CubitMainScreen.get(context).userProfileValues.bio??"This is Me...";
        return Scaffold(
          appBar: AppBar(
            actions: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed: (){
              CubitMainScreen.get(context).UpdateBio(bio: bio.text);
                CubitMainScreen.get(context).getProfile(UserId: null);
              }, child: Text("Submit",style: TextStyle(
                  fontSize: 18,fontFamily: 'SubHead'
              ),)),
            )],
          ),
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Text("Edit Profile",style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'HeadFont'
                      ),),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: SizedBox(height: 1,child: Container(
                            color: Colors.grey,
                          ),),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("User Information",textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 20,fontFamily: 'SubHead',fontWeight: FontWeight.bold,color: Colors.red,
                            ))
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: SizedBox(height: 1,child: Container(
                            color: Colors.grey,
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    textFieldEdit(context,hintText:"First Name",obscureText: false,prefixIcon:IconlyLight.user,borderRadius: 10.0,
                        controller: Firstname,
                    ),
                    SizedBox(height: 10,),
                    textFieldEdit(context,hintText:"Last Name",obscureText: false,prefixIcon:Icons.supervised_user_circle,borderRadius: 10.0,
                        controller: Lastname
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child:Button(context,() {

                          CubitMainScreen.get(context).UpdateUseName(FirstName: Firstname.text,LastName:Lastname.text);
                          CubitMainScreen.get(context).getProfile(UserId: null);
                         /// CubitMainScreen.get(context).UpdatePassword(NewPassword: NewPassword.text,OldPassword: OldPassword.text);
                        },
                          fontWeight: FontWeight.w600,fontSize: 20.0,text: "Update Name",
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    textFieldEdit(context,hintText:"Bio",obscureText: false,prefixIcon:IconlyLight.edit,borderRadius: 10.0 ,
                      controller: bio,
                    ),
                    SizedBox(height: 20,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: SizedBox(height: 1,child: Container(
                            color: Colors.grey,
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Password",textAlign: TextAlign.center,style: TextStyle(
                              fontSize: 20,fontFamily: 'SubHead',fontWeight: FontWeight.bold,color: Colors.red,
                          ))
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: SizedBox(height: 1,child: Container(
                            color: Colors.grey,
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          textField4(context,hintText: "Password",borderRadius:10.0,obscureText: true,prefixIcon:IconlyLight.password,suffix:Icons.visibility_sharp,controller: OldPassword),
                          SizedBox(height: 15,),
                          textField5(context,hintText: "New Password",borderRadius:10.0,obscureText: true,prefixIcon:Icons.password_rounded,suffix:Icons.visibility_sharp,controller: NewPassword),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              child:Button(context,() {
                                CubitMainScreen.get(context).UpdatePassword(NewPassword: NewPassword.text,OldPassword: OldPassword.text);
                              },
                                fontWeight: FontWeight.w600,fontSize: 20.0,text: "Change Password",
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                          ),

                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
       if(state is updatepassword){
          Fluttertoast.showToast(
            msg: "Updated Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );
        }
        if(state is BadRequestPassword){
          Fluttertoast.showToast(
            msg: "Password Mismatch !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            fontSize: 16,
          );
        }
        if(state is UpdateBioText || state is UpdateUserFirasLstName){
          Fluttertoast.showToast(
            msg: "Update Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );
          CubitMainScreen.get(context).getProfile(UserId: null);
        }
        /*if(state is UpdateUserFirasLstName){
          Fluttertoast.showToast(
            msg: "Update Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );
          CubitMainScreen.get(context).getProfile(UserId: null);
        }*/
      },
    );
  }
}
