import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class Database_Maneger{

  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }
  Future<Database> initDB() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      final appDocumentsDir = await getApplicationDocumentsDirectory();
      final dbPath = [appDocumentsDir.path, "databases", "data.db"].join();
      final winLinuxDB = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: _onCreate,
        ),
      );
      return winLinuxDB;
    } else if (Platform.isAndroid || Platform.isIOS) {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = [documentsDirectory.path, "data.db"].join();
      final iOSAndroidDB = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
      return iOSAndroidDB;
    }
    throw Exception("Unsupported platform");
  }
  Future<void> _onCreate(Database database, int version) async {
    final db = database;
    await db.execute("""  CREATE TABLE IF NOT EXISTS Client(
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
          
               CREATE TABLE IF NOT EXISTS Category(
            Category_Id INTEGER PRIMARY KEY,
            Category_icon TEXT
          );
              
              CREATE TABLE IF NOT EXISTS Product(
            Product_Id INTEGER PRIMARY KEY,
            Category_Id INTEGER REFERENCES Category(Category_Id) ,
            Product_Type TEXT,
            Product_Buying_Price DOUBLE,
            Product_Selling_Price DOUBLE,
            Exp_date DATE  
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
            
          );
          CREATE TABLE IF NOT EXISTS InStock(
            Product_Id INTEGER REFERENCES Product(Product_Id),
            Product_amount INTEGER
          );
          
          
 """);
  }
  Future<String> Products_ids()
  async {
    await _database?.execute("insert into Category(Category_icon) VALUES( dff)");
    List<Map<String, Object?>>? ff=await _database?.rawQuery("Select Category_ID from Category ;");

  }


}

