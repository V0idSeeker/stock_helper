import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyTheme extends ChangeNotifier{
  String _style = "LightStyle";
  Color primary=Colors.white;
  Color secondary= Color.fromARGB(200, 23, 78, 166);
  Color tertiary=Color.fromARGB(200,210 ,227 ,252);
  Color alternate=Colors.greenAccent ;
  Color primaryText=Colors.black ;
  Color secondaryText=Colors.black26 ;
  Color primaryBackgrund=Colors.white ;
  Color secondaryBackground=Colors.lightGreen.shade100 ;




  TextStyle bodyMedium =TextStyle(
  );
  TextStyle Headliers =TextStyle(

    fontSize: 19,
    fontWeight: FontWeight.bold,

  );
  TextStyle labelMedium= TextStyle(
    fontSize: 15,
  );
  TextStyle Buttons=TextStyle(
    fontSize: 16,
  );


}



