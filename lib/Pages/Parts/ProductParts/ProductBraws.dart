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
          return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
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
                        Divider(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                child: Text('Name',
                                    textAlign: TextAlign.center,
                                    style:
                                        Provider.of<MyTheme>(context).bodyMedium),
                              ),
                            ),
                            Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),

                            Expanded(

                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                child: Text('Category',
                                    textAlign: TextAlign.center,

                                    style:
                                        Provider.of<MyTheme>(context).bodyMedium),
                              ),
                            ),
                            Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),

                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                child: Text('Type',
                                    textAlign: TextAlign.center,
                                    style:
                                        Provider.of<MyTheme>(context).bodyMedium),
                              ),
                            ),
                            Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),

                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                child: Text('Amount',
                                    textAlign: TextAlign.center,
                                    style:
                                        Provider.of<MyTheme>(context).bodyMedium),
                              ),
                            ),
                            Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),

                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                child: Text('Selling price',
                                    textAlign: TextAlign.center,
                                    style:
                                        Provider.of<MyTheme>(context).bodyMedium),
                              ),
                            ),
                            Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),

                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                child: Text('Buying price',
                                    textAlign: TextAlign.center,
                                    style:
                                        Provider.of<MyTheme>(context).bodyMedium),
                              ),
                            ),
                            Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),

                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                child: Text('Edit',
                                    textAlign: TextAlign.center,
                                    style:
                                    Provider.of<MyTheme>(context).bodyMedium),
                              ),
                            ),
                            Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),

                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                                child: Text('Delete',
                                    textAlign: TextAlign.center,
                                    style:
                                    Provider.of<MyTheme>(context).bodyMedium),
                              ),
                            ),
                          ],
                        ), //header
                        Divider(),
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
                            return ListView.separated(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Product? a = snapshot.data?[index];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child: Text(a!.Product_Name,textAlign: TextAlign.center))),
                                      Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
                                      Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child:Text(a.Category,textAlign: TextAlign.center))),
                                      Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
                                      Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child:Text(a.Product_Type,textAlign: TextAlign.center))),
                                      Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
                                      Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child: Text(a.Product_amount.toString(),textAlign: TextAlign.center))),
                                      Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
                                      Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child:Text(a.Product_Selling_Price.toString(),textAlign: TextAlign.center))),
                                      Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
                                      Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child: Text(a.Product_Buying_Price.toString() ,textAlign: TextAlign.center,))),
                                      Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
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
                                      Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
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
                                }, separatorBuilder: (BuildContext context, int index) => Divider(),);
                          },
                        )),
                      ],
                    ),
                  ),
                ), //list+searchbar
                Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),

                Expanded(
                  child: ListView(
                    children: [Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container( padding: const EdgeInsets.symmetric(vertical: 20),
                            color: Color.fromARGB(	 100 ,255,  253,  208  ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
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
                          ),

                          Container( padding: const EdgeInsets.symmetric(vertical: 20),color: Color.fromARGB(	 100 ,255,  253,  208  ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
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
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: FutureBuilder(future: controler.GetSuppliers_Ids(), builder: (context ,snapshot){
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
                                    return Container(color: Color.fromARGB(	 100 ,255,  253,  208  ),
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Product Supplier\n',
                                        ),
                                        value: controler.p.Supplier_Id,
                                        items: manue,
                                        onChanged: (value){
                                          controler.p.Supplier_Id=value;
                                        },
                                      ),
                                    );

                                  }),
                                ),
                                Expanded(flex:1,child: Checkbox(
                                  semanticLabel: "Paied",
                                  value: controler.paied,
                                  onChanged: (bool? value) { controler.changePaiedStatus(value!); },))
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            color: Color.fromARGB(	 100 ,255,  253,  208  ),
                            child: DropdownButtonFormField(

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
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            color: Color.fromARGB(	 100 ,255,  253,  208  ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
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
                          ),
                          Container( padding: const EdgeInsets.symmetric(vertical: 20),color: Color.fromARGB(	 100 ,255,  253,  208  ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
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
                          ),
                          Container( padding: const EdgeInsets.symmetric(vertical: 20),color: Color.fromARGB(	 100 ,255,  253,  208  ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
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
                    ),]
                  ),
                )//add form
              ]);
        });
  }
}
