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
  void initState() {
    super.initState();
    getCurrentUser();
    UserHomePage.available = 0;
    Lot_Name = UserHomePage.Lot_name.substring(2);
    availableSlots();
    checkColor();
  }

  void checkColor() async {
    await for (var snapshot in _firestore.collection('slot').snapshots()) {
      for (var slot in snapshot.documentChanges) {
        print("Inside CheckColor: ");
        if (slot.document.documentID.contains(UserHomePage.Lot_name)) {
          print("Document ID " + slot.document.documentID);
          String slotID=slot.document.documentID.substring(4);
          if (slot.document.data['Is_Occupied']) {
            print("This says the slot is occupied");

            if (slotID=="10") {
              print("setting has_been_pressed10 to true");
              setState(() {
                _hasBeenPressed10 = true;
              });
            }
            else if (slotID=="11") {
              print("setting has_been_pressed11 to true");
              setState(() {
                _hasBeenPressed11 = true;
              });
            }
            else if (slotID=="12") {
              print("setting has_been_pressed12 to true");
              setState(() {
                _hasBeenPressed12 = true;
              });
            }
            else if (slotID=="1") {
              print("setting has_been_pressed1 to true");
              setState(() {
                _hasBeenPressed1 = true;
              });
            }
            else if (slotID =="2") {
              print("setting _hasBeenPressed2 to true");
              setState(() {
                _hasBeenPressed2 = true;
              });
            }
            else if (slotID=="3"){
              print("setting _hasBeenPressed3 to true");
              setState(() {
                _hasBeenPressed3 = true;
              });
            }
            else if (slotID=="4") {
              print("setting _hasBeenPressed4 to true");
              setState(() {
                _hasBeenPressed4 = true;
              });
            }
            else if (slotID=="5") {
              print("setting _hasBeenPressed5 to true");
              setState(() {
                _hasBeenPressed5 = true;
              });
            }
            else if (slotID=="6") {
              print("setting _hasBeenPressed6 to true");
              setState(() {
                _hasBeenPressed6 = true;
              });
            }
            else if (slotID=="7") {
              print("setting _hasBeenPressed7 to true");
              setState(() {
                _hasBeenPressed7 = true;
              });
            }
            else if (slotID=="8") {
              print("setting   _hasBeenPressed8 to true");
              setState(() {
                _hasBeenPressed8 = true;
              });
            }
            else if (slotID=="9") {
              print("setting _hasBeenPressed9 to true");
              setState(() {
                _hasBeenPressed9 = true;
              });
            }
           // no need of else
              else{
                print(" i am in else");
            }



          }
          else{

              print("This says the slot is vacant: "+slotID);
              if (slotID=="10") {
                print("setting has_been_pressed10 to false");
                setState(() {
                  _hasBeenPressed10 = false;
                });
              }
              else if (slotID=="11") {
                print("setting has_been_pressed11 to false");
                setState(() {
                  _hasBeenPressed11 = false;
                });
              }
              else if (slotID=="12") {
                print("setting has_been_pressed12 to false");
                setState(() {
                  _hasBeenPressed12 = false;
                });
              }else if (slotID=="1") {
                print("setting has_been_pressed1 to false");
                setState(() {
                  _hasBeenPressed1 = false;
                });
              }
              else if (slotID=="2") {
                print("setting _hasBeenPressed2 to false");
                setState(() {
                  _hasBeenPressed2 = false;
                });
              }else if (slotID=="3") {
                print("setting _hasBeenPressed3 to false");
                setState(() {
                  _hasBeenPressed3 = false;
                });
              }
              else if (slotID=="4") {
                print("setting _hasBeenPressed4 to false");
                setState(() {
                  _hasBeenPressed4 = false;
                });
              }
              else if (slotID=="5") {
                print("setting _hasBeenPressed5 to false");
                setState(() {
                  _hasBeenPressed5 = false;
                });
              }
              else if (slotID=="6") {
                print("setting _hasBeenPressed6 to false");
                setState(() {
                  _hasBeenPressed6 = false;
                });
              }
              else if (slotID=="7") {
                print("setting _hasBeenPressed7 to false");
                setState(() {
                  _hasBeenPressed7 = false;
                });
              }
              else if (slotID=="8") {
                print("setting   _hasBeenPressed8 to false");
                setState(() {
                  _hasBeenPressed8 = false;
                });
              }
              else if (slotID=="9") {
                print("setting _hasBeenPressed9 to false");
                setState(() {
                  _hasBeenPressed9 = false;
                });
              }
              // no need of else
              else{
                print(" i am in else");
              }

          }
        }
        //print('Available ${UserHomePage.available}');
      }
    }
  } //end of check

