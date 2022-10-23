
import 'dart:convert';

import 'package:dio/dio.dart';

class DioHelpr{

 /*static init (){
  dio = Dio(
   BaseOptions(
    baseUrl: "https://localhost:8000",
    receiveDataWhenStatusError: true,
    headers: {
     "Content-Type":"application/json"
    }
   )
  );

 }*/

 /*static Future<Response>  getData({ required String Url,qurey})async{

  return await dio.get(
    Url,queryParameters: qurey
  );
 }
*/

 static Future<Response>  PostData({ required String Url,qurey,data,token})async{

  var dio = Dio(
       BaseOptions(
           baseUrl: "http://192.168.1.10:8001",
           receiveDataWhenStatusError: true,
          /* headers: {
             "Content-Type":"application/json"
           }*/
       )
   );
   /*dio?.options=BaseOptions(
   headers: {
    'Authorization':token
   }
  );*/
  return await dio.post(
    Url,queryParameters: qurey,data:data
  );
 }
 }