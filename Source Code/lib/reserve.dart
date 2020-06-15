import 'package:flutter/material.dart';

class Reserve extends StatefulWidget {
  @override
  _ReserveState createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[],
            ),
          ),
          DropdownButton(items: [
            DropdownMenuItem(value: "slot-1-1", child: Text("PS-01-01")),
            DropdownMenuItem(value: "slot-1-2", child: Text("PS-01-02")),
            DropdownMenuItem(value: "slot-1-3", child: Text("PS-01-03")),
            DropdownMenuItem(value: "slot-1-4", child: Text("PS-01-04")),
            DropdownMenuItem(value: "slot-1-5", child: Text("PS-01-05")),
            DropdownMenuItem(value: "slot-1-6", child: Text("PS-01-06")),
            DropdownMenuItem(value: "slot-1-7", child: Text("PS-01-07")),
            DropdownMenuItem(value: "slot-1-8", child: Text("PS-01-08")),
          ], onChanged: (String value) {  },
          hint: Text("Select Parking"),
          ),
          RaisedButton(
            color: Colors.blueAccent,
            onPressed: () {},
            child: Text(
              'Reserve',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
