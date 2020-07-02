import 'package:cpui/beans/requests/generate_password_reset_otp_request.dart';
import 'package:cpui/services/user_services.dart';
import 'package:cpui/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'change_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String route = '/forgot-password';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  UserServices _userServices = UserServices();

  String _email;
  String _otp;

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
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ID',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Provide an email id';
                      }
                      _formKey.currentState.save();
                      return null;
                    },
                    onSaved: (value) => _email = value,
                  ),
                ),

                // Send Code button
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        var request =
                            GeneratePasswordResetOtpRequest(emailId: _email);
                        var response =
                            await _userServices.resetPasswordRequest(request);
                      }
                    },
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
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
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
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ChangePasswordPage.route),
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
      ),
    );
  }
}
