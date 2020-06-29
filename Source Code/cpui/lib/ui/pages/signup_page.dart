import 'package:cpui/beans/requests/create_user_request.dart';
import 'package:cpui/blocs/user_services/create_user_bloc.dart';
import 'package:cpui/services/user_services.dart';
import 'package:cpui/ui/pages/login_page.dart';
import 'package:cpui/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static const String route = '/sign-up';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  CreateUserBloc _createUserBloc;
  UserServices _userServices = UserServices();

  String _emailId;
  String _name;
  String _registrationPlate;
  String _password;
  String _repeatPassword;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onSaved: (value) => _emailId = value,
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
                    onSaved: (value) => _name = value,
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
                    onSaved: (value) => _registrationPlate = value,
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
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (value) => _password = value,
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
                    onSaved: (value) => _repeatPassword = value,
                  ),
                ),
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: () async {
                      _formKey.currentState.save();

                      var createUserRequest = CreateUserRequest(
                          emailId: _emailId,
                          password: _password,
                          verifiedPassword: _repeatPassword,
                          registrationPlate: _registrationPlate,
                          name: _name);
                      print(createUserRequest);

                      final result =
                          await _userServices.createUser(createUserRequest);
                      if (result != null) {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginPage.route);
                      }
                    },
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
