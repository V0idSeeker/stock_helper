import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';
import 'package:stock_helper/Providers/Pages_Controllers/SellingPageControler.dart';

class SellingInterface extends StatelessWidget {
  const SellingInterface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create) => MyTheme()),
          ChangeNotifierProvider(create: (create) => SellingPageControler()),
        ],
        builder: (context, child) {
          final controler = Provider.of<SellingPageControler>(context);
          final theme = Provider.of<MyTheme>(context);
          FocusNode _focusNode = FocusNode();

          return Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                          //categories list

                          child: FutureBuilder(
                        future: controler.get_Categories(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();
                          if (snapshot.hasError) return Text("Error");
                          if (snapshot.data!.isEmpty)
                            return Center(
                              child: Text(
                                "Epmty",
                                style: theme.labelMedium,
                                textAlign: TextAlign.center,
                              ),
                            );
                          else
                            return Container(
                              color: theme.secondaryBackground,
                              child: ListView.separated(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        snapshot.data![index].toString(),
                                        style: theme.labelMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    onTap: () {
                                      controler.searched_Category =
                                          snapshot.data![index].toString();
                                      controler.notifyListeners();
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(
                                  thickness: 2,
                                ),
                              ),
                            );
                        },
                      )),
                      //browser
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder(
                              future: controler.ProductsList(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return CircularProgressIndicator();
                                if (snapshot.hasError) return Text("Error");
                                if (snapshot.data!.isEmpty)
                                  return Text("Epmty");
                                if (snapshot.data == null ||
                                    snapshot.data!.isEmpty)
                                  return Text("There is no products");
                                final data = snapshot.data!;
                                return GridView.builder(
                                    itemCount: data.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemBuilder: (context, index) {
                                      return ElevatedButton(
                                          onPressed: () {
                                            controler.add_to_bill(data[index]);
                                          },
                                          child: Text(
                                            data[index].Product_Name,
                                          ));
                                    });
                              },
                            ),
                          )),
                    ],
                  )),
              VerticalDivider(),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 7,
                            child: ListView.separated(
                                itemCount: controler.current_bill.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      controler.Edeting(index);
                                      FocusScope.of(context)
                                          .requestFocus(_focusNode);
                                    },
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(controler
                                                .product_names[index]
                                                .toString())),
                                        Expanded(
                                            child: Text(controler
                                                .current_bill[index]
                                                .Bill_Element_Price
                                                .toString())),
                                        Expanded(
                                            child: Text(controler
                                                .current_bill[index]
                                                .Element_amount
                                                .toString())),
                                        Expanded(
                                            child: MaterialButton(
                                          onPressed: () {
                                            controler.Dellete_From_Bill(index);
                                          },
                                          child: Icon(Icons.delete),
                                        ))
                                      ],
                                    ),
                                  );
                                }, separatorBuilder: (BuildContext context, int index) =>Divider(),)),
                        Expanded(
                            child: TextField(
                          textAlign: TextAlign.center,
                          focusNode: _focusNode,
                          readOnly: controler.edeting_mode,
                          controller: controler.edit_controler,
                          onSubmitted: (value) {
                            controler.EdetAmount();
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,3}')),
                          ],
                        )),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: FutureBuilder(
                                    future: controler.get_ClientList(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting)
                                        return RefreshProgressIndicator();
                                      if (snapshot.hasError)
                                        return Text("Error");
                                      List<DropdownMenuItem> items = [];
                                      snapshot.data!.forEach((element) {
                                        items.add(DropdownMenuItem(
                                          child: Text(element.Client_Name),
                                          value: element.Client_Id,
                                        ));
                                      });
                                      return DropdownButton(
                                          value: controler.bill.Owner_Id,
                                          items: items,
                                          onChanged: (value) {
                                            controler.bill.Owner_Id = value;
                                            controler.notifyListeners();
                                          });
                                    }),
                              ),
                              Expanded(
                                  child: Text("Total :${controler.total}")),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Bill is Payed"),
                              Checkbox(
                                value: controler.isPayed,
                                onChanged: (bool? value) {
                                  controler.isPayed = value!;
                                  controler.notifyListeners();
                                },
                              ),
                              Text("Print Bill"),
                              Checkbox(
                                value: controler.printer,
                                onChanged: (bool? value) {
                                  controler.printer = value!;
                                  controler.notifyListeners();
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            onPressed: () async {
                              String? r = await controler.product_avilability();

                              if (r == null)
                                controler.Save_Bill();
                              else {
                                controler.Error(r);
                              }
                            },
                            child: Container( padding: EdgeInsets.all(8),color:
                            Colors.blue,child: Text("Add Bill",)),
                          ),
                        )),
                        controler.f,
                      ],
                    ),
                  ))
            ],
          );
        });
  }
}
