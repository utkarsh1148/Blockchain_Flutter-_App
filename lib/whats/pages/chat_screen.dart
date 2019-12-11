import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import 'messege.dart' as mess;
import 'functions.dart' as fun;
import '../../global.dart' as glo;

void main(){
  runApp(ChatScreen());
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: glo.groupnumbers,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new ListTile(
            leading: new CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: new AssetImage("assets/images.jpg"),
              radius: 26.0,
            ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  glo.groups[i].name,
                  style: new TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17.0),
                ),
                new Text(
                  glo.groups[i].time,
                  style: new TextStyle(
                      color: Colors.grey[600], fontSize: 13.0),
                ),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                glo.groups[i].message,
                style:
                new TextStyle(color: Colors.grey[600], fontSize: 15.0),
              ),
            ),
            onTap: () {
              glo.groupnumber=i;
              fun.func();

            },
          ),
          Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: new Divider(
              height: 8.0,
              indent: 83.0,
            ),
          ),
        ],
      ),
    );
  }
}
