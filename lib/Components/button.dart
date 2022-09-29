
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Button(context,onpress,{text,fontSize,fontWeight}){

 return  ElevatedButton(
   onPressed: onpress, child: Text(text),
    style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight:fontWeight,
          fontFamily:'SubHead',
        ),
        elevation:8,
    ),);
}