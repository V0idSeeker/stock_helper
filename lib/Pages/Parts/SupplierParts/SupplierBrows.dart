import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Objects/Supplier.dart';
import 'package:stock_helper/Providers/Pages_Controllers/SupplierPageControler.dart';
import 'package:stock_helper/Providers/Global_Controllers//MyTheme.dart';
import 'package:stock_helper/Datamaneger/Global.dart';


class SupplierBrows extends StatelessWidget {
  const SupplierBrows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create) => MyTheme()),
          ChangeNotifierProvider(create: (create) => SupplierPageControler())
        ],
        builder: (context, child) {

          final controler = Provider.of<SupplierPageControler>(context);
          final searchtype = controler.searchType;
          final formKey = GlobalKey<FormState>();
          return Row(

            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Form(
                        child:
                        Row(
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
                              flex: 4,
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(8, 0, 08, 0),
                                child: Container(
                                  color: Color.fromARGB(	 100 ,255,  253,  208  ),
                                  child: TextFormField(

                                    controller: controler.searchBar,

                                    onChanged: (value){controler.Searcher();},
                                  ),
                                ),
                              ),
                            ), //selector

                            Expanded(
                              flex: 2,
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
                                      child: Text("Phone Number"),
                                      value: "Phone Number",
                                    ),
                                  ],
                                  onChanged: (value) {
                                    controler.ChangeSearchType(value!);
                                  }),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Row(
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
                          Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                              child: Text('Phone Number',
                                  style:
                                  Provider.of<MyTheme>(context).bodyMedium),
                            ),
                          ),
                          Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                              child: Text('Balence',
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
                                  style:
                                  Provider.of<MyTheme>(context).bodyMedium),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Divider(),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                            future: controler.Supplierlist(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting)
                                return LinearProgressIndicator();
                              else if (snapshot.hasError)
                                return Text('Error'+snapshot.error.toString());
                              else if (snapshot.data == null ||
                                  snapshot.data!.isEmpty) return Text(("Empty"));
                              return ListView.separated(
                                    scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    Supplier? a = snapshot.data?[index];
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child: Text(a!.Supplier_Name))),
                                        Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
                                        Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child:Text(a.Supplier_PN.toString()))),
                                        Container( alignment: Alignment.center,child: VerticalDivider(color: Colors.grey, thickness: 1.0 , ) , height: 20,),
                                        Expanded(child: Padding(  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10), child:Text(a.Supplier_Balence.toString()))),

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
                                  }, separatorBuilder: (BuildContext context, int index) =>Divider()  ,);
                            },
                          ),
                        )),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 4.0),
                child: VerticalDivider(),
              ),
              Expanded(
                child: Form(

                    key: formKey,
                    child: Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              color: Color.fromARGB(	 100 ,255,  253,  208  ),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: controler.c.Supplier_Name,
                                decoration: InputDecoration(
                                  labelText: 'Supplier Name\n',
                                ),
                                validator: (value) {

                                  String messege ="";
                                  controler.suppliers.forEach((element) {if(element.Supplier_Name==global.Capitalize(value.toString())) messege="This Supplier Already Exists" ;
                                  });
                                  if(!messege.isEmpty) return messege;
                                  if (value == null || value.isEmpty)
                                    return "Enter a name";
                                  controler.c.Supplier_Name = value;
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              color: Color.fromARGB(	 100 ,255,  253,  208  ),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: controler.c.Supplier_PN.toString(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,

                                ],
                                decoration: InputDecoration(
                                  labelText: 'Supplier Phone Number\n',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty || (value.length<10 &&value.length >1 ))
                                    return "Enter a valid phone Number";
                                  controler.c.Supplier_PN = int.parse(value);
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(color: Color.fromARGB(	 100 ,255,  253,  208  ),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                initialValue:
                                controler.c.Supplier_Balence.toString(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Balence\n',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return "Enter a Balence";
                                  controler.c.Supplier_Balence =
                                      double.parse(value);
                                  return null;
                                },
                              ),
                            ),
                          ),
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
                              child: Container(color:Colors.blue, child: Text(controler.mode)))



                        ]
                    )
                ),
              ),
            ],
          );
        });
  }
}
