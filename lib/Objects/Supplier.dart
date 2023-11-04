import 'package:stock_helper/Datamaneger/Global.dart';
class Supplier{
  late int Supplier_Id;
  late String Supplier_Name;
  late int Supplier_PN;
  late double Supplier_Balence;
  Supplier(int id, String nam, int ph ,double b) {
    this.Supplier_Id = id;
    this.Supplier_Name = global.Capitalize(nam);
    this.Supplier_PN = ph;
    this.Supplier_Balence = b;
  }

  double Get_Balence() {
    return this.Supplier_Balence;
  }
  void Add_Balence(double ammount){
    this.Supplier_Balence+=ammount;
  }
  void Sub_Balence(double ammount){
    this.Supplier_Balence-=ammount;
  }

  Supplier.fromMap(Map<String, Object?> map){
    this.Supplier_Id = int.parse(map["Supplier_Id"].toString());
    this.Supplier_Name = global.Capitalize(map["Supplier_Name"].toString());
    this.Supplier_PN = int.parse(map["Supplier_PN"].toString());
    this.Supplier_Balence = double.parse(map["Supplier_Balence"].toString());
  }
  Supplier.formated(Supplier s){
    this.Supplier_Id = s.Supplier_Id;
    this.Supplier_Name = global.Capitalize(s.Supplier_Name);
    this.Supplier_PN = s.Supplier_PN;
    this.Supplier_Balence = s.Supplier_Balence;
  }
}