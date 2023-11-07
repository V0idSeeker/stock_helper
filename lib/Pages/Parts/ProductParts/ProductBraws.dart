import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Objects/Product.dart';
import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';
import 'package:stock_helper/Providers/Pages_Controllers/StockPageControler.dart';

class ProductBrows extends StatelessWidget {
  const ProductBrows({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create) => MyTheme()),
          ChangeNotifierProvider(create: (create) => StockPageControler())
        ],
        builder: (context, child) {
          final controler = Provider.of<StockPageControler>(context);
          final searchtype = controler.searchType;
          final formKey = GlobalKey<FormState>();
          return GridView(

              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 0,
                childAspectRatio: 1,
              ),
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  children: [
                    Form(
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            child: Text(
                              'Search :',
                              style: Provider.of<MyTheme>(context).bodyMedium,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                              child: TextFormField(
                                controller: controler.searchBar,

                                onChanged: (value){controler.Searcher();},
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
                                  DropdownMenuItem(
                                    child: Text("Supplier"),
                                    value: "Supplier",
                                  ),
                                ],
                                onChanged: (value) {
                                  Provider.of<StockPageControler>(context,
                                          listen: false)
                                      .ChangeSearchType(value!);
                                }),
                          ),

                        ],
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            child: Text('Name',
                                style:
                                    Provider.of<MyTheme>(context).bodyMedium),
                          ),
                        ),
                        Expanded(

                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            child: Text('Category',

                                style:
                                    Provider.of<MyTheme>(context).bodyMedium),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            child: Text('Type',
                                style:
                                    Provider.of<MyTheme>(context).bodyMedium),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            child: Text('Amount',
                                style:
                                    Provider.of<MyTheme>(context).bodyMedium),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            child: Text('Selling price',
                                style:
                                    Provider.of<MyTheme>(context).bodyMedium),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            child: Text('Buying price',
                                style:
                                    Provider.of<MyTheme>(context).bodyMedium),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            child: Text('Edit',
                                style:
                                Provider.of<MyTheme>(context).bodyMedium),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            child: Text('Delete',
                                style:
                                Provider.of<MyTheme>(context).bodyMedium),
                          ),
                        ),
                      ],
                    ), //header
                    Expanded(
                        child: FutureBuilder(
                      future: controler.productslist(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return LinearProgressIndicator();
                        else if (snapshot.hasError)
                          return Text('Error');
                        else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) return Text(("Empty"));
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Product? a = snapshot.data?[index];
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child: Text(a!.Product_Name))),
                                  Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child:Text(a.Category))),
                                  Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child:Text(a.Product_Type))),
                                  Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child: Text(a.Product_amount.toString()))),
                                  Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child:Text(a.Product_Selling_Price.toString()))),
                                  Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child: Text(a.Product_Buying_Price.toString()))),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                      child: MaterialButton(
                                        onPressed: () {
                                          controler.SelectToEdit(a);

                                        },
                                        child: Center(child: Icon(Icons.edit)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                      child: MaterialButton(
                                        onPressed: () {
                                          controler.Delete(a);

                                        },
                                        child: Center(child: Icon(Icons.delete)),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                    )),
                  ],
                ), //list+searchbar
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(

                        initialValue: controler.p.Product_Name,
                        decoration: InputDecoration(
                          labelText: 'Product Name\n',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Enter a name";
                          controler.p.Product_Name = value;
                          return null;
                        },
                      ),

                      TextFormField(
                        initialValue: controler.p.Category,
                        decoration: InputDecoration(
                          labelText: 'Product Category\n',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Enter a Category";
                          controler.p.Category = value;
                          return null;
                        },
                      ),
                      FutureBuilder(future: controler.GetSuppliers_Ids(), builder: (context ,snapshot){
                        List<DropdownMenuItem> manue=[];
                        manue.add(DropdownMenuItem(
                          child: Text("No Supplier"),
                          value: -1,
                        ));
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return CircularProgressIndicator();
                        else if (snapshot.hasError)
                          return Text('Error');
                        else if (!(snapshot.data == null || snapshot.data!.isEmpty)) {
                          snapshot.data?.forEach((element) {
                            manue.add(DropdownMenuItem(child: Text(element[1].toString()),value:element[0]));
                          });
                        }
                        return DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Product Supplier\n',
                          ),
                          value: controler.p.Supplier_Id,
                          items: manue,
                          onChanged: (value){
                            controler.p.Supplier_Id=value;
                          },
                        );

                      }),
                      DropdownButtonFormField(

                          value: controler.p.Product_Type,
                          decoration: InputDecoration(
                            labelText: 'Product Category\n',
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text("Count"),
                              value: "Count",
                            ),
                            DropdownMenuItem(
                              child: Text("Weight"),
                              value: "Weight",
                            ),
                            DropdownMenuItem(
                              child: Text("Volume"),
                              value: "Volume",
                            )
                          ],
                          onChanged: (value) {
                            if (value != null) controler.p.Product_Type = value;
                          }),
                      TextFormField(
                        initialValue: controler.p.Product_amount.toString(),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,3}')),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Amount\n',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Enter an Amount";
                          controler.p.Product_amount = double.parse(value);
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue:
                            controler.p.Product_Buying_Price.toString(),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Buying Price\n',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Enter a Buying Price";
                          controler.p.Product_Buying_Price =
                              double.parse(value);
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue:
                            controler.p.Product_Selling_Price.toString(),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Selling Price\n',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Enter a Selling Price";
                          controler.p.Product_Selling_Price =
                              double.parse(value);
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if(controler.mode=="Add")
                                  controler.Add();
                                  else controler.Edit();

                                } else
                                  print("wrong");
                                return null;
                              },
                              child: Text(controler.mode)),
                          controler.refresh(),
                        ],
                      ),

                    ],
                  ),
                )//add form
              ]);
        });
  }
}
