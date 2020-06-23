import 'package:carparking/authentication/authentication_status.dart';
import 'package:carparking/authentication/base_authentication.dart';
import 'package:carparking/ui/pages/login_page.dart';
import 'package:carparking/ui/pages/user_homepage.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  final BaseAuthentication authentication;

  SplashScreenPage({this.authentication});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  AuthenticationStatus authenticationStatus =
      AuthenticationStatus.NOT_AUTHENTICATED;
  String _userId = "";

  @override
  void initState() {
    super.initState();

    widget.authentication.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authenticationStatus = user?.uid == null
            ? AuthenticationStatus.NOT_AUTHENTICATED
            : AuthenticationStatus.AUTHENTICATED;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authenticationStatus) {
      case AuthenticationStatus.INDETERMINATE:
        return buildWaitingScreen();
        break;
      case AuthenticationStatus.NOT_AUTHENTICATED:
        return new LoginPage(
          baseAuthentication: widget.authentication,
          loginCallback: loginCallback,
        );
        break;
      case AuthenticationStatus.AUTHENTICATED:
        if (_userId.length > 0 && _userId != null) {
          return new UserHomePage(
            userId: _userId,
            basicAuthentication: widget.authentication,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }

  void loginCallback() {
    widget.authentication.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authenticationStatus = AuthenticationStatus.AUTHENTICATED;
    });
  }

  void logoutCallback() {
    setState(() {
      authenticationStatus = AuthenticationStatus.NOT_AUTHENTICATED;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
