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

  static void availableSlots() {}
}

class _ParkingState extends State<Parking> {
  final _auth = FirebaseAuth.instance;
  bool Is_Occupied, Slot_Type, changeColor = false, changeColor1 = false;
  String User_ID, document_id, Lot_Name;
  int Lot_ID, Slot_ID;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    UserHomePage.available = 0;
    Lot_Name = UserHomePage.Lot_name.substring(2);
    availableSlots();
  }

//code for available number of slots
  void availableSlots() async {
    print('this is available slot function');
    print(UserHomePage.Lot_name);
    await for (var snapshot in _firestore.collection('slot').snapshots()) {
      for (var slot in snapshot.documentChanges) {
        //print('got inside for');
        if (slot.document.documentID.contains(UserHomePage.Lot_name)) {
          print("check parking page");
          print(slot.document.documentID);
          print(UserHomePage.Lot_name);
          //print('got inside 1st if');
          if (slot.document.data['Is_Occupied']) {
            setState(() {
              UserHomePage.available--;
              print("check parking count occupied: ${UserHomePage.available}");
              print(slot.document.documentID);
            });
          } else {
            setState(() {
              UserHomePage.available++;
              print(
                  "check parking count not occupied: ${UserHomePage.available}");
              // print(slot.document.documentID);
            });
          }
        }
        //print('Available ${UserHomePage.available}');
      }
      if (UserHomePage.Lot_name.contains("PA1")) {
        print("In PA1 ${UserHomePage.available}");
        UserHomePage.parkingLot1 = UserHomePage.available;
      } else if (UserHomePage.Lot_name.contains("PA2")) {
        print("In PA2 ${UserHomePage.available}");
        UserHomePage.parkingLot2 = UserHomePage.available;
      } else if (UserHomePage.Lot_name.contains("PA3")) {
        print("In PA3 ${UserHomePage.available}");
        UserHomePage.parkingLot3 = UserHomePage.available;
      } else if (UserHomePage.Lot_name.contains("PA4")) {
        print("In PA4 ${UserHomePage.available}");
        UserHomePage.parkingLot4 = UserHomePage.available;
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
      changeColor1 = true;
    });

    print('requested slot occupied successfully');
    Toast.show("You have Ocuupied the slot", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  //code for vacating a slot
  void vacateSlot() {
    var occupied =
        _firestore.collection('slot').document(document_id).updateData({
      'Is_Occupied': false,
      'User_ID': User_ID,
    });
    setState(() {
      changeColor1 = false;
    });
    Toast.show("You have Vacated the slot", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
    Toast.show("You have Reserved the slot", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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

  // chaging button color
  void changeButtonColor() async {}

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
        if (data['User_ID'] == loggedInUser.email) {
          vacateSlot();
          break;
        } else {
          print("This user is not allowed to perform the action " +
              loggedInUser.email);
          Toast.show("Someone else have already occupied this slot", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }
    }
  }

  Widget buildButton(String buttonText) {
    return Container(
      child: GestureDetector(
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(
                    color: Colors.white, width: 2, style: BorderStyle.solid)),
            padding: EdgeInsets.all(16.0),
            color: _hasBeenPressed ? Colors.red[300] : Colors.green[300],
            //Colors.lightBlueAccent,
            onLongPress: () {
              reserveSlot(buttonText);
            },
            onPressed: () => {
                  //  setState(() {
                  buttonPressed(buttonText),
                  setState(() {
                    _hasBeenPressed = !_hasBeenPressed;
                  })
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

  bool _hasBeenPressed = false;
  bool _hasBeenPressed1 = false;
  bool _hasBeenPressed2 = false;
  bool _hasBeenPressed3 = false;
  bool _hasBeenPressed4 = false;
  bool _hasBeenPressed5 = false;
  bool _hasBeenPressed6 = false;
  bool _hasBeenPressed7 = false;
  bool _hasBeenPressed8 = false;
  bool _hasBeenPressed9 = false;
  bool _hasBeenPressed10 = false;
  bool _hasBeenPressed11 = false;
  bool _hasBeenPressed12 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                    height: 35.0,
                    width: 35.0,
                    child: Image.asset('assets/images/nwm_logo.png')),
              ),
              Text("Campus Parking"),
            ],
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(UserHomePage.route);
            },
          ),
        ),
        body: SafeArea(
          child: ListView(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Tooltip(
                  message:
                      'Long Press for Reserve \n\n Press for vacate and occupy',
                  child: FlatButton(
                    child: Icon(Icons.help),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Parking Area - $Lot_Name',
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
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed1
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("1");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("1"),
                                        setState(() {
                                          _hasBeenPressed1 = !_hasBeenPressed1;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed2
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("2");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("2"),
                                        setState(() {
                                          _hasBeenPressed2 = !_hasBeenPressed2;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed3
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("3");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("3"),
                                        setState(() {
                                          _hasBeenPressed3 = !_hasBeenPressed3;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed4
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("4");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("4"),
                                        setState(() {
                                          _hasBeenPressed4 = !_hasBeenPressed4;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "4",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed5
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("5");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("5"),
                                        setState(() {
                                          _hasBeenPressed5 = !_hasBeenPressed5;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "5",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed6
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("6");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("6"),
                                        setState(() {
                                          _hasBeenPressed6 = !_hasBeenPressed6;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "6",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed7
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("7");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("7"),
                                        setState(() {
                                          _hasBeenPressed7 = !_hasBeenPressed7;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "7",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed8
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("8");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("8"),
                                        setState(() {
                                          _hasBeenPressed8 = !_hasBeenPressed8;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "8",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed9
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("9");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("9"),
                                        setState(() {
                                          _hasBeenPressed9 = !_hasBeenPressed9;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "9",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed10
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("10");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("10"),
                                        setState(() {
                                          _hasBeenPressed10 =
                                              !_hasBeenPressed10;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "10",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed11
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("11");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("11"),
                                        setState(() {
                                          _hasBeenPressed11 =
                                              !_hasBeenPressed11;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "11",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  padding: EdgeInsets.all(16.0),
                                  color: _hasBeenPressed12
                                      ? Colors.red[300]
                                      : Colors.green[300],
                                  //Colors.lightBlueAccent,
                                  onLongPress: () {
                                    reserveSlot("12");
                                  },
                                  onPressed: () => {
                                        //  setState(() {
                                        buttonPressed("12"),
                                        setState(() {
                                          _hasBeenPressed12 =
                                              !_hasBeenPressed12;
                                        })
                                        // }),
                                      },
                                  child: Text(
                                    "12",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(UserHomePage.route);
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
                                Icons.closed_caption,
                                size: 40.0,
                                color: Colors.black54,
                              ),
                              Text('Cancel', style: TextStyle(fontSize: 25.0)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ButtonTheme(
                  //   minWidth: 150.0,
                  //   height: 50.0,
                  //   child: RaisedButton(
                  //     onPressed: () {
                  //       // Navigator.pop(context);
                  //       Navigator.of(context)
                  //           .pushReplacementNamed(UserHomePage.route);
                  //           Toast.show("You have Reserved the slot", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                  //     },
                  //     color: Colors.blueAccent,
                  //     //blue[700],
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(18.0),
                  //         side: BorderSide(color: Colors.grey)),
                  //     splashColor: Colors.green,
                  //     child: Row(
                  //       children: [
                  //         Icon(
                  //           Icons.lock,
                  //           size: 40.0,
                  //           color: Colors.black54,
                  //         ),
                  //         Text('Reserve', style: TextStyle(fontSize: 25.0)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ));
  }
}
