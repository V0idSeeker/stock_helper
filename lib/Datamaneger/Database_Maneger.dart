

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
         
          """);

    /* CREATE TABLE IF NOT EXISTS Client(
            Client_Id INTEGER PRIMARY KEY,
            Client_Name TEXT,
            Client_PN INTEGER,
            Client_Balence INTEGER
          );
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
  Future<List<Map>?> Products_Quary(String look_a_like) async {
    List<Map>? ff;
    if(look_a_like=="") {
      ff=await _database?.rawQuery("""
    Select Product_Name,Category,Count(Product_Name)as amount ,Product_Buying_Price,Product_Selling_Price
    From Product 
    Group by Product_Name ; """);
    } else {
      ff=await _database?.rawQuery("""
  Select Product_Name,Category,Count(Product_Name)as amount ,Product_Buying_Price,Product_Selling_Price
    From Product 
    where Product_Name Like %${look_a_like}%
    Group by Product_Name ;""");
    }
    return ff;

  }
  Future<void> AddProduct(Product p) async {
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
    print(result?.length);
     List<Product> results=[];
     for(Map<String,Object?> m in result!){
      results.add(Product.fromMap(m));

     }
     return results;

  }

}

