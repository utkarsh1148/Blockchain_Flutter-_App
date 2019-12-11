import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'global.dart' as glo;


void main() {
  runApp(MaterialApp(
    home: StarWarsData(),
  ));
}

class StarWarsData extends StatefulWidget {
  @override
  StarWarsState createState() => StarWarsState();
}

class StarWarsState extends State<StarWarsData> {
  final String url = "https://ipfs.io/ipfs/QmWxg784tG2y77qG5DmRnk621ms9RiUhHJbiB4pVwLxk7r";
  List data;

  Future<String> getSWData() async {
    var res =
    await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody;
    });
    print(data[0]['text']);
    for(int i=0;i<data.length;i++){
      if(data[i]['senderAddress']==glo.reci){
  print("right");
      }
      else{
        print("left");
      }
    }
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hit"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Text('Api Hit')
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}
