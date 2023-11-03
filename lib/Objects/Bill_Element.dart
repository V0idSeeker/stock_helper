import 'package:stock_helper/Datamaneger/Database_Maneger.dart';

class Bill_Element{
  Database_Maneger database=new Database_Maneger();
  late int Bill_Element_Id;
  late int Bill_Id;
  late double Bill_Element_Price;
  late double Element_amount;
  Bill_Element(int elem_Id,int bill_Id,double bp,double element_amount){
    this.Bill_Element_Id=elem_Id;
    this.Bill_Id=bill_Id;
    this.Bill_Element_Price=bp;
    this.Element_amount=element_amount;
  }




}