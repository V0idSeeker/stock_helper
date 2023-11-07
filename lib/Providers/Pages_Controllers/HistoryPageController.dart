import 'package:flutter/material.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';

class HistoryPageControler extends ChangeNotifier{
  TextEditingController searchBar=TextEditingController();
  Database_Maneger database=Database_Maneger();
  String  searchparamm="";
  String searchType="Client";
  String Bill_Id="",date="",name="",bill_total="";
  void Searcher(){
    if(!searchBar.text.isEmpty)
      searchparamm=searchBar.text;
    else searchparamm="";

    notifyListeners();
  }

  Future<List<Map<String, Object?>>?> Billlist() async {
    if(searchType=="Client")return await database.GetBill(searchparamm, "Client");
    return await database.GetBill(searchparamm, "Supplier");
  }




  void SelectToSee(String id,String date,String name ,String bt){
    Bill_Id=id;
    this.date=date;
    this.name=name;
    bill_total=bt;
    notifyListeners();
  }



  Future<void> Delete(String f)async{
    await database.DeleteBill(f);
    notifyListeners();
  }

}