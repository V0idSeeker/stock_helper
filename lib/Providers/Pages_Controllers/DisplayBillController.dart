import 'package:flutter/material.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';
import 'package:stock_helper/Datamaneger/Printer.dart' ;

class DisplayBillControler extends ChangeNotifier{
  late List<Map<String ,Object?>>? elements ;
  Database_Maneger database=new Database_Maneger();

  Future<List<Map<String, Object?>>?>getBillinfo(String Bill_Id)async{
    elements= await database.GetBillElements(Bill_Id);
    return elements;
  }
  Future<void> print(String owner ,String date,String bill_total)async{

    Printer.printDoc(owner,date,bill_total,elements);
  }
}