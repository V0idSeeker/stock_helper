import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';
import 'package:stock_helper/Providers/SettingsController.dart';

class Exp_Counter extends StatelessWidget {
  const Exp_Counter({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (create)=>MyTheme()),
          ChangeNotifierProvider(create: (create)=>SettingsController())
        ],
      builder: (context,child){
          final theme=Provider.of<MyTheme>(context);
          final controler = Provider.of<SettingsController>(context);

          return FutureBuilder(future: controler.getstats(),
              builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting) return CircularProgressIndicator();
              if(snapshot.hasError)return Text("Error");
              if(controler.is_active) return Container();
              return Text("Time Left: ${controler.number_of_days} days");



              });
    },
    );
  }
}
