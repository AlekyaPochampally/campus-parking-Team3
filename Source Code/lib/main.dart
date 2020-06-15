import 'package:carparking/ui/pages/login/login.dart';
import 'package:carparking/ui/pages/reserve/reserve.dart';
import 'package:flutter/material.dart';

import 'ui/pages/login/login.dart';

void main() {
  runApp(StartApplication());
}

class StartApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Car Parking")),
        body: LoginPage()        //Reserve()
      ),
    );
  }
}


