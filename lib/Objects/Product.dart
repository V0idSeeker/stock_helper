// ignore_for_file: non_constant_identifier_names
import 'package:stock_helper/Datamaneger/Global.dart';
class Product{
late int Product_Id;
late String Product_Name;
late int Supplier_Id;
late String Category;
late String Product_Type;
late double Product_amount;
late double Product_Buying_Price;
late double Product_Selling_Price;



 Product(int p_Id,String p_nam,int s_id,String category,String p_Type,double amount,double p_b_p,double p_s_p) {
  this.Product_Id=p_Id;
  this.Product_Name=global.Capitalize(p_nam);
  this.Supplier_Id=s_id;
  this.Category=global.Capitalize(category);
  this.Product_Type=global.Capitalize(p_Type);
  this.Product_amount=amount;
  this.Product_Buying_Price=p_b_p;
  this.Product_Selling_Price=p_s_p;

}


Product.fromMap(Map<String, Object?> map){
  Product_Id=int.parse(map["Product_Id"].toString());
  Product_Name=global.Capitalize(map["Product_Name"].toString());
  Supplier_Id=int.parse(map["Supplier_Id"].toString());
  Category=global.Capitalize(map["Category"].toString());
  Product_Type=global.Capitalize(map["Product_Type"].toString());
  Product_amount=double.parse(map["Product_amount"].toString());
  Product_Buying_Price=double.parse(map["Product_Buying_Price"].toString());
  Product_Selling_Price=double.parse(map["Product_Selling_Price"].toString());
}
Product.formated(Product p){
  Product_Id=p.Product_Id;
  Product_Name=global.Capitalize(p.Product_Name);
  Supplier_Id=p.Supplier_Id;
  Category=global.Capitalize(p.Category);
  Product_Type=global.Capitalize(p.Product_Type);
  Product_amount=p.Product_amount;
  Product_Buying_Price=p.Product_Buying_Price;
  Product_Selling_Price=p.Product_Selling_Price;
}

}
