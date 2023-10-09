class Bill_Element{
  late int Bill_Element_Id;
  late int Bill_Id;
  late double Element_amount;
  Bill_Element(int elem_Id,int bill_Id,double element_amount){
    this.Bill_Element_Id=bill_Id;
    this.Bill_Id=bill_Id;
    this.Element_amount=element_amount;
  }


}