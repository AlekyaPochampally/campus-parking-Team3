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
                          OutlineButton(
                            textColor: Colors.blue,
                            onPressed: () {
                              showSearch(
                                  context: context, delegate: DataSearch());
                            },
                            child: Text(
                              "Search with keyword",
                              style: TextStyle(fontSize: 25),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1.8,
                            ),
                          ),
                          Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'You may find your question below.',
                                    style: TextStyle(
                                fontSize: 20),
                                  ),
                                  
                                ),
                          // Text('\n\nYou may find your question below.'),
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
                                      title: Text("Q: How to park my vehicle?"),
                                      content: Text(
                                          "A: login your account then go to park page choose an avaible slot, park your vehicle there then press finish parking button, or call 123-321 4567 for more help."),
                                    );
                                  }),
                              child: Text('3. How to park my vehicle?'))
                        ],
                      ))
                    ])))));
  }
}

class DataSearch extends SearchDelegate<String> {
  final _data = [
    "none",
    "login failed",
    "reset password",
    "forgot password",
    "account logout",
    "ticket issue",
    "sign up",
    "report violation"
  ];

  final _answer = [
    "none",
    "Check network connection or password",
    "login page -> forget passwork",
    "login page -> forget passwork",
    "hamburger menu -> log out",
    "hamburger menu -> ticket",
    "login page -> sign up",
    "hamburger menu -> Reprot"
  ];

  final _history  = [
    "login failed",
    "account logout",
    "ticket issue",
  ];

   @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final Iterable<String> suggestions = query.isEmpty
        ? _history
        : _data.where((String i) => i.startsWith(query));

    return _SuggestionList(
      query: query,
      suggestions: suggestions.map<String>((String i) => '$i').toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String searched = query;
    if (searched == null || !_data.contains(searched)) {
      return Center(
        child: Text(
          '"$query"\n is not found.\nTry another.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      children: <Widget>[
        _ResultCard(
          title: searched,
          res: _answer[_data.indexOf(searched)],
          searchDelegate: this,
        ),
        _ResultCard(
          title: _data[_data.indexOf(searched)+1 < _data.length ? _data.indexOf(searched)+1 : 0],
          res: _answer[_data.indexOf(searched)+1 < _data.length ? _data.indexOf(searched)+1 : 0],
          searchDelegate: this,
        ),
        _ResultCard(
          title: _data[_data.indexOf(searched)+2 < _data.length ? _data.indexOf(searched)+2 : 0],
          res: _answer[_data.indexOf(searched)+2 < _data.length ? _data.indexOf(searched)+2 : 0],
          searchDelegate: this,
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Voice Search',
          icon: const Icon(Icons.mic),
          onPressed: () {
            query = 'TODO: implement voice input';
          },
        )
      else
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.res, this.title, this.searchDelegate});

  final String res;
  final String title;
  final SearchDelegate<String> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        searchDelegate.close(context, res);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(title),
              Text(
                '$res',
                style: theme.textTheme.headline5.copyWith(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subtitle1,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}