import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campusparking/ui/pages/profile_page.dart';
import 'package:campusparking/ui/pages/map_page.dart';
import 'package:campusparking/ui/pages/ticket_page.dart';
import 'Parking.dart';
import 'chat_screen.dart';
import 'contact_us_page.dart';
import 'login_page.dart';
import 'package:campusparking/ui/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campusparking/ui/pages/reportPage.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class UserHomePage extends StatefulWidget {

  static const String route = '/user-home';
  static  String Lot_name;
  static int available=00;
  @override
  _UserHomePageState createState() => _UserHomePageState();
}


class _UserHomePageState extends State<UserHomePage> {
  //static  int Lot_ID;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    getCurrentUser();


  }

void getCurrentUser() async{
    try{
      final user = await _auth.currentUser();
      if(user != null)
        loggedInUser = user;
      print(loggedInUser.email);
    }catch(e){
      print(e);
    }
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: ApplicationBar(),
        body: SafeArea(
          child: ListView(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Parking Areas',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'List of parking lots with available number of slots in each parking area',
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            minWidth: 175.0,
                            height: 50.0,
                            child: RaisedButton(
                              splashColor: Colors.grey,
                              color: Colors.blueGrey,
                              onPressed: () async {
                                UserHomePage.Lot_name='PA1';
                                 Navigator.of(context).pushReplacementNamed(Parking.route);
                              },
                              child: Text('Parking lot 1',
                                  style: TextStyle(fontSize: 25.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
//                            child: Text(
//                              count.toString(),
//                              style: TextStyle(
//                                fontSize: 25.0,
//                                fontWeight: FontWeight.bold,
//                              ),
//                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            minWidth: 175.0,
                            height: 50.0,
                            child: RaisedButton(
                              splashColor: Colors.grey,
                              color: Colors.blueGrey,
                              onPressed: () async {
                                UserHomePage.Lot_name='PA2';
                                Navigator.of(context).pushReplacementNamed(Parking.route);
                              },

                              child: Text('Parking lot 2',
                                  style: TextStyle(fontSize: 25.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),

                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            minWidth: 175.0,
                            height: 50.0,
                            child: RaisedButton(
                              splashColor: Colors.grey,
                              color: Colors.blueGrey,
                              onPressed: () async {
                                UserHomePage.Lot_name='PA3';
                                Navigator.of(context).pushReplacementNamed(Parking.route);
                              },
                              child: Text('Parking lot 3',
                                  style: TextStyle(fontSize: 25.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),

                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            minWidth: 175.0,
                            height: 50.0,
                            child: RaisedButton(
                              splashColor: Colors.grey,
                              color: Colors.blueGrey,
                              onPressed: () async {
                                UserHomePage.Lot_name='PA4';
                                Navigator.of(context).pushReplacementNamed(Parking.route);
                              },
                              child: Text('Parking lot 4',
                                  style: TextStyle(fontSize: 25.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),

                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
        ),
        );
  }
}

class CustomeListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;
  CustomeListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: Colors.blueGrey,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text, style: TextStyle(fontSize: 16.0)),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
