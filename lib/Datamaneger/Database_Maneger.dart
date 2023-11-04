


import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stock_helper/Objects/Bill_Element.dart';
import 'package:stock_helper/Objects/Client.dart';

import 'package:stock_helper/Objects/Product.dart';
import 'package:stock_helper/Objects/Supplier.dart';


class Database_Maneger{

 static  Database? _database ;


  Future<Database?> get database async {


    if (_database == null) {
     print("dfdfffffffffff");
      _database = await initDB();

    }
    return _database!;
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
            Supplier_Id INTEGER , 
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
          
          
           CREATE TABLE IF NOT EXISTS "Supplier"(
            Supplier_Id INTEGER PRIMARY KEY NOT NULL,
            Supplier_Name TEXT,
            Supplier_PN INTEGER,
            Supplier_Balence DOUBLE
          );
          
         
         

          CREATE TABLE IF NOT EXISTS "Bill"(
            Bill_Id INTEGER PRIMARY KEY NOT NULL,
            Owner_Id INTEGER  ,
            Owner_Type TEXT ,
            Bill_Total DOUBLE,
            Bill_date DATE 
          );
          
          CREATE TABLE IF NOT EXISTS "Bill_Element"(
            Bill_Element_Id INTEGER ,
            Bill_Id INTEGER ,
            Bill_Element_Price DOUBLE,
            Element_amount DOUBLE
            );
            
            CREATE TABLE IF NOT EXISTS "Settings"(
            User_Name TEXT,
            User_Password TEXT,
            Is_Active BOOL,
            Remember_User BOOL,
            End_Trial DATE
            );
             
            
            """);



            await db.rawInsert("""insert into "Settings" 
            Values ('admin', 'admin', 0, 0, date('now', '+2 months'))
            """);
  }

 //product functions
 Future<void> AddProduct(Product p) async {
    await database;
    p=Product.formated(p);
   await _database?.rawInsert("""insert into Product (Product_name,Supplier_Id,Category,Product_amount,Product_Type,Product_Buying_Price,Product_Selling_Price)
    Values('${p.Product_Name}','${p.Supplier_Id}','${p.Category}','${p.Product_amount}','${p.Product_Type}','${p.Product_Buying_Price}','${p.Product_Selling_Price}');
    """);
   print(" Product saved");
  }

  Future<List<Product>> Productslist(String filter,String value)async{
   await database;
   List<Map<String, Object?>>? result;
   if(filter=="" ||value =="")
     result=await _database?.rawQuery('SELECT * from Product ORDER BY Product_Name');
   else  result=await _database?.rawQuery('SELECT * from Product where ${filter} LIKE "%${value}%" ORDER BY Product_Name');
   List<Product> results=[];
   for(Map<String,Object?> m in result!){
     results.add(Product.fromMap(m));

   }
   return results;

 }

 Future<List> Categories()async{
    await database;
    List r=["All Categories"];
    List<Map<String, Object?>>? result= await _database?.rawQuery('Select DISTINCT Category from Product ORDER BY Category');
    result?.forEach((element) {
      r.add(element["Category"].toString());
    });
    return r;
 }


 Future<void> EditProduct(Product p) async {
   await database;
   p=Product.formated(p);
   await _database?.rawUpdate("""Update Product Set Product_name= '${p.Product_Name}' ,Supplier_Id='${p.Supplier_Id}',Category= '${p.Category}' ,Product_amount= '${p.Product_amount}' ,
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
   c=Client.formated(c);
   await _database?.rawInsert("""insert into Client (Client_Name ,Client_PN,Client_Balence)
    Values('${c.Client_Name}','${c.Client_PN}','${c.Client_PN}');
    """);
   print(" Client saved");
 }

 Future<List<Client>> Clientslist(String filter,String value)async{
   await database;
   List<Map<String, Object?>>? result;
   if(filter=="" ||value =="")
     result=await _database?.rawQuery('SELECT * from Client ORDER BY Client_Name');
   else  result=await _database?.rawQuery('SELECT * from Client where ${filter} LIKE "%${value}%" ORDER BY Client_Name');
   List<Client> results=[];
   for(Map<String,Object?> m in result!){
     results.add(Client.fromMap(m));

   }
   return results;

 }


 Future<void> EditClient(Client c) async {
   await database;
   c=Client.formated(c);
   await _database?.rawUpdate("""Update Client Set Client_Name= '${c.Client_Name}' ,Client_PN= '${c.Client_PN}' ,Client_Balence= '${c.Client_Balence}' 
     where Client_Id= '${c.Client_Id}';
    """);
   print("Client saved");
 }

