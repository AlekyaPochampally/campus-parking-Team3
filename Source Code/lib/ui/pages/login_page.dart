
import 'package:flutter/material.dart';
import 'package:campusparking/ui/pages/signup_page.dart';
import 'package:campusparking/ui/pages/user_home_page.dart';
import 'package:campusparking/ui/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campusparking/ui/pages/Faq_page.dart';
import 'package:toast/toast.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage> {

  final _auth = FirebaseAuth.instance;

  String _email;
  String _password;

//  @override
//  void initState() {
//    super.initState();
//  }
final _formKey = GlobalKey<FormState>();

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
                    onChanged: (value) {
                      _email = value;
                    },
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
                    onChanged: (value) {
                      _password = value;
                    },
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
                  child: Column(
                    children: [
                      RaisedButton(
                        onPressed: () async {
                         
                          if (_formKey.currentState.validate()) {
                            try {
                            print(_email);
                            print(_password);
                            final user = await _auth.signInWithEmailAndPassword(
                                email: _email, password: _password);
                            Toast.show("LoggedIn Successful", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);    
                            if (user != null)
                              Navigator.pushNamed(context,UserHomePage.route);
                              
                          } catch (e) {
                            print(e);
                          }
                          }
                          // try {
                          //   print(_email);
                          //   print(_password);
                          //   final user = await _auth.signInWithEmailAndPassword(
                          //       email: _email, password: _password);
                          //   if (user != null)
                          //     Navigator.pushNamed(context,UserHomePage.route);
                          // } catch (e) {
                          //   print(e);
                          // }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
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
                        child: Text('Sign Up')
                        ),
                    FlatButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(FaQPage.route),
                        child: Text('FAQ'))
                  ],
                ))

              ],
            ),
          ),
        )));
  }
}
