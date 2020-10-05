import 'package:campusparking/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FaQPage extends StatefulWidget {
  static const String route = '/faq';

  @override
  _FaQPageState createState() => _FaQPageState();
}

class _FaQPageState extends State<FaQPage> {
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
                          'FAQ\n',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppBar(
                            title: Text("Search with keyword",
                                style: TextStyle(color: Colors.blue)),
                            backgroundColor: Color(0xFF151026),
                            actions: <Widget>[
                              IconButton(
                                icon: Icon(Icons.search),
                                color: Colors.blue,
                                onPressed: () {
                                  showSearch(
                                      context: context, delegate: DataSearch());
                                },
                              )
                            ],
                          ),
                          Text('\n\nYou may find your question below.'),
                          FlatButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          Text("Q: Can't access your account?"),
                                      content: Text(
                                          "A: Check your network connection or call 123-321 4567 for help."),
                                    );
                                  }),
                              child: Text('1. Can\'t access your account?')),
                          FlatButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Q: How to reset password?"),
                                      content: Text(
                                          "A: Login page -> forget password or call 123-321 4567 for help."),
                                    );
                                  }),
                              child: Text('2. How to reset password?')),
                          FlatButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Q: How to part my vehicle?"),
                                      content: Text(
                                          "A: login your account then go to park page choose an avaible slot, park your vehicle there then press finish parking button, or call 123-321 4567 for more help."),
                                    );
                                  }),
                              child: Text('3. How to part my vehicle?'))
                        ],
                      ))
                    ])))));
  }
}

class DataSearch extends SearchDelegate<String> {
  final keywords = [
    "login",
    "reset",
    "password",
    "password1",
    "password2",
    "account",
    "ticket",
    "sign up",
    "report"
  ];

  final recentsearch = [
    "login",
    "account",
    "ticket",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 300,
        child: Card(color: Colors.black, child: Center(child: Text(query))),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionlist = query.isEmpty
        ? recentsearch
        : keywords.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.replay),
          title: RichText(
              text: TextSpan(
                  text: suggestionlist[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.blue[50], fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                    text: suggestionlist[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]))),
      itemCount: suggestionlist.length,
    );
  }
}
