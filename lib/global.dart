import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';


var key='jjhuh';
List<dynamic> data=[4,5];
int groupnumbers=4;
List<dynamic> groups=[];
class info {
  final int gid;
  final List members;

  info({this.gid, this.members});
}
List information=[];
int groupnumber=0;
List<dynamic> participants=[];
List<PopupMenuEntry<List<dynamic>>> Popupmenuitems=[];
var reci='0x6DA427b41fA5cE294d67340b903098DF6b1cfF60';