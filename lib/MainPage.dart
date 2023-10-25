import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Providers/InterfaceControler.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InterfaceControler()),
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
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Store Helper")),
      ),

      body: Row(
        children: [
          Flexible(
            fit: FlexFit.loose,

            child: ListView(

              children: [
                ListTile(
                  title: Icon(Icons.store),
                  onTap: () {
                    provider.ChangeMain("Selling");
                  },
                ),
                ListTile(
                  title: Icon(Icons.person),
                  onTap: () {
                    provider.ChangeMain("Clients");
                  },
                ),
                ListTile(
                  title: Icon(Icons.storage),
                  onTap: () {provider.ChangeMain("Stock");},
                ),
                ListTile(
                  title: Icon(Icons.fire_truck),
                  onTap: () {},
                ),
                ListTile(
                  title: Icon(Icons.history),
                  onTap: () {},
                ),
                ListTile(
                  title: Icon(Icons.query_stats),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Expanded(
            flex: 13,

            child: Consumer<InterfaceControler>(builder: (context, notifier, child) {
              return provider.main_screan;
            }),
          ),
        ],
      ),
    );
  }
}
