import 'package:flutter/material.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';

import 'package:stock_helper/Pages/ClientsPage.dart';
import 'package:stock_helper/Pages/History.dart';
import 'package:stock_helper/Pages/SellingPage.dart';
import 'package:stock_helper/Pages/SettingsPage.dart';
import 'package:stock_helper/Pages/StockPage.dart';
import 'package:stock_helper/Pages/SupplierPage.dart';

class InterfaceControler extends ChangeNotifier {
  Widget main_screan = Selling();
 Database_Maneger database= Database_Maneger();
  void ChangeMain(String page) {
    switch (page) {
      case "Selling":
        main_screan = Selling();
        break;
      case "Clients":
        main_screan = ClientPage();
        break;
      case "Stock":
        main_screan = StockPage();
        break;
      case "Supplier":
        main_screan = SupplierPage();
        break;

      case "History":
        main_screan = HistoryPage();
        break;
      case "Settings":
        main_screan = SettingsPage();
        break;
    }

    notifyListeners();
  }
  Future<void> logout()async{
    await database.UpdateSettings("", "", false);

    
  }
}