 Future<void> DeleteClient(Client c)async{
   await database;
   await _database?.rawDelete("Delete from Client where Client_Id= '${c.Client_Id}' ;");

 }

 //Supplier Functions

 Future<void> AddSupplier(Supplier c) async {
   await database;
   c=Supplier.formated(c);
   await _database?.rawInsert("""insert into Supplier (Supplier_Name ,Supplier_PN,Supplier_Balence)
    Values('${c.Supplier_Name}','${c.Supplier_PN}','${c.Supplier_Balence}');
    """);
   print(" Supplier saved");
 }

 Future<List<Supplier>> Supplierslist(String filter,String value)async{
   await database;
   List<Map<String, Object?>>? result;
   if(filter=="" ||value =="")
     result=await _database?.rawQuery('SELECT * from Supplier ORDER BY Supplier_Name ');
   else  result=await _database?.rawQuery('SELECT * from Supplier where ${filter} LIKE "%${value}%" ORDER BY Supplier_Name');
   List<Supplier> results=[];
   for(Map<String,Object?> m in result!){
     results.add(Supplier.fromMap(m));

   }
   return results;

 }

 Future<void> EditSupplier(Supplier c) async {
   await database;
   c=Supplier.formated(c);
   await _database?.rawUpdate("""Update Supplier Set Supplier_Name= '${c.Supplier_Name}' ,Supplier_PN= '${c.Supplier_PN}' ,Supplier_Balence= '${c.Supplier_Balence}' 
     where Supplier_Id= '${c.Supplier_Id}';
    """);
   print("Supplier saved");
 }

 Future<void> DeleteSupplier(Supplier c)async{
   await database;
   await _database?.rawDelete("Delete from Supplier where Supplier_Id= '${c.Supplier_Id}' ;");

 }

 Future<List<Map<String, Object?>>?> Suppliers_Ids()async{
   await _database;
   List<Map<String, Object?>>? result =await _database?.rawQuery('Select Supplier_Id,Supplier_Name from Supplier ORDER BY Supplier_Name ');
   return result;

 }
 //Bill stuff

Future<List<Map<String, Object?>>?> GetProductName(int Id) async {
    await _database;
    return await _database?.rawQuery("Select Product_Name from Product where Product_Id='${Id}' Order By Product_Name");

}
Future<void> AddBill(int owner_id,String owner_type,List<Bill_Element> elements ,bool Payed_Now)async{
    double total_value=0;
    elements.forEach((element) {total_value=total_value+(element.Bill_Element_Price*element.Element_amount); });
    int? bill_id=await _database?.rawInsert("insert into Bill (Owner_Id,Owner_Type,Bill_Total,Bill_date) Values ('${owner_id}','${owner_type}',${total_value},${DateTime.now()})");
    String inserter="";
    elements.forEach((element) {
     if(inserter.isEmpty)inserter="('${element.Bill_Element_Id}','${bill_id}','${element.Bill_Element_Price}' ,'${element.Element_amount}')";
       else inserter=inserter+" , ('${element.Bill_Element_Id}','${bill_id}','${element.Bill_Element_Price}' ,'${element.Element_amount}')";
    });
    await _database?.rawInsert("insert into Bill_Element VALUEES ${inserter} ");

}



Future<List<Map<String, Object?>>?> GetBill(String Owner,String type) async{
  await _database;

  if(Owner=="") {
    if (type == "Client")
      return await _database?.rawQuery(
          "Select Client_Name, Bill_Total, Bill_date from Client,Bill where Client_Id=Owner_Id && Owner_Type='Client' order by Client_Name ");
    else
      return await _database?.rawQuery(
          "Select Supplier_Name, Bill_Total, Bill_date from Client,Bill where Client_Id=Owner_Id && Owner_Type='Supplier' order by Supplier_Name ");
  }else{
    if (type == "Client")
      return await _database?.rawQuery(
          "Select Client_Name, Bill_Total, Bill_date from Client,Bill where Client_Id=Owner_Id && Owner_Type='Client' && Client_Name Like '%${Owner}%' order by Client_Name ");
    else
      return await _database?.rawQuery(
          "Select Supplier_Name, Bill_Total, Bill_date from Client,Bill where Client_Id=Owner_Id && Owner_Type='Supplier' && Suppler_Name Like '%${Owner}%' order by Supplier_Name ");

  }




}


}

