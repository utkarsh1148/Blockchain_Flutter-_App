import 'package:flutter/material.dart';
import 'contract.dart' as cont;
import 'global.dart' as glo;

void main() {
  runApp(MaterialApp(
    title: 'Flutter',
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() {
    return _FirstScreenState();
  }
}

class _FirstScreenState extends State<FirstScreen> {

  // this allows us to access the TextField text
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
          debugShowCheckedModeBanner: false,
        title: 'First Page',
          theme: new ThemeData(
            primaryColor: new Color(0xff075E54),
            accentColor: new Color(0xff075E54),
          ),

        home: Scaffold(
          appBar: AppBar(title: Text('Whisper Chat Room')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(32.0),
                child: TextFormField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Private Key'
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),

              RaisedButton(
                child: Text(
                  'Send',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  glo.key=textFieldController.text;
                  print(glo.key);
                  Navigator.pop(context,cont.main());
                },
              )

            ],
          ),
        )
      );

  }
}

