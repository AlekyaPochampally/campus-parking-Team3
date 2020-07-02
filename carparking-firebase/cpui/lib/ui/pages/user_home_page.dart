
import 'package:cpui/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cpui/ui/pages/login_page.dart';


class UserHomePage extends StatefulWidget {
  static const String route = '/user-home';

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(),
        body: SafeArea(
            child: Form(
              //  key: _formKey,
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
                              'Home page\n\n',
                              style: TextStyle(fontSize: 20),
                            )
                        ),
                        Container(
                          child: Column(
                            children: [
                              RaisedButton(
                                color:Colors.blueGrey,
                                onPressed: () async {
                                  Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                                },
                                child: Text('Parking lot 1'),
                              ),
                              RaisedButton(
                                color:Colors.blueGrey,
                                onPressed: () async {
                                  Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                                },
                                child: Text('Parking lot 2'),
                              ),
                              RaisedButton(
                                color:Colors.blueGrey,
                                onPressed: () async {
                                  Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                                },
                                child: Text('Parking lot 3'),
                              ),
                              RaisedButton(
                                color:Colors.blueGrey,
                                onPressed: () async {
                                  Navigator.of(context).pushReplacementNamed(UserHomePage.route);
                                },
                                child: Text('Parking lot 4'),
                              ),

                              RaisedButton(
                                padding: EdgeInsets.all(15),
                                onPressed: () async {
                                  var sharedPreference = await SharedPreferences.getInstance();
                                  sharedPreference.remove('cp_token');
                                  Navigator.of(context).pushReplacementNamed(LoginPage.route);
                                },
                                child: Text('User Profile'),
                              ),
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
                        )
                      ],
                    )
                )
            )
        ));
  }
}



// class _UserHomePageState extends State<UserHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Text('User Home sample'),
//           RaisedButton(
//             onPressed: () async {
//               var sharedPreference = await SharedPreferences.getInstance();
//               sharedPreference.remove('cp_token');
//               Navigator.of(context).pushReplacementNamed(LoginPage.route);
//             },
//             child: Text('Logout'),
//           )
//         ],
//       ),
//     );
//   }
// }
