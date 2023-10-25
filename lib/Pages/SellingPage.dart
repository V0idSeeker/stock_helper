import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Selling extends StatelessWidget {
  const Selling({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Selling"),
        Row(                    //all
          children: [
            Column(            //left side
              children: [
                Container(), //searchbar
                Row(
                  children: [
                    Container(), //categories,
                    Container() //items

                  ],

                )
              ],
            ),
          Container() //Factures
          ],
        )
      ],
    )
    ;
  }
}
