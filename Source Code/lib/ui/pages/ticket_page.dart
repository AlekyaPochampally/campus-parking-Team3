import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campusparking/main.dart';
import 'package:campusparking/ui/pages/user_home_page.dart';
import 'package:campusparking/ui/widgets/app_bar.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';



final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
class ticket extends StatefulWidget {
  static const String route = '/ticket';

  @override
  _ticketState createState() => _ticketState();
}

class _ticketState extends State<ticket> {
  final _auth = FirebaseAuth.instance;
  bool autho=false;
  @override
  void initState() {
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

  void Ticket(String regNumber, String reason, bool action) async {
    String UID = '', docId;
    int tickets = 0;
    // raise ticket, action = true
    print('regNumber $regNumber reason $reason action $action');
    final users =await _firestore.collection('User').getDocuments();
    for (var user in users.documents) {
      print(user.data['Registration_ID']);
        if (user.data['Registration_ID'] == regNumber) {
          UID = user.data['User_ID'];
          docId = user.documentID;
         // print(UID);
          if (action)
         { tickets = user.data['Num_Tickets'] + 1; //adding new ticket
           Toast.show("Successfully Raised a ticket", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
         }
          else
           { tickets = user.data['Num_Tickets'] - 1; //removing ticket
             Toast.show("Successfully Droped a ticket", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
           }
         // print('tickets $tickets');
          _firestore
              .collection('User')
              .document(docId)
              .updateData({'Num_Tickets': tickets});
         // print('updated user table');
          break;
          //user.data.update('Num_Tickets', (tickets) => null);
        } else
          print('invalid vehicle number');
          Toast.show("Invalid Vehicle number", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

    }


    var date = new DateTime.now();
    if (action) {
     // print('started session 2 $date');

      _firestore.collection('Ticket').add({
        'User_ID': UID,
        'Description': reason,
        'Ticket_ID': 0,
        'Date': date.toString(),
        'Active': true
      });
    } //updated ticket table
  }

  @override
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 2, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          //onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    String vehicleNum, reason;
    bool action;
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
                  'Tickets',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Raise or drop a ticket',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Vehicle Number',
                  ),
                  onChanged: (value) {
                    vehicleNum = value;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reason for ticket',
                  ),
                  onChanged: (value) {
                    reason = value;
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ToggleSwitch(
                      minWidth: 90.0,
                      cornerRadius: 20.0,
                      activeBgColor: Colors.cyan,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      labels: ['Raise', 'Drop'],
                      icons: [Icons.check, Icons.close],
                      onToggle: (index) {
                        print('switched to: $index');
                        
                        if (index == 0)
                          action = true;
                        else
                          action = false;
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          
                          Ticket(vehicleNum, reason, action);
                          
                          
                        },
                        color: Colors.teal[400],
                        //blue[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.grey)),
                        splashColor: Colors.green,
                        child: Row(
                          children: [
                            Text('Proceed',
                                style: TextStyle(fontSize: 25.0)),
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
                        },
                        color: Colors.red[400],
                        //blue[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.grey)),
                        splashColor: Colors.green,
                        child: Row(
                          children: [
                            Text('Cancel', style: TextStyle(fontSize: 25.0)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}