import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  // This widget is the root of your application.
  @override
    Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Campus Parking',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar:AppBar(title: Text("Campus Parking")),
        body: SafeArea(
            child: Form(
         
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Campus Parking',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Logout',
                    