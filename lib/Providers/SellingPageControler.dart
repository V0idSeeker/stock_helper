

import 'package:flutter/cupertino.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';
import 'package:stock_helper/Objects/Bill.dart';
import 'package:stock_helper/Objects/Bill_Element.dart';
import 'package:stock_helper/Objects/Client.dart';
import 'package:stock_helper/Objects/Product.dart';

class SellingPageControler extends ChangeNotifier {
  Database_Maneger database=new Database_Maneger();
  String searched_Category="All Categories";
  bool edeting_mode=true;
  int grid_view_width=5 ,selectedindex=-1;
  List<Bill_Element> current_bill=[];
  List<String> product_names=[];
  TextEditingController edit_controler=new TextEditingController();
  double total=0;
  Bill bill=new Bill(-1,-1,"Client",0,DateTime.now());


  void add_to_bill(Product p) {
    edeting_mode=false;
    if (product_names.contains(p.Product_Name))
      { Bill_Element f=current_bill[product_names.indexOf(p.Product_Name)];
        edit_controler.text="${f.Element_amount+1}";
        current_bill[product_names.indexOf(p.Product_Name)]=new Bill_Element(f.Bill_Element_Id, -1, f.Bill_Element_Price, f.Element_amount+1);

      }
    else{
      double r=1.00;
      current_bill.add(
          new Bill_Element(p.Product_Id, -1, p.Product_Selling_Price, r));
      product_names.add(p.Product_Name);
      edit_controler.text=r.toString();
  }
    selectedindex=product_names.indexOf(p.Product_Name);
    total=0;
    current_bill.forEach((element) {total=total+(element.Element_amount*element.Bill_Element_Price); });
  notifyListeners();
  }

  void Dellete_From_Bill(int index){
    total=total-(current_bill[index].Bill_Element_Price*current_bill[index].Element_amount);
    current_bill.removeAt(index);
    product_names.removeAt(index);
    if(index==selectedindex){
      edit_controler.text="";
      edeting_mode=true;
    }
    notifyListeners();
  }

  void Edeting(int index){

    edeting_mode=false;
    selectedindex=index;
    edit_controler.text=current_bill[index].Element_amount.toString();

    notifyListeners();
  }
  void EdetAmount() {
    current_bill[selectedindex].Element_amount=double.parse(edit_controler.text);
  total=0;
  current_bill.forEach((element) {total=total+(element.Element_amount*element.Bill_Element_Price); });
  notifyListeners();
  }
  Future<List> get_Categories()async{
    return await database.Categories();
  }
  Future<List<Client>> get_ClientList()async{
    return await database.Clientslist("", "");
  }
  Future<List<Product>>ProductsList()async{
    if(searched_Category=="All Categories")
    return await database.Productslist("", "");
    return await database.Productslist("Category", searched_Category);
  }



}
