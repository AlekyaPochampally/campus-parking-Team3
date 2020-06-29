import 'package:carparking/authentication/base_authentication.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {

  final String userId;
  final BaseAuthentication basicAuthentication;
  final VoidCallback logoutCallback;
  
  UserHomePage({this.userId, this.basicAuthentication, this.logoutCallback});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}