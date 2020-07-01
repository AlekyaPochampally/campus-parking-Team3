// import 'dart:js';

import 'package:cpui/ui/pages/change_password_page.dart';
import 'package:cpui/ui/pages/user_home_page.dart';
import 'package:cpui/ui/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/pages/forgot_password_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/signup_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  var sharedPreference = await SharedPreferences.getInstance();
  String token = sharedPreference.getString('cp_token');

  runApp(MaterialApp(
    title: 'Campus Parking',
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: token == null ? LoginPage() : UserHomePage(),
    routes: {
      // Login and signup related
      LoginPage.route: (context) => LoginPage(),
      ForgotPasswordPage.route: (context) => ForgotPasswordPage(),
      SignUpPage.route: (context) => SignUpPage(),
      ChangePasswordPage.route: (context) => ChangePasswordPage(),
      UserHomePage.route: (context) => UserHomePage()
    },
  ));
}
