import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';

class SettingsController extends ChangeNotifier{
String username="",password="";
late Map<String, Object?> data;
TextEditingController username_updater=new TextEditingController(),password_updater=new TextEditingController(),activator=new TextEditingController();
Database_Maneger database=Database_Maneger();
Future<void> getdata() async{
  data=(await database.GetSettingsParams())!;

}
Future<bool>getstats()async {

  data=(await database.GetSettingsParams())!;
  username_updater.text=data["User_Name"].toString();
  password_updater.text=data["User_Password"].toString();
  return (data["Remember_User"]=="true");
}
Future<void>UpdateLogIn()async{
  await database.UpdateSettings(username_updater.text, password_updater.text, true);
}
Future<void> changeloginstats(bool states)async{
  await database.UpdateSettings("", "", states);
}





}