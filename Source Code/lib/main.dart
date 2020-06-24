import 'package:carparking/authentication/base_authentication_impl.dart';
import 'package:carparking/ui/pages/change_password.dart';
import 'package:carparking/ui/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';

import 'ui/pages/forgot_password_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/signup_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Campus Parking',
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: SplashScreenPage(authentication: BaseAuthenticationImpl()),
    routes: {
      // Login and signup related
      LoginPage.route: (context) => LoginPage(),
      ForgotPasswordPage.route: (context) => ForgotPasswordPage(),
      SignUpPage.route: (context) => SignUpPage(),
      ChangePasswordPage.route: (context) => ChangePasswordPage(),
    },
  ));
}

   