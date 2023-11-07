import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Pages/Parts/HistoryParts/DisplayBill.dart';
import 'package:stock_helper/Providers/Pages_Controllers/HistoryPageController.dart';
import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';

class HistoryInterface extends StatelessWidget {
  const HistoryInterface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create) => MyTheme()),
          ChangeNotifierProvider(create: (create) => HistoryPageControler())
        ],
        builder: (context, child) {
          final theme = Provider.of<MyTheme>(context);
          final controler = Provider.of<HistoryPageControler>(context);
          final formKey = GlobalKey<FormState>();
          String name = "Client_Name";
          return GridView(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing:20,
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Text(
                            'Search :',
                            style: theme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8, 0, 08, 0),
                            child: TextFormField(
                              controller: controler.searchBar,
                              onChanged: (value) {
                                controler.Searcher();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            child: DropdownMenu(
                          initialSelection: controler.searchType,
                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                                value: "Client", label: "Clients"),
                            DropdownMenuEntry(
                                value: "Supplier", label: "Suppliers"),
                          ],
                          onSelected: (value) {
                            controler.searchType = value.toString();
                          },
                        )) //selector
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
                          child: Text('Date', style: theme.bodyMedium),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                          child: Text('Name', style: theme.bodyMedium),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                          child: Text('Total', style: theme.bodyMedium),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                          child: Text('Show', style: theme.bodyMedium),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                          child: Text('Delete', style: theme.bodyMedium),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: FutureBuilder(
                    future: controler.Billlist(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return LinearProgressIndicator();
                      else if (snapshot.hasError)
                        return Text('Error' + snapshot.error.toString());
                      else if (snapshot.data == null || snapshot.data!.isEmpty)
                        return Text(("Empty"));
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {

                            Map<String, Object?>? a = snapshot.data?[index];
                            if (controler.searchType == "Client")
                              name = "Client_Name";
                            else
                              name = "Supplier_Name";

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 10, 20, 10),
                                        child: Text(a![name].toString()))),
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 10, 20, 10),
                                        child:
                                            Text(a["Bill_Total"].toString()))),
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 10, 20, 10),
                                        child: Text("${a["Bill_date"].toString().substring(0, 10)} \n ${a["Bill_date"].toString().substring(11, 16)} ",textAlign: TextAlign.center,),)),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 10, 20, 10),
                                    child: MaterialButton(
                                      onPressed: () {
                                         controler.SelectToSee(a["Bill_Id"].toString(),a["Bill_date"].toString().substring(0,16),a[name].toString(),a["Bill_Total"].toString());
                                      },
                                      child: Center(child: Icon(Icons.edit)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 10, 20, 10),
                                    child: MaterialButton(
                                      onPressed: () {
                                         controler.Delete(a["Bill_Id"].toString());
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
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DisplayBill(Bill_Id: controler.Bill_Id,Name: controler.name,Date: controler.date,bill_total: controler.bill_total,),
              ),
            ],
          );
        });
  }
}
