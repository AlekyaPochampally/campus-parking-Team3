import 'package:carparking/authentication/base_authentication.dart';
import 'package:carparking/ui/pages/forgot_password_page.dart';
import 'package:carparking/ui/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';

  final BaseAuthentication baseAuthentication;

  final VoidCallback loginCallback;

  LoginPage({this.baseAuthentication, this.loginCallback});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
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
                    'Campus Parking',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                // Username
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Id',
                    ),
                    onSaved: (value) => _email = value.trim(),
                  ),
                ),

                // Password
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    onSaved: (value) => _password = value.trim(),
                  ),
                ),

                // Login button
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: () async => {
                      await widget.baseAuthentication.signIn(_email, _password)
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                // Signup information
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(ForgotPasswordPage.route),
                        child: Text('Forgot Password')),
                    FlatButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(SignUpPage.route),
                        child: Text('Sign Up'))
                  ],
                ))
              ],
            ),
          ),
        )));
  }
}
