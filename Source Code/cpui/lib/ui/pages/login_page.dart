import 'package:cpui/beans/requests/authenticate_user_request.dart';
import 'package:cpui/services/user_services.dart';
import 'package:cpui/ui/pages/signup_page.dart';
import 'package:cpui/ui/pages/user_home_page.dart';
import 'package:cpui/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  UserServices _userServices = UserServices();

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(),
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Provide an email id';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Provide your password';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                ),

                // Login button
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        var authenticateUserRequest = AuthenticateUserRequest(emailId: _email, password: _password);
                        final result =
                            await _userServices.authenticate(authenticateUserRequest);
                        if (result != null) {
                          var sharedPreference = await SharedPreferences.getInstance();
                          sharedPreference.setString('cp_token', result.token);
                          Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                        }
                      }
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
