import 'package:cpui/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomePage extends StatefulWidget {
  static const String route = '/user-home';

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('User Home sample'),
          RaisedButton(
            onPressed: () async {
              var sharedPreference = await SharedPreferences.getInstance();
              sharedPreference.remove('cp_token');
              Navigator.of(context).pushReplacementNamed(LoginPage.route);
            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}
