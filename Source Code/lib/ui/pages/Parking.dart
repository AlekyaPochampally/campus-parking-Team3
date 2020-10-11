import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campusparking/main.dart';
import 'user_home_page.dart';
import 'package:campusparking/ui/pages/user_home_page.dart';
import 'package:campusparking/ui/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class Parking extends StatefulWidget {
  static const String route = '/parking';

  @override
  _ParkingState createState() => _ParkingState();
}

class _ParkingState extends State<Parking> {
  final _auth = FirebaseAuth.instance;
  bool Is_Occupied, Slot_Type, changeColor = false;
  String User_ID, document_id;
  int Lot_ID, Slot_ID;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    UserHomePage.available=0;
    availableSlots();
  }

//code for available number of slots
  void availableSlots() async {
    print('this is available slot function');
    print( UserHomePage.Lot_name);
    await for (var snapshot in _firestore.collection('slot').snapshots()) {
      for (var slot in snapshot.documentChanges) {
        print('got inside for');
        if (slot.document.documentID.contains(UserHomePage.Lot_name)) {
          print('got inside 1st if');
          if (slot.document.data['Is_Occupied']) {
            setState(() {
              UserHomePage.available--;
              print(slot.document.documentID);
            });
          } else {
            setState(() {
              UserHomePage.available++;
              print(slot.document.documentID);
            });
          }
        }
        print('Available ${UserHomePage.available}');
      }
    }
  }

//code for occupying a slot
  void occupySlot() {
    var occupied =
    _firestore.collection('slot').document(document_id).updateData({
      'Is_Occupied': true,
      'User_ID': User_ID,
    });
    setState(() {
      changeColor = true;
    });

    print('requested slot occupied successfully');
  }

  //code for vacating a slot
  void vacateSlot() {
    var occupied =
        _firestore.collection('slot').document(document_id).updateData({
      'Is_Occupied': false,
      'User_ID': User_ID,
    });
    setState(() {
      changeColor = false;
    });

    print('requested slot vacated successfully');
  }

//code for reserving a slot: for admin only
  void reserveSlot(String buttonText) {
    document_id = UserHomePage.Lot_name + '-' + buttonText;
    var occupied =
        _firestore.collection('slot').document(document_id).updateData({
      'Is_Reserved': true,
      'User_ID': User_ID,
    });

    print('requested slot reserved successfully');
  }

  //get current user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        User_ID = loggedInUser.email;
      }
    } catch (e) {
      print(e);
    }
  }

//checking whether slot is vacant or occupied
  Future buttonPressed(String buttonText) async {
    document_id = UserHomePage.Lot_name + '-' + buttonText;
    print('button pressed $document_id');
    await for (var snapshot
        in _firestore.collection('slot').document(document_id).snapshots()) {
      var data = snapshot.data;
      // if (data['User_ID'] == loggedInUser.email)
      //   {
          if (!data['Is_Occupied']) {
            occupySlot();
            break;
          } else {
            if (data['User_ID'] == loggedInUser.email)
              {vacateSlot();
               break;
              }
            else{
              print("This user is not allowed to perform the action "+ loggedInUser.email);
            }
       }

    }
  }

  @override
  Widget buildButton(String buttonText) {
    bool added = false;
    return Container(
      child: GestureDetector(

        child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(
                    color: Colors.white, width: 2, style: BorderStyle.solid)),
            padding: EdgeInsets.all(16.0),
            color: Colors.lightBlueAccent,
            onLongPress: () {
              reserveSlot(buttonText);
            },
            onPressed: () => {
                //  setState(() {
                    buttonPressed(buttonText),
                 // }),
                },
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool added = false;
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
                  'Parking Area',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Occupy or vacate a slot',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                //alignment: Alignment.centerRight,
                //alignment: Alignment.centerRight,
                //padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Parking.route);
                                Toast.show("You have Ocuupied the slot", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                          },
                          color: Colors.red[400],
                          //blue[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.grey)),
                          splashColor: Colors.red,
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_car,
                                size: 40.0,
                                color: Colors.black54,
                              ),
                              Text('Occupy', style: TextStyle(fontSize: 25.0)),
                            ],
                          ),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            Navigator.of(context)
                                .pushReplacementNamed(UserHomePage.route);
                                Toast.show("You have Vaccated the slot", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                          },
                          color: Colors.teal[300],
                          //blue[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.grey)),
                          splashColor: Colors.green,
                          child: Row(
                            children: [
                              Icon(
                                Icons.assignment_turned_in,
                                size: 40.0,
                                color: Colors.black54,
                              ),
                              Text('Vacate', style: TextStyle(fontSize: 25.0)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      //availableSlots(),
                      ' Available slots: ',
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 20,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      UserHomePage.available.toString(),
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 20,
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("1"),
                          buildButton("2"),
                          buildButton("3"),
                          buildButton("4"),
                        ]),
                        TableRow(children: [
                          buildButton("5"),
                          buildButton("6"),
                          buildButton("7"),
                          buildButton("8"),

                        ]),
                        TableRow(children: [
                          buildButton("9"),
                          buildButton("10"),
                          buildButton("11"),
                          buildButton("12"),

                        ]),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.of(context)
                            .pushReplacementNamed(UserHomePage.route);
                            Toast.show("You have Reserved the slot", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      },
                      color: Colors.blueAccent,
                      //blue[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.grey)),
                      splashColor: Colors.green,
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock,
                            size: 40.0,
                            color: Colors.black54,
                          ),
                          Text('Reserve', style: TextStyle(fontSize: 25.0)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
