class Client {
  late int Client_Id;
  late String Client_Name;
  late int Client_PN;
  late double Clint_Balence;
  Client(int id, String nam, int ph) {
    this.Client_Id = id;
    this.Client_Name = nam;
    this.Client_PN = ph;
    this.Clint_Balence = 0;
  }
  void Update_info(String name, int pn) {
    this.Client_Name = name;
    this.Client_PN = pn;
  }

  double Get_Balence() {
    return this.Clint_Balence;
  }
  void Add_Balence(double ammount){
    this.Clint_Balence+=ammount;
  }
  void Sub_Balence(double ammount){
    this.Clint_Balence-=ammount;
  }
}
