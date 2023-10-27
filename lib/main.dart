// ignore_for_file: prefer_const_constructors

// ignore_for_file: prefer_const_constructors

// ignore_for_file: prefer_const_constructors

// ignore_for_file: prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:stock_helper/MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder>{
          "/": (context) => MainPage(),
          "Go": (context) => MainPage(),
        });
  }
}

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,//removes back button
      ),

      body: Center(
        child: Column(
            children: [
              Icon(Icons.ac_unit),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Username',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, "Go");
                },
                child: Text("go"),
              ),
            ],
          ),
        ),

    );
  }
}
