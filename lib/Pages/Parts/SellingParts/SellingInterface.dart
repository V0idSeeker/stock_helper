import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Providers/MyTheme.dart';
import 'package:stock_helper/Providers/SellingPageControler.dart';

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
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(snapshot.data![index].toString()),
                                  onTap: () {
                                    controler.searched_Category =
                                        snapshot.data![index].toString();
                                    controler.notifyListeners();
                                  },
                                );
                              });
                        },
                      )),
                      //browser
                      Expanded(
                          flex: 3,
                          child:FutureBuilder(future: controler.ProductsList(),builder: (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.waiting) return CircularProgressIndicator();
                          if(snapshot.hasError)return Text("Error");
                          if(snapshot.data==null||snapshot.data!.isEmpty)return Text("There is no products");
                          final data=snapshot.data!;
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
                                      onPressed: (){},
                                      child: Text(data[index].Product_Name,));
                                });
                          },
                          )
                      ),

                    ],
                  )),
              Expanded(
                flex: 2,
                  child: Row(
                children: [],
              ))
            ],
          );
        });
  }
}
