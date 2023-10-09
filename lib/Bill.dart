class Bill{
  late int Bill_Id;
  late int Owner_Id;
  late String Bill_Type;
  late DateTime Bill_date;
  Bill(int id,int owner,String type,DateTime date){
    this.Bill_Id=id;
    this.Owner_Id=owner;
    this.Bill_Type=type;
    this.Bill_date=date;
  }
  double Total_Price(){
    return 0;
  }

}