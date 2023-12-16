import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Datamaneger/Global.dart';
import 'package:stock_helper/Objects/Client.dart';
import 'package:stock_helper/Providers/Pages_Controllers/ClientPageControler.dart';
import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';

class ClientBrows extends StatelessWidget {
  const ClientBrows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create) => MyTheme()),
          ChangeNotifierProvider(create: (create) => ClientPageControler())
        ],
        builder: (context, child) {
          final controler = Provider.of<ClientPageControler>(context);
          final searchtype = controler.searchType;
          final formKey = GlobalKey<FormState>();
          return Row(


            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                              flex: 4,
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 08, 0),
                                child: Container(
                                  color: Color.fromARGB(100, 255, 253, 208),
                                  child: TextFormField(
                                    controller: controler.searchBar,
                                    onChanged: (value) {
                                      controler.Searcher();
                                    },
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
                                  textAlign: TextAlign.center,
                                  style:
                                      Provider.of<MyTheme>(context).bodyMedium),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 1.0,
                            ),
                            height: 20,
                          ), // Add after first child

                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                              child: Text('Phone Number',
                                  textAlign: TextAlign.center,
                                  style:
                                      Provider.of<MyTheme>(context).bodyMedium),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 1.0,
                            ),
                            height: 20,
                          ),

                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                              child: Text('Balence',
                                  textAlign: TextAlign.center,
                                  style:
                                      Provider.of<MyTheme>(context).bodyMedium),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 1.0,
                            ),
                            height: 20,
                          ),

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
                          Container(
                            alignment: Alignment.center,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 1.0,
                            ),
                            height: 20,
                          ),

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
                      ),
                    ),
                    Divider(),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: controler.clientlist(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting)
                            return LinearProgressIndicator();
                          else if (snapshot.hasError)
                            return Text('Error' + snapshot.error.toString());
                          else if (snapshot.data == null ||
                              snapshot.data!.isEmpty) return Text(("Empty"));

                          return ListView.separated(
                            itemCount:  controler.clients.where((client) => client.Client_Id != -1).length,
                            itemBuilder: (context, index) {

                              Client? a = controler.clients.where((client) => client.Client_Id != -1).toList()[index];


                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 10, 20, 10),
                                            child: Text(a!.Client_Name ,textAlign: TextAlign.center,))),
                                    Container(
                                      alignment: Alignment.center,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1.0,
                                      ),
                                      height: 20,
                                    ),
                                    Expanded(
                                        child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 10, 20, 10),
                                            child: Text(a.Client_PN.toString(),textAlign: TextAlign.center,))),
                                    Container(
                                      alignment: Alignment.center,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1.0,
                                      ),
                                      height: 20,
                                    ),
                                    Expanded(
                                        child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 10, 20, 10),
                                            child: Text(
                                                a.Client_Balence.toString(),textAlign: TextAlign.center,))),
                                    Container(
                                      alignment: Alignment.center,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1.0,
                                      ),
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 10, 20, 10),
                                        child: MaterialButton(
                                          onPressed: () {
                                            controler.SelectToEdit(a);
                                          },
                                          child: Center(child: Icon(Icons.edit)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1.0,
                                      ),
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 10, 20, 10),
                                        child: MaterialButton(
                                          onPressed: () {
                                            controler.Delete(a);
                                          },
                                          child:
                                              Center(child: Icon(Icons.delete)),
                                        ),
                                      ),
                                    )
                                  ],
                                );

                            },
                            separatorBuilder: (BuildContext context, int index) =>
                                Divider(),
                          );
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
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Container(
                              color: Color.fromARGB(100, 255, 253, 208),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: controler.c.Client_Name,
                                decoration: InputDecoration(
                                  labelText: 'Client Name\n',
                                ),
                                validator: (value)  {

                                  String messege ="";
                                  controler.clients.forEach((element) {if(element.Client_Name==global.Capitalize(value.toString())) messege="This Client Already Exists" ;
                                  });
                                    if(!messege.isEmpty) return messege;
                                  if (value == null || value.isEmpty )
                                    return "Enter a name";
                                  controler.c.Client_Name = value;
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Container(
                              color: Color.fromARGB(100, 255, 253, 208),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: controler.c.Client_PN.toString(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Client Phone Number\n',
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      (value.length < 10 && value.length > 1))
                                    return "Enter a valid phone Number";
                                  controler.c.Client_PN = int.parse(value);
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Container(
                              color: Color.fromARGB(100, 255, 253, 208),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                initialValue:
                                    controler.c.Client_Balence.toString(),
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
                                  controler.c.Client_Balence =
                                      double.parse(value);
                                  return null;
                                },
                              ),
                            ),
                          ),
                          MaterialButton(
                            color: Colors.blue,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (controler.mode == "Add")
                                    controler.Add();
                                  else
                                    controler.Edit();
                                } else
                                  print("wrong");
                                return null;
                              },
                              child: Text(controler.mode))
                        ])),
              ),
            ],
          );
        });
  }
}
