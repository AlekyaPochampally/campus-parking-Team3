import 'package:campusparking/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FaQPage extends StatefulWidget {
  static const String route = '/faq';

  @override
  _FaQPageState createState() => _FaQPageState();
}

class _FaQPageState extends State<FaQPage> {
  String kword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationBar(),
        body: SafeArea(
            child: Form(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Campus Parking',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 30),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'FAQ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'What can I do for you?'
                            )
                          ),
                          Text('\n\nYou may find your question below.'),
                          FlatButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Q: Can't access your account?"),
                                      content: Text("A: Check your network connection or call 123-321 4567 for help."),
                                    );
                                  }),
                              child: 
                              Text('1. Can\'t access your account?')),
                          FlatButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Q: How to reset password?"),
                                      content: Text("A: Login page -> forget password or call 123-321 4567 for help."),
                                    );
                                  }),
                              child: Text('2. How to reset password?')),
                              FlatButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Q: How to part my vehicle?"),
                                      content: Text("A: login your account then go to park page choose an avaible slot, park your vehicle there then press finish parking button, or call 123-321 4567 for more help."),
                                    );
                                  }),
                              child: Text('3. How to part my vehicle?'))
                        ],
                      ))
                    ])))));
  }
}
