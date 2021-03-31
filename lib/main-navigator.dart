import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

// DATA
const List<Map<String, String>> books = [
  {
    'id': '1',
    'title': 'Stranger in a Strange Land',
    'author': 'Robert A. Heinlein',
  },
  {
    'id': '2',
    'title': 'Foundation',
    'author': 'Isaac Asimov',
  },
  {
    'id': '3',
    'title': 'Fahrenheit 451',
    'author': 'Ray Bradbury',
  },
];

// SCREENS
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              //onPressed: () => context.beamToNamed('/books'),
              onPressed: () => context.currentBeamLocation.state = BeamState(
                pathBlueprintSegments: ['books'],
              ),
              child: Text('See books'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              //onPressed: () => context.beamToNamed('/books'),
              onPressed: () => context.currentBeamLocation.state = BeamState(
                pathBlueprintSegments: ['form'],
              ),
              child: Text('See form'),
            ),
          ],
        ),
      ),
    );
  }
}

class Location {
  Object x;
  Object y;

  Location(this.x, this.y);
}

class BooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleQuery =
        context.currentBeamLocation.state.queryParameters['title'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: ListView(
        children: books
            .where((book) =>
            book['title'].toLowerCase().contains(titleQuery.toLowerCase()))
            .map(
              (book) => ListTile(
            title: Text(book['title']),
            subtitle: Text(book['author']),
            //onTap: () => context.beamToNamed('/books/${book['id']}'),
            onTap: () => context.currentBeamLocation.update(
                  (state) => state.copyWith(
                pathBlueprintSegments: ['books', ':bookId'],
                pathParameters: {'bookId': book['id']},
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  BookDetailsScreen({
    this.bookId,
  }) : book = books.firstWhere((book) => book['id'] == bookId);

  final String bookId;
  final Map<String, String> book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Author: ${book['author']}'),
      ),
    );
  }
}

// LOCATIONS
class BooksLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ['/books/:bookId','/form'];


  @override
  List<BeamPage> pagesBuilder(BuildContext context) => [
    BeamPage(
      key: ValueKey('home'),
      child: HomeScreen(),
    ),
    if (state.uri.pathSegments.contains('books'))
      BeamPage(
        key: ValueKey('books-${state.queryParameters['title'] ?? ''}'),
        child: BooksScreen(),
      ),
    if (state.uri.pathSegments.contains('form'))
      BeamPage(
        key: ValueKey('form'),
        child: MyCustomForm(),
      ),
    if (state.pathParameters.containsKey('bookId'))
      BeamPage(
        key: ValueKey('book-${state.pathParameters['bookId']}'),
        child: BookDetailsScreen(
          bookId: state.pathParameters['bookId'],
        ),
      ),
  ];
}

// APP
class MyApp extends StatelessWidget {
  final routerDelegate = BeamerRouterDelegate(
    beamLocations: [
      BooksLocation(),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerRouteInformationParser(),
      backButtonDispatcher:
      BeamerBackButtonDispatcher(delegate: routerDelegate),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _eyeIconNotifier = ValueNotifier(true);
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('_title'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: _formModal(),
      ),
    );
  }

  final List<Map> _formItem = [
    {"key": "name", "cn": "用户名", "value": "", "icon": Icons.person},
    {"key": "password", "cn": "密码", "value": "", "icon": Icons.lock},
  ];

  Widget _formModal() {
    return Container(
      width: 400.0,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("登录", style: TextStyle(fontSize: 20.0)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _formList(),
            ),
            ElevatedButton(
              onPressed: () {
                //如果表单有效，则Validate返回true，否则返回false。
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('用户名：${_formItem[0]["value"]}  密码： ${_formItem[1]["value"]}')));
//                  _handleLogin(_formItem);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              ),
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formList() {
    return Column(
      children: _formItem.map((item) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder(
            valueListenable: _eyeIconNotifier,
            builder: (context, value, _) {
              return TextFormField(
                obscureText: item["key"] == "name" ? false : value,
                decoration: InputDecoration(
                  labelText: '输入${item["cn"]}',
                  prefixIcon: Icon(item["icon"]),
                  suffixIcon: _eyePassword(item["key"], value),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onSaved: (value) {
                  item["value"] = value;
                },
                validator: (value) {
                  /// 添加验证
                  if (value.isEmpty) {
                    return '请填写${item["cn"]}';
                  }
                  return null;
                },
              );
            }
        ),
      ))
          .toList(),
    );
  }

  Widget _eyePassword(key, value) {
    return key == "name" ? SizedBox()
        : GestureDetector(
        onTap: (){
          _eyeIconNotifier.value = !value;
        },
        child: Icon(value ? Icons.visibility : Icons.visibility_off));
  }


}

