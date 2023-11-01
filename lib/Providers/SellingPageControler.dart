import 'package:flutter/cupertino.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';
import 'package:stock_helper/Objects/Product.dart';

class SellingPageControler extends ChangeNotifier {
  Database_Maneger database=new Database_Maneger();
  String searched_Category="All Categories";
  int grid_view_width=5;
  Future<List> get_Categories()async{
    return await database.Categories();
  }
  Future<List<Product>>ProductsList()async{
    if(searched_Category=="All Categories")
    return await database.Productslist("", "");
    return await database.Productslist("Category", searched_Category);
  }


}