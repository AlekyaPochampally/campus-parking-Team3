import 'package:flutter/material.dart';
import 'package:testing/ui/widgets/app_bar.dart';

import 'login_page.dart';
import 'package:testing/services/auth.dart';
import 'package:testing/shared/loading.dart';

class SignUpPage extends StatefulWidget {
  static const String route = '/sign-up';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
//  CreateUserBloc _createUserBloc;
  // UserServices _userServices = UserServices();

  String _emailId;
  String _name;
  String _registrationPlate;
  String _password;
  String _repeatPassword;

  String error = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      appBar: ApplicationBar(),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Create an account',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Id',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email Id cannot be empty';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onChanged: (value) {
                      setState(() => _emailId = value);
                    },
                    // onSaved: (value) => _emailId = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onChanged: (value) {
                      setState(() => _name = value);
                    },
                    //onSaved: (value) => _name = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Registration Plate',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Registration cannot be empty';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onChanged: (value) {
                      setState(() => _registrationPlate = value);
                    },
                    //onSaved: (value) => _registrationPlate = value,
                  ),
                ),
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
                        return 'Password cannot be empty';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onChanged: (value) {
                      setState(() => _password = value);
                    },
                    // onSaved: (value) => _password = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Verify Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      if (value != _password) {
                        return 'Passwords do not match';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onChanged: (value) {
                      setState(() => _repeatPassword = value);
                    },
                    // onSaved: (value) => _repeatPassword = value,
                  ),
                ),
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: () async {
                        if(_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(_emailId, _password);
                          if(result == null){
                            setState(() {
                              error = 'Please provide a vaild email';
                              loading = false;
                            });
                          } 
                          else {                            
                             Navigator.of(context)
                                   .pushReplacementNamed(LoginPage.route);
                          }
                        }
                    },
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                    textAlign: TextAlign.center,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
