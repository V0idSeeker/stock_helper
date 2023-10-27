import 'package:flutter/material.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';
import 'package:stock_helper/Objects/Product.dart';


class StockPageControler extends ChangeNotifier{
  TextEditingController searchBar=TextEditingController();
  String searchType="Name";
  String searchparamm="";
  String mode="Add";
  Product p=new Product(0, "", "", "count", 0,0, 0);
  Database_Maneger database=Database_Maneger();
void ChangeSearchType(String s){
  searchType=s;

}
void Searcher(){
  if(!searchBar.text.isEmpty)
    searchparamm=searchBar.text;
    else searchparamm="";

  notifyListeners();
}
  Future<List<Product>> productslist() async {
  if(searchType=="Name")return await database.Productslist("Product_Name",searchparamm);
  if(searchType=="Category")return await database.Productslist("Category",searchparamm);
    return await database.Productslist(searchType,searchparamm);
  }

Future<void> Add() async {


 await database.AddProduct(p);
 p=new Product(0, "", "", "count", 0,0, 0);
 notifyListeners();
}

  Future<void> Edit() async{
    await database.EditProduct(p);
    p=new Product(0, "", "", "count", 0,0, 0);
    mode="Add";
    notifyListeners();

  }

  void SelectToEdit(Product f){
  p=f;
  mode="Edit";
  notifyListeners();
  }



  Future<void> Delete(Product f)async{
    await database.DeleteProduct(f);
    notifyListeners();
  }


}