import 'package:carparking/authentication/base_authentication.dart';
import 'package:carparking/ui/pages/forgot_password_page.dart';
import 'package:carparking/ui/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/logout';

  final BaseAuthentication baseAuthentication;

  final VoidCallback logoutCallback;

  LoginPage({this.baseAuthentication, this.logoutCallback});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LogoutPageState extends State<LogoutPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  AnimationController _controller;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Campus Parking")),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                
                // Logout button
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: () async => {
                      await widget.baseAuthentication.signIn(_email, _password)
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
        )
        )
        );
  }
}
