import 'package:campusparking/ui/pages/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:campusparking/ui/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'login_page.dart';

final _firestore = Firestore.instance;

class SignUpPage extends StatefulWidget {
  static const String route = '/sign-up';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  String _emailId, type;
  int wheels;
  String _name;
  String _registrationPlate;
  String _password;
  String _repeatPassword;
  bool dAbled;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar(),
      body: Form(
        //key: _formKey,
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
                        //
                      ),
                      onChanged: (value) {
                        _emailId = value;
                      }
//
                      ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      onChanged: (value) {
                        _name = value;
                      }),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Registration Plate',
                      ),
                      onChanged: (value) {
                        _registrationPlate = value;
                      }),
                ),
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
                      }
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Password cannot be empty';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be at least 6 characters';
//                       }
//                       _formKey.currentState.save();
//                       return null;
//                     },
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
                      onChanged: (value) {
                        _repeatPassword = value;
                      }
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return 'This field cannot be empty';
                      //   }
                      //   if (value != _password) {
                      //     return 'Passwords do not match';
                      //   }
                      //   _formKey.currentState.save();
                      //   return null;
                      // },
                      // onSaved: (value) => _repeatPassword = value,
                      ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Vehicle Type',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ToggleSwitch(
                        minWidth: 90.0,
                        cornerRadius: 20.0,
                        initialLabelIndex: 1,
                        activeBgColor: Colors.cyan,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        labels: ['2', '4'],
                        icons: [Icons.directions_bike, Icons.directions_car],
                        onToggle: (index) {
                          print('switched to: $index');
                          if (index == 0) //dAbled
                            wheels = 2;
                          else
                            wheels = 4;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Differently Abled',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ToggleSwitch(
                        minWidth: 90.0,
                        cornerRadius: 20.0,
                        initialLabelIndex: 1,
                        activeBgColor: Colors.cyan,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        labels: ['yes', 'No'],
                        icons: [Icons.check, Icons.close],
                        onToggle: (index) {
                          print('switched to: $index');
                          if (index == 0) //dAbled
                            dAbled = true;
                          else
                            dAbled = false;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ToggleSwitch(
                        minWidth: 120.0,
                        cornerRadius: 20.0,
                        activeBgColor: Colors.cyan,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        labels: ['Student', 'Faculty'],
                        icons: [Icons.group, Icons.person],
                        onToggle: (index) {
                          print('switched to: $index');
                          if (index == 0) //dAbled
                            type = 'Student';
                          else
                            type = 'Faculty';
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: () async {
                      print(_emailId);
                      print(_password);
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: _emailId, password: _password);
                        if (newUser != null) {

                          _firestore.collection('User').add({
                            'User_ID': _emailId,
                            'User_Name': _name,
                            'Registration_ID': _registrationPlate,
                            'Num_Tickets': 0,
                            'Differently_Abled': dAbled,
                            'Charge': 0,
                            'Bonus': 0,
                            'User_Type': type,
                          }); // updated users table

                          _firestore.collection('Vehicle').add({

                          'Registration_Number': _registrationPlate,
                          'Vehicle_Type':wheels,
                          });
                          Navigator.pushNamed(context, UserHomePage.route);
                        }
                      } catch (e) {
                        print(e);
                      }
                      // _formKey.currentState.save();

                      // var createUserRequest = CreateUserRequest(
                      //     emailId: _emailId,
                      //     password: _password,
                      //     verifiedPassword: _repeatPassword,
                      //     registrationPlate: _registrationPlate,
                      //     name: _name);
                      // print(createUserRequest);

                      // final result =
                      //     await _userServices.createUser(createUserRequest);
                      // if (result != null) {
                      // Navigator.of(context)
                      //  .pushReplacementNamed(LoginPage.route);
                    },
                    //},
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
