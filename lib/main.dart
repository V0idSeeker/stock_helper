import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/MainPage.dart';
import 'package:stock_helper/Pages/Parts/Activation/Activator.dart';
import 'package:stock_helper/Pages/Parts/Activation/Counter.dart';
import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';
import 'package:stock_helper/Providers/SettingsController.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  runApp(const MyApp());
  windowManager.setMinimumSize(Size(1390, 720));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LogIn();
  }
}

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => MyTheme()),
        ChangeNotifierProvider(create: (create) => SettingsController())
      ],
      builder: (context, child) {
        final theme = Provider.of<MyTheme>(context);
        final controler = Provider.of<SettingsController>(context);

        final formKey = GlobalKey<FormState>();
        return MaterialApp(

          home: FutureBuilder(
              future: controler.getstats(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Container(color:Colors.white ,child: Center(child:CircularProgressIndicator()),);
                if (snapshot.hasError) return Container(color:Colors.white ,child: Center(child:Text(snapshot.error.toString())),);
                if (snapshot.data != null && snapshot.data == true && controler.number_of_days>0)
                  return MainPage();
                else
                  return Scaffold(

                    body: Center(

                      child: SizedBox(
                        height:MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width/4,
                        child: Column(
                          children: [
                            Icon(Icons.store),

                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    initialValue: controler.username,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText: 'Username',
                                    ),
                                    onChanged: (value) {
                                      controler.username = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          value == null ||
                                          value != controler.data["User_Name"])
                                        return "Wrong username";
                                      else
                                        return null;
                                    },
                                  ),
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    obscureText: true,
                                    initialValue: controler.password,
                                    onChanged: (value) {
                                      controler.password = value;
                                    },
                                    decoration: InputDecoration(

                                      hintText: 'Password',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          value == null ||
                                          value !=
                                              controler.data["User_Password"])
                                        return "Wrong Password";
                                      else
                                        return null;
                                    },
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate() && controler.number_of_days > 0 || controler.is_active) {
                                        controler.changeloginstats(true);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MainPage()),
                                        );
                                      } else
                                        return null;
                                    },
                                    child: Text("go",
                                      textAlign: TextAlign.center,
                                      style: theme.Buttons,
                                    ),
                                  ),
                                  Exp_Counter(),
                                  if(controler.number_of_days<0) Activator_input()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
              }),
        );
      },
    );
  }
}
