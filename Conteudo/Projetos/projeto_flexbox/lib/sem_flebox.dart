import 'package:flutter/material.dart';

class SemFlexBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          height: 100,
          child: Text('Item 1 - pretty big!'),
          color: Colors.red,
        ),
        Container(
          height: 100,
          child: Text('Item 2'),
          color: Colors.blue,
        ),
        Container(
          height: 100,
          child: Text('Item 3'),
          color: Colors.orange,
        ),
      ],
    );
  }
}
