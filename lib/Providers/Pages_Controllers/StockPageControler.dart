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
  bool paied=true;

  void changePaiedStatus(bool v){
    paied=v;
    notifyListeners();
  }
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
  if(!paied)
    await database.addSuppllierBalence(p.Supplier_Id, p.Product_Id,p.Product_amount,p.Product_Buying_Price , false);

 await database.AddProduct(p);
 p=new Product(0, "", -1,"", "count", 0,0, 0);
 notifyListeners();
}

  Future<void> Edit() async{

    if(!paied) {

      await database.addSuppllierBalence(p.Supplier_Id, p.Product_Id,p.Product_amount,p.Product_Buying_Price , true);
    }
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