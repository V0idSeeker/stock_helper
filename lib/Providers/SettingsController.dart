import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';

class SettingsController extends ChangeNotifier{
String username="",password="";
late Map<String, Object?> data;
TextEditingController username_updater=new TextEditingController(),password_updater=new TextEditingController(),activator=new TextEditingController();
 late bool is_active;
 int number_of_days =0;
Database_Maneger database=Database_Maneger();

Future<bool>getstats()async {

  data=(await database.GetSettingsParams())!;
  username_updater.text=data["User_Name"].toString();
  password_updater.text=data["User_Password"].toString();
  is_active=(data["Is_Active"]=="true");
  DaysUntillEnd();
  return (data["Remember_User"]=="true");
}
Future<void>UpdateLogIn()async{
  await database.UpdateSettings(username_updater.text, password_updater.text, true);
}
Future<void> changeloginstats(bool states)async{
  await database.UpdateSettings("", "", states);
}

Future<void> Acivator() async{
 is_active= await database.Activate(activator.text);
 notifyListeners();

}
void DaysUntillEnd(){
  number_of_days=  DateTime.parse(data["End_Trial"].toString()).difference(DateTime.now()).inDays;
  Timer.periodic(Duration(seconds: 86400), (Timer t) {
    number_of_days=  DateTime.parse(data["End_Trial"].toString()).difference(DateTime.now()).inDays;
    notifyListeners();
    });


}


}