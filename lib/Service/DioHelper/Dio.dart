import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DioHelper {
  static Future<String> LogIn({api, data, email, password, Token}) async {
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/usres/login");
    var response = await http.Client().post(url, body:
    json.encode(
        {
          "password": password,
          "email": email
        }
    ), headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      //'Charset': 'utf-8'
      ///'Authorization':Token
    });
   /// print(await json.decode(json.encode(response.body)));
    return response.body;
  }

  static Future<String> SignUp({FirstName,LastName,email, password,image,Token}) async {
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/usres/signup");
    var response = await http.Client().post(url, body:
    json.encode(
        {
          "firstName": FirstName,
          "lastName": LastName,
          "email": email,
          "password": password,
          "profilePicture": image
        }
    ), headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      //'Charset': 'utf-8'
      ///'Authorization':Token
    });
   /// print(await json.decode(json.encode(response.body)));
    return response.body;
  }

/*static Future<Response> postData({path,data,query})async{
    var dio= await Dio(
    BaseOptions(
    baseUrl: "http://192.168.1.10:8001",
    receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      }
    )
    );
    return await dio.post(path,data:data,queryParameters:query );

  }
*/

}