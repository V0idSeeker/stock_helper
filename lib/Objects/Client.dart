import 'package:stock_helper/Datamaneger/Global.dart';
class Client {
  late int Client_Id;
  late String Client_Name;
  late int Client_PN;
  late double Client_Balence;
  Client(int id, String nam, int ph,double b) {
    this.Client_Id = id;
    this.Client_Name = global.Capitalize(nam);
    this.Client_PN = ph;
    this.Client_Balence = b;
  }



  double Get_Balence() {
    return this.Client_Balence;
  }
  void Add_Balence(double ammount){
    this.Client_Balence+=ammount;
  }
  void Sub_Balence(double ammount){
    this.Client_Balence-=ammount;
  }
  Client.fromMap(Map<String, Object?> map){
    this.Client_Id = int.parse(map["Client_Id"].toString());
    this.Client_Name = global.Capitalize(map["Client_Name"].toString());
    this.Client_PN = int.parse(map["Client_PN"].toString());
    this.Client_Balence = double.parse(map["Client_Balence"].toString());
  }


  Client.formated(Client c)
  {
    this.Client_Id = c.Client_Id;
    this.Client_Name = global.Capitalize(c.Client_Name);
    this.Client_PN = c.Client_PN;
    this.Client_Balence = c.Client_Balence;
  }
  }


