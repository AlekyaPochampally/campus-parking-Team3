import 'package:flutter/material.dart';

class Report extends StatefulWidget {
    @override
    _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {

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
                    FormFieldWidget(
                        hintText: 'Vehicle Number',
                    ),
                    FormFieldWidget(
                        hintText: 'Upload Image',
                    ),
                    RaisedButton(
                        color: Colors.blueAccent,
                        onPressed: () {},
                        child: Text(
                            'Report',
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

class FormFieldWidget extends StatelessWidget {
    final String hintText;
    final Function validator;
    final Function onSaved;


    FormFieldWidget({
        this.hintText,
        this.validator,
        this.onSaved,
    });

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
                decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                ),
            ),
        );
    }
}