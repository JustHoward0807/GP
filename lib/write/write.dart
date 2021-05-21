import 'package:GP/database/dbhelper.dart';
import 'package:GP/database/trackingInfo.dart';
import 'package:GP/styles/myColor.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../list/progressCircle.dart';
import '../newBottomBar.dart';
import 'writeProgress.dart';

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  DbHelper _dbHelper = DbHelper();
  int _count0 = 0;
  int _count1 = 0;
  int _count2 = 0;
  int _count3 = 0;
  int _count4 = 0;
  Future<List<TrackingInfo>> _trackingPoints;

  @override
  void initState() {
    _dbHelper.initializeDatabase().then((value) {
      print("Database initialized");
      loadPoints();
    });
    super.initState();
  }

  void loadPoints() {
    _trackingPoints = _dbHelper.getPoints();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 3.5;
    var width = MediaQuery.of(context).size.width;

    List<int> color = [
      0xffF35151,
      0xffFF4D00,
      0xffFFC700,
      0xff0047AB,
      0xff3B9E0C
    ];
    return Scaffold(
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        FutureBuilder(
            future: _trackingPoints,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                int totalNumber = snapshot.data[0].currentPoints +
                    snapshot.data[1].currentPoints +
                    snapshot.data[2].currentPoints +
                    snapshot.data[3].currentPoints +
                    snapshot.data[4].currentPoints;
                int totalCount =
                    _count0 + _count1 + _count2 + _count3 + _count4;

                int totalSum = totalNumber + totalCount;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Center(
                          child: WriteProgessCircle(
                        currentPoints: totalSum,
                        value: totalSum / 90,
                      )),
                      decoration: BoxDecoration(
                        color: appbarcolor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                              offset: Offset(0, 4)),
                        ],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0)),
                      ),
                      width: width,
                      height: height,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    buildContainer(snapshot, color, context)
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Loading'));
              } else if (snapshot.hasError) {
                return Center(child: Text('Something wrong'));
              }
              return Center(child: Text('Loading'));
            }),
      ]),
      bottomNavigationBar: NewBottomBar(3),
    );
  }

  Container buildContainer(
      AsyncSnapshot snapshot, List<int> color, BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      Vibration.vibrate(duration: 100, amplitude: 80);
                      void increment0() {
                        setState(() {
                          if (snapshot.data[0].currentPoints <= 17) {
                            //_count0 = snapshot.data[0].currentPoints++;
                            snapshot.data[0].currentPoints += _count0 + 1;
                          }
                        });
                        _dbHelper.update(snapshot.data[0].currentPoints,
                            ids: 0);
                      }

                      increment0();
                    }),
                Spacer(),
                ProgressCircle(
                  text: "德",
                  color: Color(color[0]),
                  width: 50,
                  height: 50,
                  fontsize: 20,
                  value: snapshot.data[0].currentPoints / 18,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Vibration.vibrate(duration: 100, amplitude: 80);
                      void decrement0() {
                        setState(() {
                          if (snapshot.data[0].currentPoints != 0) {
                            snapshot.data[0].currentPoints += _count0 - 1;
                          }
                        });
                        _dbHelper.update(snapshot.data[0].currentPoints,
                            ids: 0);
                      }

                      decrement0();
                    }),
                Spacer(),
                Text(
                  '${_count0 + snapshot.data[0].currentPoints}',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
              ],
            ),
            width: 250,
            height: 50,
          ),
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Vibration.vibrate(duration: 100, amplitude: 80);
                      void increment1() async {
                        setState(() {
                          if (snapshot.data[1].currentPoints <= 17) {
                            snapshot.data[1].currentPoints += _count1 + 1;
                          }
                        });
                        _dbHelper.update(snapshot.data[1].currentPoints,
                            ids: 1);
                      }

                      increment1();
                    }),
                Spacer(),
                ProgressCircle(
                  text: "智",
                  color: Color(color[1]),
                  width: 50,
                  height: 50,
                  fontsize: 20,
                  value: snapshot.data[1].currentPoints / 18,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      void decrement1() {
                        Vibration.vibrate(duration: 100, amplitude: 80);
                        setState(() {
                          if (snapshot.data[1].currentPoints != 0) {
                            snapshot.data[1].currentPoints += _count1 - 1;
                          }
                        });
                        _dbHelper.update(snapshot.data[1].currentPoints,
                            ids: 1);
                      }

                      decrement1();
                    }),
                Spacer(),
                Text(
                  '${_count1 + snapshot.data[1].currentPoints}',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
              ],
            ),
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 2)),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      Vibration.vibrate(duration: 100, amplitude: 80);
                      void increment2() {
                        setState(() {
                          if (snapshot.data[2].currentPoints <= 17) {
                            snapshot.data[2].currentPoints += _count2 + 1;
                          }
                        });
                        _dbHelper.update(snapshot.data[2].currentPoints,
                            ids: 2);
                      }

                      increment2();
                    }),
                Spacer(),
                ProgressCircle(
                  text: "體",
                  color: Color(color[2]),
                  width: 50,
                  height: 50,
                  fontsize: 20,
                  value: snapshot.data[2].currentPoints / 18,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Vibration.vibrate(duration: 100, amplitude: 80);
                      void decrement2() {
                        setState(() {
                          if (snapshot.data[2].currentPoints != 0) {
                            snapshot.data[2].currentPoints += _count2 - 1;
                          }
                        });
                        _dbHelper.update(snapshot.data[2].currentPoints,
                            ids: 2);
                      }

                      decrement2();
                    }),
                Spacer(),
                Text(
                  '${_count2 + snapshot.data[2].currentPoints}',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
              ],
            ),
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 2)),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Vibration.vibrate(duration: 100, amplitude: 80);
                      void increment3() async {
                        setState(() {
                          if (snapshot.data[3].currentPoints <= 17) {
                            snapshot.data[3].currentPoints += _count3 + 1;
                          }
                        });
                        _dbHelper.update(snapshot.data[3].currentPoints,
                            ids: 3);
                      }

                      increment3();
                    }),
                Spacer(),
                ProgressCircle(
                  text: "群",
                  color: Color(color[3]),
                  width: 50,
                  height: 50,
                  fontsize: 20,
                  value: snapshot.data[3].currentPoints / 18,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Vibration.vibrate(duration: 100, amplitude: 80);
                      void decrement3() {
                        setState(() {
                          if (snapshot.data[3].currentPoints != 0) {
                            snapshot.data[3].currentPoints += _count3 - 1;
                          }
                        });
                        _dbHelper.update(snapshot.data[3].currentPoints,
                            ids: 3);
                      }

                      decrement3();
                    }),
                Spacer(),
                Text(
                  '${_count3 + snapshot.data[3].currentPoints}',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
              ],
            ),
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 2)),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Vibration.vibrate(duration: 100, amplitude: 80);
                      void increment4() async {
                        setState(() {
                          if (snapshot.data[4].currentPoints <= 17) {
                            snapshot.data[4].currentPoints += _count4 + 1;
                          }
                        });
                        _dbHelper.update(snapshot.data[4].currentPoints,
                            ids: 4);
                      }

                      increment4();
                    }),
                Spacer(),
                ProgressCircle(
                  text: "美",
                  color: Color(color[4]),
                  width: 50,
                  height: 50,
                  fontsize: 20,
                  value: snapshot.data[4].currentPoints / 18,
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Vibration.vibrate(duration: 100, amplitude: 80);
                      void decrement4() {
                        setState(() {
                          if (snapshot.data[4].currentPoints != 0) {
                            snapshot.data[4].currentPoints += _count4 - 1;
                          }
                        });
                        _dbHelper.update(snapshot.data[4].currentPoints,
                            ids: 4);
                      }

                      decrement4();
                    }),
                Spacer(),
                Text(
                  '${_count4 + snapshot.data[4].currentPoints}',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
              ],
            ),
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 2)),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: mainbgcolor,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: Offset(0, 4)),
        ],
      ),
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 1.9,
    );
  }
}

