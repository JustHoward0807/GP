import 'package:GP/database/dbhelper.dart';
import 'package:GP/database/historyInfo.dart';
import 'package:GP/database/watchLaterInfo.dart';
import 'package:GP/list/list.dart';
import 'package:GP/styles/myColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'customDialog.dart';

class PointsScreen extends StatefulWidget {
  final int indexNum;
  final String pointName;
  PointsScreen({this.indexNum, this.pointName});

  @override
  _PointsScreenState createState() => _PointsScreenState();
}

//ListHead()
class _PointsScreenState extends State<PointsScreen> {
  Future<List<WatchLaterInfo>> _getWatchLater;
  Future<List<HistoryInfo>> _historyDatabase;
  DbHelper _dbHelper = DbHelper();
  loadWatchLater() {
    _getWatchLater = _dbHelper.getWatchLater();
    if (mounted) setState(() {});
  }

  loadHistory() {
    _historyDatabase = _dbHelper.getHistory();
    if (mounted) setState(() {});
  }

  Future _data;
  Future getData() async {
    var firestore = Firestore.instance;
    if (widget.indexNum == 0) {
      QuerySnapshot qn = await firestore.collection("德").getDocuments();
      return qn.documents;
    } else if (widget.indexNum == 1) {
      QuerySnapshot qn = await firestore.collection("智").getDocuments();
      return qn.documents;
    } else if (widget.indexNum == 2) {
      QuerySnapshot qn = await firestore.collection("體").getDocuments();
      return qn.documents;
    } else if (widget.indexNum == 3) {
      QuerySnapshot qn = await firestore.collection("群").getDocuments();
      return qn.documents;
    } else {
      QuerySnapshot qn = await firestore.collection("美").getDocuments();
      return qn.documents;
    }
  }

