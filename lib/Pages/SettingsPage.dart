import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';
import 'package:stock_helper/Providers/SettingsController.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => MyTheme()),
        ChangeNotifierProvider(create: (create) => SettingsController())
      ],
      builder: (context, child) {
        final theme = Provider.of<MyTheme>(context);
        final controler = Provider.of<SettingsController>(context);
        return FutureBuilder(
            future: controler.getstats(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting)return CircularProgressIndicator();
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: controler.username_updater,
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                    TextField(
                      obscureText: true,
                      controller: controler.password_updater,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                    Text("Active Status : " +
                        controler.data["Is_Active"].toString()),
                    if (true != controler.data["Is_Active"].toString())
                      Text("Exparation Date :" +
                          controler.data["End_Trial"].toString()),
                    Text("App Id:" + controler.data["App_Id"].toString()),
                    TextField(
                      obscureText: true,
                      controller: controler.activator,
                      decoration: InputDecoration(
                        labelText: "Activation Code",
                      ),
                    ),
                    Row(children: [
                      MaterialButton(
                        onPressed: () {
                          controler.UpdateLogIn();
                        },
                        child: Text("Update Info"),
                      ),
                      if (true)
                        MaterialButton(
                          onPressed: () {},
                          child: Text("Activate App"),
                        ),
                    ])
                  ],
                ),
              );
            });
      },
    );
  }
}
