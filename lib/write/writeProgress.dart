import 'package:flutter/material.dart';
import '../styles/myColor.dart';

class WriteProgessCircle extends StatefulWidget {
  final int currentPoints;
  final double value;

  WriteProgessCircle({this.currentPoints,this.value});

  @override
  _WriteProgessCircleState createState() => _WriteProgessCircleState();
}

class _WriteProgessCircleState extends State<WriteProgessCircle> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Center(
              child: Text(
            '${widget.currentPoints}',
            style: TextStyle(fontSize: 55, color: Colors.black),
          )),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffFFF4CF),
          ),
          width: 140,
          height: 140,
        ),
        Positioned(
          child: CircularProgressIndicator(
            strokeWidth: 9,
            value: widget.value,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(appbarcolor),
          ),
          width: 120,
          height: 120,
          top: 10,
          left: 10,
        ),
      ],
    );
  }
}
