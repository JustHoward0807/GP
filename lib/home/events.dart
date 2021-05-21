import 'package:GP/database/dbhelper.dart';
import 'package:GP/database/historyInfo.dart';
import 'package:GP/database/watchLaterInfo.dart';
import 'package:GP/home/newHome.dart';
import 'package:GP/widgets/checkHistory.dart';
import 'package:GP/widgets/checkWatchLater.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../list/Pages/customDialog.dart';
import '../styles/myColor.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Future _data;

  Future getData() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("德").getDocuments();
    QuerySnapshot qn2 = await firestore.collection("智").getDocuments();
    QuerySnapshot qn3 = await firestore.collection("體").getDocuments();
    QuerySnapshot qn4 = await firestore.collection("群").getDocuments();
    QuerySnapshot qn5 = await firestore.collection("美").getDocuments();

    List documents = qn.documents +
        qn2.documents +
        qn3.documents +
        qn4.documents +
        qn5.documents;
    // documents.shuffle();
    return documents;
  }

  @override
  void initState() {
    _data = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbarcolor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 35,
              color: Colors.white,
              onPressed: () => Navigator.pushReplacement(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => NewHomePage()))),
          title: Text(
            '活動',
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: bgcolor,
          child: FutureBuilder(
              future: _data,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          // buildPointsList(context, index, snapshot),
                          EventsList(index, snapshot));
                }
              }),
        ));
  }

  Widget buildPointsList(BuildContext context, int index, snapshot) {
    bool ww;
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
                  eventsTitle: snapshot.data[index].data['eventsTitle'],
                  location: snapshot.data[index].data['location'],
                  eventsDetail: snapshot.data[index].data['eventsDetail'],
                  organizer: snapshot.data[index].data['organizer'],
                  pointsNum: snapshot.data[index].data['points'],
                  startDate: snapshot.data[index].data['startTime'],
                  endDate: snapshot.data[index].data['endTime'],
                  pointsType: snapshot.data[index].data['type'],
                  typeInt: snapshot.data[index].data['typeInt'],
                  page: true,
                ));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.only(top: 10, right: 23, left: 23),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              //width: 10,
              height: 96,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      width: 214,
                      height: 50,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            snapshot.data[index].data["eventsTitle"],
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ))),
                  Container(
                    width: 1,
                    height: 58,
                    color: Colors.black,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      (ww == true)
                          ? IconButton(
                              icon: Icon(Icons.bookmark),
                              onPressed: () {
                                setState(() {
                                  print('ddd');
                                });
                                ww = false;
                              })
                          : IconButton(
                              icon: Icon(Icons.bookmark_border),
                              onPressed: () {
                                setState(() {
                                  print('ddd');
                                });
                                ww = true;
                              }),
                      Container(
                        child: Text(
                          snapshot.data[index].data["type"] +
                              snapshot.data[index].data['points'].toString() +
                              "點",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventsList extends StatefulWidget {
  final int index;
  final AsyncSnapshot snapshot;
  EventsList(this.index, this.snapshot);

  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  bool watchLater;
  DbHelper _dbHelper = DbHelper();
  Future<List<WatchLaterInfo>> _getWatchLater;
  Future<List<HistoryInfo>> _historyDatabase;
  bool attended;
  loadWatchLater() {
    _getWatchLater = _dbHelper.getWatchLater();
    if (mounted) setState(() {});
  }

  loadHistory() {
    _historyDatabase = _dbHelper.getHistory();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadWatchLater();
    loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
                  eventsTitle:
                      widget.snapshot.data[widget.index].data['eventsTitle'],
                  location: widget.snapshot.data[widget.index].data['location'],
                  eventsDetail:
                      widget.snapshot.data[widget.index].data['eventsDetail'],
                  organizer:
                      widget.snapshot.data[widget.index].data['organizer'],
                  pointsNum: widget.snapshot.data[widget.index].data['points'],
                  startDate:
                      widget.snapshot.data[widget.index].data['startTime'],
                  endDate: widget.snapshot.data[widget.index].data['endTime'],
                  pointsType: widget.snapshot.data[widget.index].data['type'],
                  typeInt: widget.snapshot.data[widget.index].data['typeInt'],
                ));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.only(top: 10, right: 23, left: 23),
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
                          CheckHistory(historyDatabase: _historyDatabase, widget: widget),
                          SizedBox(width:10),
                          CheckWatchLater(getWatchLater: _getWatchLater, widget: widget)
                        ],
                      ),
                      Container(
                          width: 214,
                          height: 50,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.snapshot.data[widget.index]
                                    .data["eventsTitle"],
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ))),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 58,
                    color: Colors.black,
                  ),
                  Container(
                    child: Text(
                      widget.snapshot.data[widget.index].data["type"] +
                          widget.snapshot.data[widget.index].data['points']
                              .toString() +
                          "點",
                      style: TextStyle(
                          fontSize: 18,
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
                  widget.snapshot.data[widget.index].data["location"],
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



