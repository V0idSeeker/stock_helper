import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_helper/Pages/ClientsPage.dart';
import 'package:stock_helper/Pages/Parts/ProductManeger/ProductForm.dart';
import 'package:stock_helper/Pages/SellingPage.dart';
import 'package:stock_helper/Pages/StockPage.dart';

class InterfaceControler extends ChangeNotifier {
  Widget main_screan = Selling();

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
    }
    notifyListeners();
  }
}
