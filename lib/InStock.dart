class InStock{
  late int Product_Id;
  late double Product_Amount;
  InStock(int id , double amount){
    this.Product_Id=id;
    this.Product_Amount=amount;
  }
  double Get_Amount(){return this.Product_Amount;}
}