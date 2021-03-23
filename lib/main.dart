import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
  theme: new ThemeData.dark(),
  home: new Homepage(),
));

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => new _HomepageState();
}

class _HomepageState extends State<Homepage> {

  String url = "https://jsonplaceholder.typicode.com/posts";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future <String> getJsonData() async {
  http.Response response =  await http.get("https://swapi.dev/api/people/");
  print(response.body);

  setState(() {
    var convertDataToJson = json.decode(response.body);
    data = convertDataToJson['results'];
  });
  return "SUCCESS";

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    appBar: new AppBar(
      title: new Text("API FETCHING"),
    ),
    body: new ListView.builder(
      itemCount: data == null? 0 : data.length,
      itemBuilder: (BuildContext context,int Index){
        return new Container(
          child: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Card(
                  child: new Column(
                   children:<Widget>[
            new Text("NAME : "+data[Index]['name']),
              //new Text("HEIGHT : "+data[Index]['id']),
              ///new Text("AGE : "+data[Index]['title']),
              //new Text("GENDER : "+data[Index]['body']),
            ]

                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
    );
  }
}

