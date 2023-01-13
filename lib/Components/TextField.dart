import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Cubit/cubitMainScreen.dart';

Widget textField(context,{hintText,borderRadius,prefixIcon,suffix,Label,obscureText,controller,value}){
  return TextFormField(
  /*  validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    },*/
    initialValue: value,
    controller:controller,
    obscureText:obscureText?CubitMainScreen.get(context).VisibleIcon==false?true:false:false,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon,color: Colors.grey[300],),
      hintText: hintText,
      suffixIcon:suffix!=null?IconButton(
          onPressed: (){
            CubitMainScreen.get(context).ChangeEyePasswordIcon();
          },
          icon:CubitMainScreen.get(context).VisibleIcon==true?Icon(suffix):Icon(Icons.visibility_off)):null ,
      label: Label,
      hintStyle:Theme.of(context).textTheme.subtitle2,
      //TextStyle(fontFamily: 'SubHead',fontSize: 13),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),borderRadius: BorderRadius.circular(borderRadius),),
      focusedBorder:OutlineInputBorder(
        borderSide:  BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),

  );
}
Widget textFieldEdit(context,{hintText,borderRadius,prefixIcon,suffix,Label,obscureText,controller,value}){
  return TextFormField(

    initialValue: value,
    controller:controller,
    obscureText:obscureText?CubitMainScreen.get(context).VisibleIcon==false?true:false:false,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon,color: Colors.grey[300],),
      hintText: hintText,
      suffixIcon:suffix!=null?IconButton(
          onPressed: (){
            CubitMainScreen.get(context).ChangeEyePasswordIcon();
          },
          icon:CubitMainScreen.get(context).VisibleIcon==true?Icon(suffix):Icon(Icons.visibility_off)):null ,
      label: Label,
      hintStyle:Theme.of(context).textTheme.subtitle2,
      //TextStyle(fontFamily: 'SubHead',fontSize: 13),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),borderRadius: BorderRadius.circular(borderRadius),),
      focusedBorder:OutlineInputBorder(
        borderSide:  BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),

  );
}


Widget textField2(context,{hintText,borderRadius,prefixIcon,suffix,Label,obscureText,controller}){
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please Enter some text';
      }
      return null;
    },
    autovalidateMode:
    AutovalidateMode.onUserInteraction,
    controller:controller,
    obscureText:obscureText?CubitMainScreen.get(context).VisibleIcon==false?true:false:false,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon,color: Colors.grey[300],),
      hintText: hintText,
      suffixIcon:suffix!=null?IconButton(
          onPressed: (){
            CubitMainScreen.get(context).ChangeEyePasswordIcon();
          },
          icon:CubitMainScreen.get(context).VisibleIcon==true?Icon(suffix):Icon(Icons.visibility_off)):null ,
      label: Label,
      hintStyle:Theme.of(context).textTheme.subtitle2,
      //TextStyle(fontFamily: 'SubHead',fontSize: 13),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),borderRadius: BorderRadius.circular(borderRadius),),
      focusedBorder:OutlineInputBorder(
        borderSide:  BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),

  );
}
Widget textField3(context,{hintText,borderRadius,prefixIcon,suffix,Label,obscureText,controller
}){
  return TextField(
    controller:controller,
    onSubmitted: (value){
      CubitMainScreen.get(context).Validate(confirmPassword:value);
    },
    obscureText:obscureText?CubitMainScreen.get(context).VisibleIcon==false?true:false:false,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon,color: Colors.grey[300],),
      hintText: hintText,
      suffixIcon:suffix!=null?IconButton(
          onPressed: (){
            CubitMainScreen.get(context).ChangeEyePasswordIcon();
          },

          icon:CubitMainScreen.get(context).VisibleIcon==true?Icon(suffix):Icon(Icons.visibility_off)):null ,
      label: Label,
      hintStyle:Theme.of(context).textTheme.subtitle2,
      //TextStyle(fontFamily: 'SubHead',fontSize: 13),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),borderRadius: BorderRadius.circular(borderRadius),),
      focusedBorder:OutlineInputBorder(
        borderSide:  BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),

  );
}
Widget textField4(context,{hintText,borderRadius,prefixIcon,suffix,Label,obscureText,controller,Newpassword
}){
  return TextField(
    controller:controller,
    obscureText:obscureText?CubitMainScreen.get(context).VisibleIcon==false?true:false:false,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon,color: Colors.grey[300],),
      hintText: hintText,
      suffixIcon:suffix!=null?IconButton(
          onPressed: (){
            CubitMainScreen.get(context).ChangeEyePasswordIcon();
          },

          icon:CubitMainScreen.get(context).VisibleIcon==true?Icon(suffix):Icon(Icons.visibility_off)):null ,
      label: Label,
      hintStyle:Theme.of(context).textTheme.subtitle2,
      //TextStyle(fontFamily: 'SubHead',fontSize: 13),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),borderRadius: BorderRadius.circular(borderRadius),),
      focusedBorder:OutlineInputBorder(
        borderSide:  BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),

  );
}
Widget textField5(context,{hintText,borderRadius,prefixIcon,suffix,Label,obscureText,controller,Newpassword
}){
  return TextField(
    onSubmitted: (value){
      CubitMainScreen.get(context).setNewPassword(NewPassword: Newpassword);
    },
    controller:controller,
    obscureText:obscureText?CubitMainScreen.get(context).VisibleIcon==false?true:false:false,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon,color: Colors.grey[300],),
      hintText: hintText,
      suffixIcon:suffix!=null?IconButton(
          onPressed: (){
            CubitMainScreen.get(context).ChangeEyePasswordIcon();
          },

          icon:CubitMainScreen.get(context).VisibleIcon==true?Icon(suffix):Icon(Icons.visibility_off)):null ,
      label: Label,
      hintStyle:Theme.of(context).textTheme.subtitle2,
      //TextStyle(fontFamily: 'SubHead',fontSize: 13),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),borderRadius: BorderRadius.circular(borderRadius),),
      focusedBorder:OutlineInputBorder(
        borderSide:  BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),

  );
}
