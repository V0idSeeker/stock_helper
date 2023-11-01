// ignore_for_file: non_constant_identifier_names

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
  this.Product_Name=p_nam;
  this.Supplier_Id=s_id;
  this.Category=category;
  this.Product_Type=p_Type;
  this.Product_amount=amount;
  this.Product_Buying_Price=p_b_p;
  this.Product_Selling_Price=p_s_p;

}
void Update_name(String n){this.Product_Name=n;}
void Update_Selling_Price(double s){this.Product_Selling_Price=s;}
void Update_Buying_Price(double b){this.Product_Buying_Price=b;}

Product.fromMap(Map<String, Object?> map){
  Product_Id=int.parse(map["Product_Id"].toString());
  Product_Name=map["Product_Name"].toString();
  Supplier_Id=int.parse(map["Supplier_Id"].toString());
  Category=map["Category"].toString();
  Product_Type=map["Product_Type"].toString();
  Product_amount=double.parse(map["Product_amount"].toString());
  Product_Buying_Price=double.parse(map["Product_Buying_Price"].toString());
  Product_Selling_Price=double.parse(map["Product_Selling_Price"].toString());
}

}
