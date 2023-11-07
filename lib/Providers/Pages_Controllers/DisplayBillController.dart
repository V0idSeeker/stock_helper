import 'package:flutter/material.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';


class DisplayBillControler extends ChangeNotifier{
  Database_Maneger database=new Database_Maneger();

  Future<List<Map<String, Object?>>?>getBillinfo(String Bill_Id)async{
    return await database.GetBillElements(Bill_Id);
  }
  void print(){}
}