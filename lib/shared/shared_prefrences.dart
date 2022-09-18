import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{

  static late SharedPreferences sharedPreferences;

  static init() async{
    sharedPreferences= await SharedPreferences.getInstance();
  }

static void setBool({key,value}){
  sharedPreferences.setBool(key,value);
}

static Future<bool?> getBool({key})async{
    return await sharedPreferences.getBool(key);
}


}