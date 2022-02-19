import 'package:flutter/material.dart';
import 'package:searching_listview/network.dart';
import 'post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> _posts = [];
  List<Post> _postsDisplay = [];

  @override
  void initState() {
    // TODO: implement initState
    fetchPost().then((value) {
      setState(() {
        _posts.addAll(value);
        _postsDisplay = _posts;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter ListView With JSON'),
      ),
      body: ListView.builder(
        itemCount: _postsDisplay.length + 1,
        itemBuilder: (BuildContext context, int index) {
          return index == 0 ? _searchBar() : _listItem(index);
        },
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _postsDisplay = _posts.where((post) {
              var postTitle = post.title!.toLowerCase();
              return postTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_postsDisplay[index].title}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              '${_postsDisplay[index].body}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
