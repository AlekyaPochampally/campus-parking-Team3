import 'package:campusparking/ui/pages/Faq_page.dart';
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
import 'package:campusparking/ui/pages/violationPage.dart';
import 'package:toast/toast.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class UserHomePage extends StatefulWidget {
  static const String route = '/user-home';
  static String Lot_name;
  static int available = 00;
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

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) loggedInUser = user;
      print(loggedInUser.email);
    } catch (e) {
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
                                UserHomePage.Lot_name = 'PA1';
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
                                UserHomePage.Lot_name = 'PA2';
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
                                UserHomePage.Lot_name = 'PA3';
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
                                UserHomePage.Lot_name = 'PA4';
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Colors.black54,
                    Colors.blueGrey[500]
                  ])),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          child: Image.asset(
                            'assets/images/nwm_logo.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0.01),
                          child: Text(
                            'Northwest missouri state univeristy',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        )
                      ],
                    ),
                  )),
              CustomeListTile(Icons.person, 'Profile',
                  () => {Navigator.of(context).pushNamed(profilePage.route)}),
              CustomeListTile(Icons.map, 'Map',
                  () => {Navigator.of(context).pushNamed(mapPage.route)}), //mapPage
              CustomeListTile(Icons.report, 'Report',
                  () => {Navigator.of(context).pushNamed(reportPage.route)}),
              CustomeListTile(Icons.question_answer, 'FAQ', 
                  () => {Navigator.of(context).pushNamed(FaQPage.route)}),
              CustomeListTile(Icons.chat, 'Live Chat',
                  () => {Navigator.of(context).pushNamed(ChatScreen.route)}),
              CustomeListTile(Icons.phone, 'Contact',
                  () => {Navigator.of(context).pushNamed(ContactUs.route)}),
              CustomeListTile(Icons.gavel, 'Ticket',
                  () => {Navigator.of(context).pushNamed(ticket.route)}), //Navigator.of(context).pushNamed(ticket.route)
              // CustomeListTile(Icons.report, 'Violation', () => {Navigator.of(context).pushNamed(ViolationPage.route)}),
              CustomeListTile(Icons.lock, 'Logout', () async {
                final user = await _auth.signOut();
                Navigator.of(context).pushNamed(LoginPage.route);
                Toast.show("LoggedOut Successful", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
              }),
              // () => {Navigator.of(context).pushNamed(LoginPage.route)}),

//              onPressed: () async {
//                try {
//                  print(_email);
//                  print(_password);
//                  final user = await _auth.signInWithEmailAndPassword(
//                      email: _email, password: _password);
//                  if (user != null)
//                    Navigator.pushNamed(context,UserHomePage.route);
//                } catch (e) {
//                  print(e);
//                }
//              }
            ],
          ),
        ));
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
