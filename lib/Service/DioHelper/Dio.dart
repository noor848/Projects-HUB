import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../Model/UserProfileModel.dart';

class DioHelper {
  static Future<String> LogIn({api, data, email, password, Token}) async {
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/login");
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
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/signup");
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

  static Future<http.Response> GetUserProfile({path,data,idToken})async{
  var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/$idToken");
  var response = await http.Client().get(url ,headers: {
    'Content-Type': 'application/json;charset=UTF-8',
    //'Charset': 'utf-8'
  });
  print(await json.decode(json.encode(response.body)));
  return response;
  }
  static Future<http.Response> PutUserImage({imagepath,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/ProfilePicture/$idToken");
    var response = await http.Client().put(url,
        body: json.encode({
          "encodedProfilePicture":imagepath.toString()
        })
        ,headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
    });
    print(await json.decode(json.encode(response.body)));
    return response;
  }
  static Future<http.Response> PutUserBio({bio,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Bio/$idToken");
    var response = await http.Client().put(url,
        body: json.encode({
          "bio":bio.toString()
        })
        ,headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    print(await json.decode(json.encode(response.body)));
    return response;
  }
  static Future<http.Response> PutUserName({FirstName,lastName,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/username/$idToken");
    var response = await http.Client().put(url,
        body: json.encode({
          "FirstName":FirstName,
          "LastName":lastName
        })
        ,headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }
  static Future<http.Response> PutUserPassword({oldPassword,NewPassword,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Password/$idToken");
    var response = await http.Client().put(url,
        body: json.encode({
          "OldPassword":oldPassword,
          "NewPassword":NewPassword
        })
        ,headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    return response;
  }
  static Future<http.Response> GetUserContacts({path,data,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Contacts/$idToken");
    var response = await http.Client().get(url ,headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      //'Charset': 'utf-8'
    });
    return response;
  }

}