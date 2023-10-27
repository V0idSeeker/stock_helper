import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';
import 'package:stock_helper/Pages/Parts/ClientParts/ClientBrows.dart';
import 'package:stock_helper/Providers/ClientPageControler.dart';
import 'package:stock_helper/Providers/MyTheme.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Database_Maneger db=Database_Maneger();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create)=>ClientPageControler()),
          ChangeNotifierProvider(create: (create)=>MyTheme()),
        ],
        builder: (context, child) {


          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 65,
                decoration: BoxDecoration(
                  color: Provider.of<MyTheme>(context).secondaryBackground,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                      'Clients',
                      textAlign: TextAlign.center,
                      style: Provider.of<MyTheme>(context).bodyMedium
                  ),
                ),
              ),          //Page Heading
              Expanded(
                child: ClientBrows(),
              ),
            ],
          )
          ;
        });

  }
}

