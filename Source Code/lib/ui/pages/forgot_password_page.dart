import 'package:carparking/ui/pages/change_password.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String route = '/forgot-password';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
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
      appBar: AppBar(title: Text('Campus Parking')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Forgot Password',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Please provide your id and click on Send to get reset code on your registered device. Provide your code and hit Verify Code button after which you will be able to update your password',
                ),
              ),

              SizedBox(height: 25),

              // Username
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                  ),
                ),
              ),

              // Send Code button
              Container(
                height: 55,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  onPressed: () => {},
                  child: Text(
                    'Send Code',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              SizedBox(height: 25),

              // Provide Code
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Code',
                  ),
                ),
              ),

              // Verify Code button
              Container(
                height: 55,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  onPressed: () => Navigator.of(context).pushNamed(ChangePasswordPage.route),
                  child: Text(
                    'Verify Code',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
