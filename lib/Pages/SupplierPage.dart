import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stock_helper/Pages/Parts/SupplierParts/SupplierBrows.dart';
import 'package:stock_helper/Providers/SupplierPageControler.dart';
import 'package:stock_helper/Providers/MyTheme.dart';

class SupplierPage extends StatelessWidget {
  const SupplierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create)=>SupplierPageControler()),
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
                      'Suppliers',
                      textAlign: TextAlign.center,
                      style: Provider.of<MyTheme>(context).bodyMedium
                  ),
                ),
              ),          //Page Heading
              Expanded(
                child: SupplierBrows(),
              ),
            ],
          )
          ;
        });

  }
}

