import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Pages/Parts/Activation/Counter.dart';
import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';
import 'package:stock_helper/Providers/SettingsController.dart';

class Activator_input extends StatelessWidget {
  const Activator_input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (create)=>MyTheme()),
      ChangeNotifierProvider(create: (create)=>SettingsController())
    ],
    builder: (context,child){
      final theme=Provider.of<MyTheme>(context);
      final controler=Provider.of<SettingsController>(context);
      return FutureBuilder(
        future: controler.getstats(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)return CircularProgressIndicator();
          if(snapshot.hasError) return Text("Error");
          if(controler.is_active) return Container();

          return Column(
            children: [
              Text("Exparation Date :" +
                  controler.data["End_Trial"].toString()),
              Text("App Id:" + controler.data["App_Id"].toString()),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: true,
                      controller: controler.activator,
                      decoration: InputDecoration(
                        labelText: "Activation Code",
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {controler.Acivator();},
                    child: Text("Activate App"),
                  ),

                ],
              ),
            ],
          );
        });
    },
    );
  }
}
