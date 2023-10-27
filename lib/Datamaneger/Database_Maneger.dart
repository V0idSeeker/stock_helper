

import 'dart:ffi';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stock_helper/Objects/Client.dart';

import 'package:stock_helper/Objects/Product.dart';


class Database_Maneger{

 static  Database? _database ;


  Future<Database?> get database async {


    if (_database != null) {

      return _database!;
    }else {
     print("dfdfffffffffff");
      _database = await initDB();
      return _database!;
    }
    }
  Future<Database> initDB() async {

      sqfliteFfiInit();

      final databaseFactory = databaseFactoryFfi;
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      final dbPath = [appDocumentsDir.path, "data.db"].join();
      print(dbPath);
      final winLinuxDB = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: _onCreate,
        ),
      );
      return winLinuxDB;

    }


  Future<void> _onCreate(Database database, int version) async {
    final db = database;
    await db.execute("""  CREATE TABLE IF NOT EXISTS "Product"(
            Product_Id INTEGER PRIMARY KEY NOT NULL  ,
            Product_Name TEXT ,
            Category TEXT ,
            Product_amount DOUBLE,
            Product_Type TEXT,
            Product_Buying_Price DOUBLE,
            Product_Selling_Price DOUBLE
             
          );
         
          

     CREATE TABLE IF NOT EXISTS "Client"(
            Client_Id INTEGER PRIMARY KEY NOT NULL,
            Client_Name TEXT,
            Client_PN INTEGER,
            Client_Balence DOUBLE
          );
          """);
          /*
           CREATE TABLE IF NOT EXISTS Supplier(
            Supplier_Id INTEGER PRIMARY KEY,
            Supplier_Name TEXT,
            Supplier_PN INTEGER,
            Supplier_Balence INTEGER 
          );
          
         
              

          CREATE TABLE IF NOT EXISTS Bill(
            Bill_Id INTEGER PRIMARY KEY,
            Owner_Id INTEGER  ,
            Owner_Type TEXT ,
            Bill_date DATE  
          );
          CREATE TABLE IF NOT EXISTS Bill_Element(
            Bill_Element_Id INTEGER REFERENCES Product(Product_Id),
            Bill_Id INTEGER REFERENCES Bill(Bill_Id),
            Element_amount INTEGER
            """);*/
  }

 //product functions
  Future<void> AddProduct(Product p) async {
    await database;
   await _database?.rawInsert("""insert into Product (Product_name,Category,Product_amount,Product_Type,Product_Buying_Price,Product_Selling_Price)
    Values('${p.Product_Name}','${p.Category}','${p.Product_amount}','${p.Product_Type}','${p.Product_Buying_Price}','${p.Product_Selling_Price}');
    """);
   print(" Product saved");
  }
 Future<List<Product>> Productslist(String filter,String value)async{
   await database;
   List<Map<String, Object?>>? result;
   if(filter=="" ||value =="")
     result=await _database?.rawQuery('SELECT * from Product ');
   else  result=await _database?.rawQuery('SELECT * from Product where ${filter} LIKE "%${value}%"');
   List<Product> results=[];
   for(Map<String,Object?> m in result!){
     results.add(Product.fromMap(m));

   }
   return results;

 }
 Future<void> EditProduct(Product p) async {
   await database;
   await _database?.rawUpdate("""Update Product Set Product_name= '${p.Product_Name}' ,Category= '${p.Category}' ,Product_amount= '${p.Product_amount}' ,
     Product_Type= '${p.Product_Type}' ,Product_Buying_Price= '${p.Product_Buying_Price}' ,Product_Selling_Price='${p.Product_Selling_Price}'
     where Product_Id= '${p.Product_Id}';
    """);
   print(" Product saved");
 }
 Future<void> DeleteProduct(Product p)async{
    await database;
    await _database?.rawDelete("Delete from Product where Product_Id= '${p.Product_Id}' ;");

 }

 //Clients functions

 Future<void> AddClient(Client c) async {
   await database;
   await _database?.rawInsert("""insert into Client (Client_Name ,Client_PN,Client_Balence)
    Values('${c.Client_Name}','${c.Client_PN}','${c.Client_PN}');
    """);
   print(" Client saved");
 }
 Future<List<Client>> Clientslist(String filter,String value)async{
   await database;
   List<Map<String, Object?>>? result;
   if(filter=="" ||value =="")
     result=await _database?.rawQuery('SELECT * from Client ');
   else  result=await _database?.rawQuery('SELECT * from Client where ${filter} LIKE "%${value}%"');
   List<Client> results=[];
   for(Map<String,Object?> m in result!){
     results.add(Client.fromMap(m));

   }
   return results;

 }
 Future<void> EditClient(Client c) async {
   await database;
   await _database?.rawUpdate("""Update Client Set Client_Name= '${c.Client_Name}' ,Client_PN= '${c.Client_PN}' ,Client_Balence= '${c.Clint_Balence}' 
     where Client_Id= '${c.Client_Id}';
    """);
   print("Client saved");
 }
 Future<void> DeleteClient(Client c)async{
   await database;
   await _database?.rawDelete("Delete from Client where Client_Id= '${c.Client_Id}' ;");

 }

}

