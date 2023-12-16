import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';
import 'package:stock_helper/Providers/Pages_Controllers/InterfaceControler.dart';
import 'package:stock_helper/main.dart';
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InterfaceControler()),
        ChangeNotifierProvider(create: (create)=>MyTheme())
      ],
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData.light(),
          home: MainInterface(),
        );
      },
    );
  }
}

class MainInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<InterfaceControler>(context);
    final theme= Provider.of<MyTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Store Helper" ,style: theme.Headliers ,)),
      ),
    
      drawer: Drawer(
        width: MediaQuery.of(context).size.width/11,
        child:  ListView(
          children: [
            ListTile(

              title: Icon(Icons.store),
              onTap: () {
                provider.ChangeMain("Selling");
              },
            ),
            ListTile(
              title: Icon(Icons.storage),
              onTap: () {provider.ChangeMain("Stock");},
            ),
            ListTile(
              title: Icon(Icons.person),
              onTap: () {
                provider.ChangeMain("Clients");
              },
            ),
            ListTile(
              title: Icon(Icons.fire_truck),
              onTap: () {provider.ChangeMain("Supplier");},
            ),
            ListTile(
              title: Icon(Icons.history),
              onTap: () {provider.ChangeMain("History");},
            ),
            ListTile(
              title: Icon(Icons.settings),
              onTap: () {provider.ChangeMain("Settings");},
            ),
            ListTile(
              title: Icon(Icons.logout),
              onTap: (){provider.logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogIn()),
              );
              ;},
            )

          ],
        ),
      ),

      body:
          provider.main_screan,

    );
  }
}
