import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Providers/MyTheme.dart';
import 'package:stock_helper/Providers/Stock.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchtype = Provider.of<StockPageControler>(context).searchType;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => MyTheme()),
        ChangeNotifierProvider(create: (create) => StockPageControler())
      ],
      builder: (context, child) {
        return Form(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                child: Text(
                  'Search :',
                  style: Provider.of<MyTheme>(context).bodyMedium,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                  child: TextFormField(
                    controller: Provider.of<StockPageControler>(context).searchBar,


                  ),
                ),
              ), //selector

              Expanded(
                child: DropdownButtonFormField(
                    value: searchtype,
                    decoration: InputDecoration(
                      labelText: 'Search Type\n',
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text("Name"),
                        value: "Name",
                      ),
                      DropdownMenuItem(
                        child: Text("Category"),
                        value: "Category",
                      ),
                    ],
                    onChanged: (value) {
                      Provider.of<StockPageControler>(context , listen: false)
                          .ChangeSearchType(value!);
                    }),
              ),
              MaterialButton(onPressed: (){Provider.of<StockPageControler>(context).Searcher();},)

            ],
          ),
        );
      },
    );
  }
}
