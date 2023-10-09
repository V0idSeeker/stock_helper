class Product{
late int Product_Id;
late int Category_Id;
late String Product_Name;
late String Product_Type;
late double Product_Buying_Price;
late double Product_Selling_Price;
DateTime? Exp_date;

 Product(int p_Id,int c_Id,String p_nam,String p_Type,double p_b_p,double p_s_p,DateTime exp) {
  this.Product_Id=p_Id;
  this.Category_Id=c_Id;
  this.Product_Name=p_nam;
  this.Product_Type=p_Type;
  this.Product_Buying_Price=p_b_p;
  this.Product_Selling_Price=p_s_p;
  this.Exp_date=exp;
}
void Update_name(String n){this.Product_Name=n;}
void Update_Selling_Price(double s){this.Product_Selling_Price=s;}
void Update_Buying_Price(double b){this.Product_Buying_Price=b;}


}
