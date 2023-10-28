class Supplier{
  late int Supplier_Id;
  late String Supplier_Name;
  late int Supplier_PN;
  late double Supplier_Balence;
  Supplier(int id, String nam, int ph ,double b) {
    this.Supplier_Id = id;
    this.Supplier_Name = nam;
    this.Supplier_PN = ph;
    this.Supplier_Balence = b;
  }
  void Update_info(String name, int pn) {
    this.Supplier_Name = name;
    this.Supplier_PN = pn;
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
    this.Supplier_Name = map["Supplier_Name"].toString();
    this.Supplier_PN = int.parse(map["Supplier_PN"].toString());
    this.Supplier_Balence = double.parse(map["Supplier_Balence"].toString());

  }
}