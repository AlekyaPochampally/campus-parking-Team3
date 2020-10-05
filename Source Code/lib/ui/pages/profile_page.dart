import 'package:campusparking/ui/pages/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:campusparking/ui/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser loggedInUser;

final _firestore = Firestore.instance;

class profilePage extends StatefulWidget {
  static const String route = '/profile-page';

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final _auth = FirebaseAuth.instance;
  String registration_num = '', userID = '', user_name = '';
  int num_tickets, vehicle_type;
  @override
  void initState() {
    super.initState();
    getUserDetails();
    getCurrentUser();
    // print(UserHomePage.loggedInUser);
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

  void getUserDetails() async {
    final users = await _firestore.collection('User').getDocuments();
    for (var user in users.documents) {
      if (user.data['User_ID'] == loggedInUser.email) {
        print('found required user');
        setState(() {
          registration_num = user.data['Registration_ID'];
          userID = user.data['User_ID'];
          num_tickets = user.data['Num_Tickets'];
          user_name = user.data['User_Name'];
        });
      }
    }

    final vehicles = await _firestore.collection('Vehicle').getDocuments();
    for (var vehicle in vehicles.documents) {
      if (vehicle.data['Registration_Number'] == registration_num) {
        setState(() {
          vehicle_type = vehicle.data['Vehicle_Type'];
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: ApplicationBar(),
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              //  backgroundColor: Colors.blueAccent,
              backgroundImage: AssetImage('assets/images/user.jpg'),
            ),
            Text(user_name,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'DancingScript',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
                height: 30.0,
                width: 150.0,
                child: Divider(color: Colors.grey[600])),
            Card(
              color: Colors.black26,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.motorcycle,
                  size: 50.0,
                  color: Colors.grey[400],
                ),
//
                title: Text(
                  registration_num,
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 25,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Vehicle number',
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 15,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.black26,
              //padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.gavel,
                  size: 50.0,
                  color: Colors.grey[400],
                ),
                title: Text(
                  num_tickets.toString(),
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 25,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Number of tickets',
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 15,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.black26,
              //padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.event_seat,
                  size: 50.0,
                  color: Colors.grey[400],
                ),
                //vehicle_type
                title: Text(
                  vehicle_type.toString() + ' Wheeler',
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 25,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  'Vehicle type',
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 15,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ])),
    );
  }
}
