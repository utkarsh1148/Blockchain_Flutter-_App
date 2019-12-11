import '../../global.dart' as glo;
import 'package:flutter/material.dart';
import 'chat_screen.dart' as cha;
import '../main.dart' as ma;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

void main(){
  runApp(MessageScreen());
}

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {


  final DatabaseReference database = FirebaseDatabase.instance.reference().child('new');
  final String url = "https://ipfs.io/ipfs/QmWxg784tG2y77qG5DmRnk621ms9RiUhHJbiB4pVwLxk7r";
  final String urll = "https://piggyapi.herokuapp.com";
  List data;
  TextEditingController _textInputController = TextEditingController();
  String _showText = "";



  Future<String> getSWData() async {
    var res =
    await http.get(Uri.parse(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody;
    });
    print(data[0]['text']);

    return "Success!";
  }


  @override

  Widget build(BuildContext context) {
    return MaterialApp(title: 'Chat Room',
    home: new Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: new AppBar(
        backgroundColor: new Color(0xff075E54),
        titleSpacing: 0.0,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new IconButton(
                  icon: new Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ), onPressed: nav),
              new CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.grey,
                backgroundImage: new AssetImage("assets/images.jpg"),
                radius: 18.0,
              ),


              new PopupMenuButton<List>(
                  padding: const EdgeInsets.all(0.0),
                  tooltip: "More options",
                  itemBuilder: (BuildContext context) =>

                  glo.Popupmenuitems

              ),
            ]
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.videocam,
              color: Colors.white,
            ),
            tooltip: "Video call",
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(
              Icons.call,
              color: Colors.white,
            ),
            tooltip: "Voice call",
            onPressed: () {},
          ),

        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                ""),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
                right: 8.0,
              ),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Flexible(
                    flex: 1,
                    child: new Container(
                      constraints: BoxConstraints(

                      ),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(const Radius.circular(5.0)),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          new Text(
                            data[1]['text'],
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                top: 8.0,
                left: 8.0,
              ),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Flexible(
                    flex: 1,
                    child: new Container(
                      constraints: BoxConstraints(

                      ),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(const Radius.circular(5.0)),
                        color: Colors.lightGreenAccent[100],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            data[0]['text'],
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      new Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
          top: 8.0,
          left: 8.0,
        ),
    child: TextFormField(
      controller: _textInputController,
      decoration: InputDecoration(
          labelText: 'Type Your Messege',
              suffix:IconButton(icon: new Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
                tooltip: "Send",
                onPressed: () {

                    _showText = _textInputController.text;
                    _textInputController.text="";
                  postData();

                },),
          prefixIcon:IconButton(icon: new Icon(
            Icons.add_a_photo,
            color: Colors.black,
          ),
            tooltip: "Add a Pic",
            onPressed: () {},),
      ),
    ),
      )
          ],
        ),
      ),
    )
    );

  }
  postData() async {

    var response = await http.post(urll, body: {'data': _showText,'gid':glo.groupnumber.toString(),'sender':glo.reci});
    print('Response status: ${response.statusCode}');
  }
  @override
  void initState() {
    super.initState();
    this.getSWData();
  }
}


void nav(){
  ma.main();
}