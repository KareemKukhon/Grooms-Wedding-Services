import 'package:shared_preferences/shared_preferences.dart';

class ShP{
  ShP._();
  static ShP shp=ShP._();
  static late final SharedPreferences localStorage;
  initShP()async{
    localStorage=await SharedPreferences.getInstance();
  }
  setValue(String key,String value)async{
    await localStorage.setString(key, value);
  }
  getValue(String key){
    return localStorage.getString(key);
  }
  
}