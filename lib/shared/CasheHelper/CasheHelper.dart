import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper{
static SharedPreferences ?sharedPreferences;
static init()async{
  sharedPreferences= await SharedPreferences.getInstance();
}
// static Future<bool> putData({
//   required String key,
//   required bool value
// })async{
//   return await sharedPreferences!.setBool(
//       key,
//       value);
// }
//  static dynamic getbool({
//   required String key
// }){
//     return sharedPreferences!.getBool(key);
// }

static Future<bool> saveData({
  required dynamic value,
  required String key
})async{
  if(value is String){
    return await sharedPreferences!.setString(key, value);
  }
  else if(value is double){
    return await sharedPreferences!.setDouble(key, value);
  }
  else if(value is bool){
    return await sharedPreferences!.setBool(key, value);
  }
  else
    return await sharedPreferences!.setInt(key, value);

}
static dynamic getData({
  required String key
}){
  return sharedPreferences!.get(key);

}

static Future<bool> ClearData({
    required String key
})async{
 return await sharedPreferences!.remove(key);

}

}