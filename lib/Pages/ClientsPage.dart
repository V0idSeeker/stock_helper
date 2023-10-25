import 'package:flutter/material.dart';
import 'package:stock_helper/Datamaneger/Database_Maneger.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Database_Maneger db=Database_Maneger();
    return  Container(
      alignment: Alignment.topCenter,
      child: Text("client page"),
    );
  }
}

