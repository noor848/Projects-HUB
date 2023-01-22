import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


Color MainColor=Color(0xFF37a85f);
Color backgoroundColor=Color(0xFFFAFAFA);
Color SecondaryColor=HexColor('FFEE3E38');
Color HoverColor=Color(0xFF77d498);
List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];

String UserToken="";
String  baseUrl ="http://192.168.1.10:8001";