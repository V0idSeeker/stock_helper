import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Providers/Pages_Controllers/DisplayBillController.dart';
import 'package:stock_helper/Providers/Global_Controllers/MyTheme.dart';

class DisplayBill extends StatelessWidget {
  final String Bill_Id,Name,Date,bill_total;
  const DisplayBill({Key? key,required this.bill_total,required  this.Bill_Id,required  this.Date,required  this.Name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   if(Bill_Id=="") return Container(child: Center(child: Text("Empty"),),);
   else return MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (create)=>MyTheme()),
       ChangeNotifierProvider(create: (create)=>DisplayBillControler())
     ],
     builder: (context,child){
       final controller=Provider.of<DisplayBillControler>(context);
       return Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Row(
             children: [
               Expanded(child: Text("Owner : "+Name ,textAlign: TextAlign.center,)),
               Expanded(child: Text("Date :"+ Date,textAlign: TextAlign.center))
             ],
           ),
           Expanded(
             child: FutureBuilder(future:controller.getBillinfo(Bill_Id), builder: (context,snapshot){
               if(snapshot.connectionState==ConnectionState.waiting) return CircularProgressIndicator();
               if(snapshot.hasError )return Text("Error");

                 return ListView.builder(
               itemCount: snapshot.data?.length,
                   itemBuilder: (context,index){
                  Map f=snapshot.data![index];
                  return ListTile(
                    title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Text(f["Product_Name"],textAlign: TextAlign.center)),
                        Expanded(child: Text(f["Element_amount"].toString(),textAlign: TextAlign.center)),
                        Expanded(child: Text(f["Bill_Element_Price"].toString(),textAlign: TextAlign.center)),

                    ],
                    ),
                  );

                   }

               );

             }),
           ),
           Expanded(child: Text( "Total : "+bill_total,style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)),
           Expanded(child: Center(child: MaterialButton(onPressed: (){controller.print(Name ,Date, bill_total);}, child: Text("Print"),)))
         ],

       );
     },
   );
  }
}