//code for available number of slots
  void availableSlots() async {
    print('this is available slot function');
    print("checking for available number of slots in parking area " +
        UserHomePage.Lot_name);
    await for (var snapshot in _firestore.collection('slot').snapshots()) {
      for (var slot in snapshot.documentChanges) {
        if (slot.document.documentID.contains(UserHomePage.Lot_name)) {
          if (slot.document.data['Is_Occupied']) {

            print(slot.document.documentID + "is occupied");

          }
          else {
            setState(() {
              if (UserHomePage.available < 12) {
                UserHomePage.available++;
              }
              print(slot.document.documentID + " is vacant");
            });

          }
          print('Available ${UserHomePage.available}');
        }
        // if (UserHomePage.Lot_name.contains("PA1")) {
        //
        //   UserHomePage.parkingLot1 = UserHomePage.available;
        // } else if (UserHomePage.Lot_name.contains("PA2")) {
        //
        //   UserHomePage.parkingLot2 = UserHomePage.available;
        // } else if (UserHomePage.Lot_name.contains("PA3")) {
        //
        //   UserHomePage.parkingLot3 = UserHomePage.available;
        // } else if (UserHomePage.Lot_name.contains("PA4")) {
        //
        //   UserHomePage.parkingLot4 = UserHomePage.available;
        // }
      }
    }
  }

//code for occupying a slot
  void occupySlot(String buttonText) {
    var occupied =
        _firestore.collection('slot').document(document_id).updateData({
      'Is_Occupied': true,
      'User_ID': User_ID,
    });
    if (buttonText=="10") {
      print("setting has_been_pressed10 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed10 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }
    else if (buttonText=="11") {
      print("setting _hasBeenPressed11 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed11 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }
    else if (buttonText=="12") {
      print("setting has_been_pressed12 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed12 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }
    else if (buttonText=="1") {
      print("setting has_been_pressed1 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed1 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }
    else if (buttonText=="2") {
      print("*********ENTERED 2*******: "+buttonText);
      print("setting has_been_pressed2 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed2 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }    else if (buttonText=="3") {
      print("*********ENTERED 3*******: "+buttonText);
      print("setting has_been_pressed3 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed3 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }    else if (buttonText=="4") {
      print("*********ENTERED 4*******: "+buttonText);
      print("setting has_been_pressed4 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed4=true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }    else if (buttonText=="5") {
      print("*********ENTERED 5*******: "+buttonText);
      print("setting has_been_pressed5 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed5 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }    else if (buttonText=="6") {
      print("*********ENTERED 6*******: "+buttonText);
      print("setting has_been_pressed6 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed6 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }    else if (buttonText=="7") {
      print("setting has_been_pressed7 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed7 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }    else if (buttonText=="8") {
      print("setting has_been_pressed8 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed8 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }    else if (buttonText=="9") {
      print("setting has_been_pressed9 to true inside occupy slot ");
      setState(() {
        _hasBeenPressed9 = true;
        UserHomePage.available--;
        print("Slot is occupied: inside occupy slot");
      });
    }

    else{
      print("i am inside else");
    }

    print('requested slot occupied successfully');
    Toast.show("You have Occupied the slot", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  //code for vacating a slot
  void vacateSlot(String buttonText) {
    var occupied =
        _firestore.collection('slot').document(document_id).updateData({
      'Is_Occupied': false,
      'User_ID': User_ID,
    });

    if (buttonText=="10") {
      print("setting has_been_pressed10 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed10 = false;
      });
    }
    else if (buttonText=="11") {
      print("setting _hasBeenPressed11 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed11 = false;

        print("Slot is vacated: inside vacate slot");
      });
    }
    else if (buttonText=="12") {
      print("setting has_been_pressed12 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed12 = false;

        print("Slot is vacated: inside vacate slot");
      });
    }
    else if (buttonText=="1") {
      print("setting has_been_pressed1 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed1 = false;

        print("Slot is vacated: inside vacate slot");
      });
    }
    else if (buttonText=="2") {
      print("setting has_been_pressed2 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed2 = false;

        print("Slot is vacated: inside vacate slot");
      });
    }    else if (buttonText=="3") {
      print("setting has_been_pressed3 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed3 = false;

        print("Slot is vacated: inside vacate slot");
      });
    }    else if (buttonText=="4") {
      print("setting has_been_pressed4 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed4=false;

        print("Slot is vacated: inside vacate slot");
      });
    }    else if (buttonText=="5") {
      print("setting has_been_pressed5 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed5 = false;

        print("Slot is vacated: inside vacate slot");
      });
    }    else if (buttonText=="6") {
      print("setting has_been_pressed6 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed6 = false;

        print("Slot is vacated: inside vacate slot");
      });
    }    else if (buttonText=="7") {
      print("setting has_been_pressed7 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed7 = false;

        print("Slot is vacated: inside vacate slot");
      });
    }    else if (buttonText=="8") {
      print("setting has_been_pressed8 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed8 = false;

        print("Slot is vacated: inside vacate slot");
      });
    }    else if (buttonText=="9") {
      print("setting has_been_pressed9 to false inside vacant slot ");
      setState(() {
        _hasBeenPressed9 = false;

        print("Slot is vacated: inside vacate slot");
      });
    }

    else{
      print("i am inside else");
    }

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

        occupySlot(buttonText);

        break;
      } else {
        if (data['User_ID'] == loggedInUser.email) {
          vacateSlot(buttonText);
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


                                        buttonPressed("10"),


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
              )
             
                ],
              ),
            
          ));
          }      
  
}
