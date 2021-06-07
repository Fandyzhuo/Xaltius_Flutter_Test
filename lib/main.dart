import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;

  Future<http.Response> fetchData() {
    return http.get(Uri.parse('http://localhost:8084/data/data'));
  }

  void getData() async {
    data = json.decode((await fetchData()).body);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: Center(
          child: data != null
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 240),
                  itemCount: data.length + 1 ?? 0,
                  itemBuilder: (context, i) {
                    TextStyle textStyle = TextStyle(fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal, color: Colors.white, fontSize: 24);
                    return Container(
                      decoration: BoxDecoration(border: Border.all(color: Color(0xff40454B), width: 2)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: i % 2 == 0 ? Color(0xff353A40) : Color(0xff3E4349),
                                border: Border(
                                  right: BorderSide(color: Color(0xff40454B), width: 2),
                                ),
                              ),
                              child: Text(i == 0 ? "Name" : data[i - 1]['name'], style: textStyle),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: i % 2 == 0 ? Color(0xff353A40) : Color(0xff3E4349),
                                border: Border(
                                  left: BorderSide(color: Color(0xff40454B), width: 2),
                                ),
                              ),
                              child: Text(i == 0 ? "Role" : data[i - 1]['role'], style: textStyle),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