/*
  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Center(child: WriteProgessCircle(currentPoints: "10",value: .5,)),
            decoration: BoxDecoration(
              color: appbarcolor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4)),
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
            ),
            width: width,
            height: height,
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                WriteButton(
                  text: "德",
                  color: Color(0xffF35151),
                  width: 50,
                  height: 50,
                  fontsize: 20,
                ),
                WriteButton(
                  text: "智",
                  color: Color(0xffFF4D00),
                  width: 50,
                  height: 50,
                  fontsize: 20,
                ),
                WriteButton(
                  text: "體",
                  color: Color(0xffFFC700),
                  width: 50,
                  height: 50,
                  fontsize: 20,
                ),
                WriteButton(
                  text: "群",
                  color: Color(0xff0047AB),
                  width: 50,
                  height: 50,
                  fontsize: 20,
                ),
                WriteButton(
                  text: "美",
                  color: Color(0xff3B9E0C),
                  width: 50,
                  height: 50,
                  fontsize: 20,
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: mainbgcolor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4)),
              ],
            ),
            width: 318,
            height: 430,
          ),
        ],
      ),








class WriteButton extends StatefulWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final double fontsize;
  final double value;
  final int count;

  WriteButton(
      {this.text,
      this.color,
      this.height,
      this.width,
      this.fontsize,
      this.value,
      this.count});

  @override
  _WriteButtonState createState() => _WriteButtonState();
}

class _WriteButtonState extends State<WriteButton> {
  int _count = 0;
  increment() {
    setState(() {
      _count++;
    });
  }

  decrement() {
    setState(() {
      if (_count != 0) {
        _count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                increment();
              }),
          Spacer(),
          ProgressCircle(
            text: widget.text,
            color: widget.color,
            width: widget.width,
            height: widget.height,
            fontsize: widget.fontsize,
            value: widget.value,
          ),
          Spacer(),
          IconButton(icon: Icon(Icons.remove), onPressed: () => decrement()),
          Spacer(),
          Text(
            '${widget.count}',
            style: TextStyle(fontSize: 20),
          ),
          Spacer(),
        ],
      ),
      width: 250,
      height: 50,
      color: Colors.white,
    );
  }
}*/
