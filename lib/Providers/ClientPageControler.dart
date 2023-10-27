import 'package:flutter/material.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';
import 'package:stock_helper/Objects/Client.dart';

class ClientPageControler extends ChangeNotifier {
  TextEditingController searchBar=TextEditingController();
  Database_Maneger database=Database_Maneger();
  String searchType="Name";
  String searchparamm="";
  Client c=new Client(0,"",00000000,0);
  String mode="Add";


  Future<void> Add() async {


    await database.AddClient(c);
    c=new Client(0,"",00000000,0);
    notifyListeners();
  }

  Future<void> Edit() async{
    await database.EditClient(c);
    c=new Client(0,"",00000000,0);
    mode="Add";
    notifyListeners();

  }

  void SelectToEdit(Client f){
    c=f;
    mode="Edit";
    notifyListeners();
  }



  Future<void> Delete(Client f)async{
    await database.DeleteClient(f);
    notifyListeners();
  }


}