import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../Constants.dart';
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
  var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/profile/${idToken==null?"":idToken}");
  var response = await http.Client().get(url ,headers: {
    'Content-Type': 'application/json;charset=UTF-8',
    'Authorization':'Bearer $UserToken',
    //'Charset': 'utf-8'
  });
  //print(await json.decode(json.encode(response.body))+"Hi");
  return response;
  }
  static Future<http.Response> PutUserImage({imagepath,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/ProfilePicture");
    var response = await http.Client().put(url,
        body: json.encode({
          "encodedProfilePicture":imagepath.toString()
        })
        ,headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization':'Bearer $UserToken',
        });
   /// print(await json.decode(json.encode(response.body)));
    return response;
  }
  static Future<http.Response> PutUserBio({bio,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Bio");
    var response = await http.Client().put(url,
        body: json.encode({
          "bio":bio.toString()
        })
        ,headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization':'Bearer $UserToken',
        });
   // print(await json.decode(json.encode(response.body)));
    return response;
  }
  static Future<http.Response> PutUserName({FirstName,lastName,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/username");
    var response = await http.Client().put(url,
        body: json.encode({
          "FirstName":FirstName,
          "LastName":lastName
        })
        ,headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization':'Bearer $UserToken',
        });
    return response;
  }
  static Future<http.Response> PutUserPassword({oldPassword,NewPassword,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Password");
    var response = await http.Client().put(url,
        body: json.encode({
          "OldPassword":oldPassword,
          "NewPassword":NewPassword
        })
        ,headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization':'Bearer $UserToken',
        });
    return response;
  }
  static Future<http.Response> GetUserContacts({path,data,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Contacts");
    var response = await http.Client().get(url ,headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization':'Bearer $UserToken',
    });

   // print(response.body);
    return response;
  }
  static Future<http.Response> DeleteContact({ContactId,Token}) async {
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Contacts/");
    var response = await http.Client().delete(url, body:
    json.encode(
        {
          "ContactId":ContactId
        }
    ), headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      //'Charset': 'utf-8'
      'Authorization':'Bearer $UserToken',
      ///'Authorization':Token
    });
    /// print(await json.decode(json.encode(response.body)));
    return response;
  }
  static Future<http.Response> GetContactProfile({path,data,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/shortProfile/$idToken");
    var response = await http.Client().get(url ,headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      //'Charset': 'utf-8'
    });
    print("ccc"+await json.decode(json.encode(response.body)));
    return response;
  }
  static Future<http.Response> AddContact({ContactId,idToken})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Contacts");
    var response = await http.Client().put(url,
        body: json.encode({
          "ContactId":ContactId,
          'Authorization':'Bearer $UserToken',
        })
        ,headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization':'Bearer $UserToken',
        });
    return response;
  }
  static Future<http.Response> FollowUser({UserId})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Follow/$UserId");
    var response = await http.Client().put(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization':'Bearer $UserToken',
        });
    return response;
  }
  static Future<http.Response> UnFollowUser({UserId})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Unfollow/$UserId");
    var response = await http.Client().put(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization':'Bearer $UserToken',
        });
    return response;
  }
  static Future<http.Response> GetFollowers({UserId})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Followers/${UserId==null?"":UserId}");
    var response = await http.Client().get(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization':'Bearer $UserToken',
        });
    return response;
  }
  static Future<http.Response> GetFollowing({UserId})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/user/Following/${UserId==null?"":UserId}");
    var response = await http.Client().get(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization':'Bearer $UserToken',
        });

    return response;
  }

  static Future<http.Response>  CreatePost({

  title,coverPicture,chunkList

})async{
    var url = Uri.parse("http://192.168.1.10:8001/api/V1.0/Post");
    var response = await http.Client().post(url, body:
    json.encode(
        {
          "title": title,
          "coverPicture": coverPicture,
          "postChunks": chunkList
        }
    ), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization':'Bearer $UserToken',
    });
    print(response.statusCode);

    return response;
  }
}

