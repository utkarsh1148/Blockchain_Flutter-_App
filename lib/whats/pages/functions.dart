import '../../global.dart' as glo;
import 'package:flutter/material.dart';
import 'messege.dart' as mess;

void func(){

glo.Popupmenuitems=[];
  for(int j=0;j<glo.information[glo.groupnumber].members.length;j++)
  {
    print(j);
    glo.Popupmenuitems.add(new PopupMenuItem(
      child:
      Text(glo.information[glo.groupnumber].members[j]),
    )
    );
  }
  print(glo.Popupmenuitems[0]);
  mess.main();
}