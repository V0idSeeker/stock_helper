import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Providers/ClientPageControler.dart';
import 'package:stock_helper/Providers/MyTheme.dart';

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
              Column(),
              Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: controler.c.Client_Name,
                    decoration: InputDecoration(
                      labelText: 'Client Name\n',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Enter a name";
                      controler.c.Client_Name = value;
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: controler.c.Client_PN.toString(),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,

                    ],
                    decoration: InputDecoration(
                      labelText: 'Client Phone Number\n',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length<10)
                        return "Enter a valid phone Number";
                      controler.c.Client_PN = int.parse(value);
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue:
                    controler.c.Clint_Balence.toString(),
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
                      controler.c.Clint_Balence =
                          double.parse(value);
                      return null;
                    },
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
                    child: Text(controler.mode))



              ]
              )
              ),
            ],
          );
        });
  }
}
