import 'package:flutter/material.dart';
import 'package:projeto_flexbox/com_flexbox.dart';
import 'package:projeto_flexbox/sem_flebox.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexible & Expanded',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Flexible & Expanded'),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Text('Sem FlexBox!'),
          Container(
            margin: EdgeInsets.only(top: 20,bottom: 20),
            child: SemFlexBox()
          ),
          Text('Com FlexBox!'),
          Container(
            margin: EdgeInsets.only(top: 20,bottom: 20),
            child: ComFlexBox()
          )
        ],
      )
    );
  }
}
