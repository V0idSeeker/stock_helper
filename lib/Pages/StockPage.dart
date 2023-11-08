// ignore_for_file: curly_braces_in_flow_control_structures



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Pages/Parts/Activation/Counter.dart';
import 'package:stock_helper/Pages/Parts/ProductParts/ProductBraws.dart';

import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';




class StockPage extends StatelessWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: Text(
                            'Stock',
                            textAlign: TextAlign.center,
                            style: Provider.of<MyTheme>(context).bodyMedium
                        ),
                      ),
                    ),
                    Exp_Counter(),
                  ],
                ),
              ),          //Page Heading
              Expanded(
                child: ProductBrows(),
              ),
            ],
          )
          ;
        });
  }
}
