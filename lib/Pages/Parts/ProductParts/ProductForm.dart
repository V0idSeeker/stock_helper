

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Providers/MyTheme.dart';

import 'package:stock_helper/Providers/StockPageControler.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (create)=>MyTheme()),
        ChangeNotifierProvider(create: (create)=>StockPageControler())
      ],
      builder: (context , child){
      final formKey=GlobalKey<FormState>();
      final controler=Provider.of<StockPageControler>(context);
        return Consumer(
          builder: (BuildContext context, value, Widget? child) {
          return  Form(
            key: formKey,
            child:Column(
              children: [

                TextFormField(
                  initialValue: controler.p.Product_Name,
                   decoration: InputDecoration(
                    labelText: 'Product Name\n',),
                  validator: (value){
                     if(value==null||value.isEmpty)return "Enter a name";controler.p.Product_Name=value;  return null;
                  },
                ),
                TextFormField(
                  initialValue: controler.p.Category,
                  decoration: InputDecoration(
                    labelText: 'Product Category\n',),
                  validator: (value){
                    if(value==null||value.isEmpty)return "Enter a name"; controler.p.Category=value; return null;
                  },
                ),
                DropdownButtonFormField(
                  value: controler.p.Product_Type,
                  decoration: InputDecoration(labelText: 'Product Category\n',),
                  items: [
                    DropdownMenuItem(child: Text("Count"),value: "count",),
                    DropdownMenuItem(child: Text("Weight"),value: "weight",),
                    DropdownMenuItem(child: Text("Volume"),value: "volume",)
                  ],
                  onChanged: (value){if(value!=null)controler.p.Category=value;}

                ),
                TextFormField(
                  initialValue: controler.p.Product_amount.toString(),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),],
                  decoration: InputDecoration(
                    labelText: 'Amount\n',),
                  validator: (value){
                    if(value==null||value.isEmpty)return "Enter a name"; controler.p.Product_amount=double.parse(value); return null;
                  },
                ),
                TextFormField(
                  initialValue: controler.p.Product_Buying_Price.toString(),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),],
                  decoration: InputDecoration(
                    labelText: 'Buying Price\n',),
                  validator: (value){
                    if(value==null||value.isEmpty)return "Enter a name"; controler.p.Product_Buying_Price=double.parse(value); return null;
                  },
                ),
                TextFormField(
                  initialValue: controler.p.Product_Selling_Price.toString(),
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),],
                  decoration: InputDecoration(
                    labelText: 'Selling Price\n',),
                  validator: (value){
                    if(value==null||value.isEmpty)return "Enter a name"; controler.p.Product_Selling_Price=double.parse(value); return null;
                  },
                ),
                ElevatedButton(onPressed: (){

                  if(formKey.currentState!.validate() ){
                    controler.Add();
                  }
                  else print("wrong");
                  return null;
                }, child: Text("Add"))
              ],
            ) ,
          );}
        );
      },
    );
  }
}
