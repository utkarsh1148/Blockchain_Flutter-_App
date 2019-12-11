import '../../global.dart' as glo;
import 'dart:core';
import '../main.dart' as mainn;
import 'package:flutter/material.dart';

class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  ChatModel({this.name, this.message, this.time, this.avatarUrl});
}

void main(){
  var num=glo.groupnumbers;
  for(int i=0;i<num;i++){
    String str = i.toString();
  glo.groups.add(new ChatModel(
      name: "Group"+str,
      message: "",
      time: "15:30",
      avatarUrl:
                 'assets/utkarsh.png'));
  }
  mainn.main();
}

List<dynamic> dummyData=glo.groups;

