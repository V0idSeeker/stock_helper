import 'package:flutter/material.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';
import 'package:stock_helper/Objects/Supplier.dart';

class SupplierPageControler extends ChangeNotifier {
  TextEditingController searchBar=TextEditingController();
  Database_Maneger database=Database_Maneger();
  String searchType="Name";
  String searchparamm="";
  Supplier c=new Supplier(0,"",00000000,0);
  String mode="Add";
  List<Supplier> suppliers =[];

  void Searcher(){
    if(!searchBar.text.isEmpty)
      searchparamm=searchBar.text;
    else searchparamm="";

    notifyListeners();
  }
  void ChangeSearchType(String s){
    searchType=s;

  }
  Future<List<Supplier>> Supplierlist() async {
    if(searchType=="Name")suppliers= await database.Supplierslist("Supplier_Name",searchparamm);
    else if(searchType=="Phone Number")suppliers= await database.Supplierslist("Supplier_PN",searchparamm);
    else suppliers= await database.Supplierslist(searchType, searchparamm);
  return suppliers;
  }
  Future<void> Add() async {
    await database.AddSupplier(c);
    c=new Supplier(0,"",00000000,0);
    notifyListeners();
  }

  Future<void> Edit() async{
    await database.EditSupplier(c);
    c=new Supplier(0,"",00000000,0);
    mode="Add";
    notifyListeners();

  }

  void SelectToEdit(Supplier f){
    c=f;
    mode="Edit";
    notifyListeners();
  }



  Future<void> Delete(Supplier f)async{
    await database.DeleteSupplier(f);
    notifyListeners();
  }


}