import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';
import 'package:stock_helper/Objects/Product.dart';
import 'package:stock_helper/Pages/Parts/ProductManeger/ProductSearchBar.dart';
import 'package:stock_helper/Providers/MyTheme.dart';
import 'package:stock_helper/Providers/Stock.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (create)=>MyTheme()),
      ChangeNotifierProvider(create: (create)=>StockPageControler())
    ],
      builder: (context , child){
        final controler=Provider.of<StockPageControler>(context);

        return Container(
          width: 100,
          height: 1195,
          decoration: BoxDecoration(
            color: Provider.of<MyTheme>(context).primary,
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ProductSearchBar(),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      child: Text(
                          'Name',
                          style:
                          Provider.of<MyTheme>(context).bodyMedium
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      child: Text(
                          'Category',
                          style:
                          Provider.of<MyTheme>(context).bodyMedium
                      ),
                    ),
                  ),
                  Expanded(child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                    child: Text(
                        'Type',
                        style:
                        Provider.of<MyTheme>(context).bodyMedium
                    ),
                  ),),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      child: Text(
                          'Amount',
                          style:
                          Provider.of<MyTheme>(context).bodyMedium
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      child: Text(
                          'Selling price',
                          style:
                          Provider.of<MyTheme>(context).bodyMedium
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      child: Text(
                          'Buying price',
                          style:
                          Provider.of<MyTheme>(context).bodyMedium
                      ),
                    ),
                  ),
                ],
              ), //header
             Expanded(
                  child:FutureBuilder(future: controler.productslist(),builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting)return LinearProgressIndicator();
                   else if (snapshot.hasError)  return Text('Error: ${snapshot.error}');
                   else if (snapshot.data==null|| snapshot.data!.isEmpty) return Text(("Empty"));
                   return ListView.builder(
                     itemCount: snapshot.data?.length  ,
                       itemBuilder: (context,index){
                       Product? a=snapshot.data?[index];
                       return Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Expanded(child: Text(a!.Product_Name)),
                           Expanded(child: Text(a.Category)),
                           Expanded(child: Text(a.Product_Type)),
                           Expanded(child: Text(a.Product_amount.toString())),
                           Expanded(child: Text(a.Product_Selling_Price.toString())),
                           Expanded(child: Text(a.Product_Buying_Price.toString())),
                         ],
                       );
                       }
                   );
                  },)


                ),
            ],
          ),
        );
      },
    );
  }
}
