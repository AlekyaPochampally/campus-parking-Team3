import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campusparking/ui/widgets/app_bar.dart';

class ContactUs extends StatefulWidget {
  static const String route = '/ContactUs';

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(),
        body: SafeArea(
            child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Contact Us',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Contact university for any queries',
                ),
              ),
              Card(
                    color: Colors.black26,
                    margin:EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone_in_talk,
                        size: 40.0,
                        color: Colors.grey[400],
                      ),
                      title: Text('(660) 562-1212',
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 25,
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ),
                  ),
              Card(
                    color: Colors.black26,
                    margin:EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        size: 40.0,
                        color: Colors.grey[400],
                      ),
                      title: Text('CParking@nwmissouri.edu',
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 25,
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Call us for immidiate assistance or you can drop us an email and expect response in 1-2 working days ',
                    ),
                  ),
            ])));
  }
}