  @override
  void initState() {
    super.initState();
    loadHistory();
    loadWatchLater();
    _data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: appbarcolor,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 35,
                
              ),
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ListPage()))),
          title: Text(
            '${widget.pointName}',
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
          color: bgcolor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: buildFutureBuilder(widget.indexNum)),

      //bottomNavigationBar: BottomBar(),
    );
  }

  FutureBuilder buildFutureBuilder(indexNum) {
    return FutureBuilder(
        future: _data,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (indexNum == 0) {
                      return buildGestureDetector(context, snapshot, index);
                    } else if (widget.indexNum == 1) {
                      return buildGestureDetector(context, snapshot, index);
                    } else if (widget.indexNum == 2) {
                      return buildGestureDetector(context, snapshot, index);
                    } else if (widget.indexNum == 3) {
                      return buildGestureDetector(context, snapshot, index);
                    } else if (widget.indexNum == 4) {
                      return buildGestureDetector(context, snapshot, index);
                    }
                    return null;
                  }),
            );
          }
        });
  }

  GestureDetector buildGestureDetector(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    bool attended;
    bool watchLater;
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
                  eventsTitle: snapshot.data[index].data["eventsTitle"],
                  location: snapshot.data[index].data["location"],
                  eventsDetail: snapshot.data[index].data["eventsDetail"],
                  organizer: snapshot.data[index].data["organizer"],
                  pointsNum: snapshot.data[index].data["points"],
                  startDate: snapshot.data[index].data["startTime"],
                  endDate: snapshot.data[index].data["endTime"],
                  pointsType: snapshot.data[index].data["type"],
                  typeInt: snapshot.data[index].data["typeInt"],
                  page: false,
                ));
        setState(() {});
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.only(top: 20, right: 23, left: 23),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 96,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          FutureBuilder(
                            future: _historyDatabase,
                            builder: (context, historySnapshot) {
                              try {
                                for (var r = 0;
                                    r < historySnapshot.data.length;
                                    r++) {
                                  if (historySnapshot.data[r].eventsTitle ==
                                          snapshot.data[index]
                                              .data["eventsTitle"] &&
                                      historySnapshot.data[r].pointsType ==
                                          snapshot.data[index].data["type"]) {
                                    attended = true;
                                  }
                                }
                              } catch (e) {
                                return CircularProgressIndicator();
                              }

                              return attended == true
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Container(
                                          color: Colors.lightBlueAccent,
                                          child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                '已參加',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))),
                                    )
                                  : DottedBorder(
                                      borderType: BorderType.RRect,
                                      padding: EdgeInsets.all(5),
                                      radius: Radius.circular(12),
                                      strokeWidth: 1,
                                      color: Colors.black,
                                      child: Container(
                                        child: Text(
                                          '未參加',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    );
                            },
                          ),
                          SizedBox(width: 10),
                          FutureBuilder(
                              future: _getWatchLater,
                              builder: (context, watchLaterSnapshot) {
                                try {
                                  for (var r = 0;
                                      r < watchLaterSnapshot.data.length;
                                      r++) {
                                    if (watchLaterSnapshot
                                                .data[r].eventsTitle ==
                                            snapshot.data[index]
                                                .data["eventsTitle"] &&
                                        watchLaterSnapshot.data[r].pointsType ==
                                            snapshot.data[index].data["type"]) {
                                      watchLater = true;
                                    }
                                  }
                                } catch (e) {
                                  return CircularProgressIndicator();
                                }

                                return watchLater == true
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Container(
                                            color: appbarcolor,
                                            child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                  '已收藏',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))),
                                      )
                                    : DottedBorder(
                                        borderType: BorderType.RRect,
                                        padding: EdgeInsets.all(5),
                                        radius: Radius.circular(12),
                                        strokeWidth: 1,
                                        color: Colors.black,
                                        child: Container(
                                          child: Text(
                                            '未收藏',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      );
                              })
                        ],
                      ),
                      Container(
                        width: 214,
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(snapshot.data[index].data["eventsTitle"],
                              style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(fontSize: 16)),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 58,
                    color: Colors.black,
                  ),
                  Container(
                    child: Text(
                      snapshot.data[index].data["type"] +
                          snapshot.data[index].data['points'].toString() +
                          "點",
                      style: GoogleFonts.notoSans(
                          textStyle: TextStyle(fontSize: 18),
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: deepcardcolor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),
              height: 54,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  snapshot.data[index].data["location"],
                  style: GoogleFonts.notoSans(
                      textStyle: TextStyle(fontSize: 16), color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Widget buildPointsList(
      BuildContext context, int index, int indexNum, snapshot) {
    //final points = pointsList[index];
    final points1 = pointsList1[index];
    if (indexNum == 0) {
      return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                    eventsTitle: snapshot.data[index].data["eventsTitle"],
                    location: snapshot.data[index].data["location"],
                    eventsDetail: snapshot.data[index].data["eventsDetail"],
                    organizer: snapshot.data[index].data["organizer"],
                    pointsNum: snapshot.data[index].data["points"],
                    startDate: snapshot.data[index].data["startTime"],
                    endDate: snapshot.data[index].data["endTime"],
                  ));
        },
        child: Card(
          margin: EdgeInsets.only(top: 10, right: 23, left: 23),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(snapshot.data[index].data["eventsTitle"]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 253,
                    height: 1,
                    color: Colors.black,
                  ),
                  Container(
                    child: Text(
                      "德" +
                          snapshot.data[index].data["points"].toString() +
                          "點",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    snapshot.data[index].data["location"],
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (indexNum == 1) {
      return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                    eventsTitle: snapshot.data[index].data["eventsTitle"],
                    location: snapshot.data[index].data["location"],
                    eventsDetail: snapshot.data[index].data["eventsDetail"],
                    organizer: snapshot.data[index].data["organizer"],
                    pointsNum: snapshot.data[index].data["points"],
                    startDate: snapshot.data[index].data["startTime"],
                    endDate: snapshot.data[index].data["endTime"],
                  ));
        },
        child: Card(
          margin: EdgeInsets.only(top: 10, right: 23, left: 23),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(snapshot.data[index].data["eventsTitle"]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 253,
                    height: 1,
                    color: Colors.black,
                  ),
                  Container(
                    child: Text(
                      "智" +
                          snapshot.data[index].data["points"].toString() +
                          "點",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    snapshot.data[index].data["location"],
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (indexNum == 2) {
    } else if (indexNum == 3) {
    } else {}
    /* return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
                  eventsTitle: points.eventsTitle,
                  location: points.location,
                  eventsDetail: points.eventsDetail,
                  organizer: points.organizer,
                  pointsNum: points.pointsNum,
                  startDate: points.startDate,
                  endDate: points.endDate,
                ));
      },
      child: Card(
        margin: EdgeInsets.only(top: 10, right: 23, left: 23),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(points.eventsTitle),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 253,
                  height: 1,
                  color: Colors.black,
                ),
                Container(
                  child: Text(
                    points.points,
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  points.location,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
  }*/
}
