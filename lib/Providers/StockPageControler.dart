import 'package:flutter/material.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';
import 'package:stock_helper/Objects/Product.dart';


class StockPageControler extends ChangeNotifier{
  TextEditingController searchBar=TextEditingController();
  String searchType="Name";
  String searchparamm="";
  String mode="Add";
  Product p=new Product(0, "",-1, "", "count", 0,0, 0);
  Database_Maneger database=Database_Maneger();

  Future<List<List>> GetSuppliers_Ids()async{
  List<Map<String, Object?>>?f=await  database.Suppliers_Ids();
  List<List> result=[];
  f?.forEach((element) {

    result.add([int.parse(element["Supplier_Id"].toString()),element["Supplier_Name"].toString()]);
  });
    return result ;

  }
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
Widget refresh(){
    if(mode=="Add") return Container();
    else return ElevatedButton(onPressed: (){
      p=new Product(0, "", -1,"", "count", 0,0, 0);
      mode="Add";
      notifyListeners();
    }, child: Text("clear"));
}
Future<void> Add() async {


 await database.AddProduct(p);
 p=new Product(0, "", -1,"", "count", 0,0, 0);
 notifyListeners();
}

  Future<void> Edit() async{
    await database.EditProduct(p);
    p=new Product(0, "", -1,"", "count", 0,0, 0);
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