import 'package:flutter/material.dart';

class ProgressCircle extends StatefulWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final double fontsize;
  final double value;

  ProgressCircle(
      {this.text,
      this.color,
      this.height,
      this.width,
      this.fontsize,
      this.value});

  @override
  _ProgressCircleState createState() => _ProgressCircleState();
}

class _ProgressCircleState extends State<ProgressCircle> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 9,
            value: widget.value,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(widget.color),
          ),
          height: widget.height,
          width: widget.width,
        ),
        Positioned.fill(
          child: Container(
            child: Center(
              child: Text(
                '${widget.text}',
                style: TextStyle(fontSize: widget.fontsize),
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          top: 2,
          left: 2,
          right: 2,
          bottom: 2,
        ),
      ],
      overflow: Overflow.clip,
    );
  }
}

class ProgressBar extends StatefulWidget {
  final double value;
  final Color color;
  final String text;
  ProgressBar({this.color, this.value, this.text});

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: 188,
          height: 31,
          child: LinearProgressIndicator(
            value: widget.value,
            valueColor: AlwaysStoppedAnimation<Color>(widget.color),
            backgroundColor: Colors.white,
          ),
        ),
        Positioned.fill(
            child: Text(
              '${widget.text}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            left: 80,
            top: 4),
      ],
    );
  }
}
