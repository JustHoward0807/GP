import 'package:GP/database/watchLaterInfo.dart';
import 'package:GP/home/events.dart';

import '../../database/dbhelper.dart';
import 'package:GP/list/history.dart';
import '../../database/historyInfo.dart';
import 'package:GP/styles/myColor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CustomDialog extends StatefulWidget {
  final String eventsTitle,
      location,
      points,
      eventsDetail,
      organizer,
      startDate,
      endDate,
      pointsType;
  final int pointsNum;
  final int typeInt;
  bool page = true;
  
  CustomDialog(
      {Key key,
      this.eventsTitle,
      this.location,
      this.points,
      this.eventsDetail,
      this.organizer,
      this.endDate,
      this.startDate,
      this.pointsNum,
      this.pointsType,
      this.typeInt,this.page})
      : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  DbHelper _dbHelper = DbHelper();
  Future<List<HistoryInfo>> _historyDatabase;
  Future<List<WatchLaterInfo>> _getWatchLater;
  String button = '參加';
  bool attended;
  bool watchLater;
  bool page;
  @override
  void initState() {
    super.initState();
    loadHistory();
    loadWatchLater();
  }

  void loadHistory() {
    _historyDatabase = _dbHelper.getHistory();
    if (mounted) setState(() {});
  }

  loadWatchLater() {
    _getWatchLater = _dbHelper.getWatchLater();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: 327,
          height: 533,
          child: ListView(shrinkWrap: true, children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 27, right: 23, left: 23),
                  child: Text(
                    '活動名稱：',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, right: 23, left: 23),
                  child: Text('${widget.eventsTitle}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27, right: 23, left: 23),
                  child: Text(
                    '地點：',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, right: 23, left: 23),
                  child: Text('${widget.location}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27, right: 23, left: 23),
                  child: Text(
                    '內容：',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, right: 23, left: 23),
                  child: Text('${widget.eventsDetail}'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 27, right: 15, left: 23),
                      child: Text(
                        '主辦單位：\n${widget.organizer}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 27, right: 35, left: 0),
                      child: Text("${widget.pointsType}${widget.pointsNum}點",
                          style: TextStyle(fontSize: 24, color: Colors.red)),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 27, right: 23, left: 23, bottom: 27),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '開始/結束日期：\n${widget.startDate}\n${widget.endDate}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 27, right: 10, left: 25, bottom: 0),
                          child: FutureBuilder(
                              future: _getWatchLater,
                              builder: (context, watchLaterSnapshot) {
                                try {
                                  for (var b = 0;
                                      b < watchLaterSnapshot.data.length;
                                      b++) {
                                    if (watchLaterSnapshot
                                            .data[b].eventsTitle ==
                                        widget.eventsTitle) {
                                      watchLater = true;
                                    }
                                  }
                                } catch (Error) {
                                  return CircularProgressIndicator();
                                }

                                return watchLater == true
                                    ? RaisedButton(
                                        onPressed: null,
                                        child: Text(
                                          '已收藏',
                                        ),
                                      )
                                    : RaisedButton(
                                        splashColor: appbarcolor,
                                        onPressed: () {
                                          var watchLaterInfo = WatchLaterInfo(
                                            eventsTitle:
                                                '${widget.eventsTitle}',
                                            location: '${widget.location}',
                                            points: widget.pointsNum,
                                            organizer: '${widget.organizer}',
                                            pointsType: '${widget.pointsType}',
                                            eventsDetail: '${widget.eventsDetail}',
                                            startDate: '${widget.startDate}',
                                            endDate: '${widget.endDate}',
                                            typeInt: widget.typeInt,
                                          );
                                          _dbHelper
                                              .insertWatchLater(watchLaterInfo);
                                          
                                          (widget.page = false) ?
                                          Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      EventsPage())):
                                          Container();

                                          setState(() {
                                            watchLater = true;
                                          });
                                        },
                                        child: Text('收藏'),
                                        color: Colors.white,
                                      );
                              }),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 0, right: 10, left: 25, bottom: 27),
                            child: FutureBuilder(
                                future: _historyDatabase,
                                builder: (context, snapshot) {
                                  try {
                                    for (var r = 0;
                                        r < snapshot.data.length;
                                        r++) {
                                      if (snapshot.data[r].eventsTitle ==
                                          widget.eventsTitle) {
                                        attended = true;
                                      }
                                    }
                                  } catch (e) {
                                    return CircularProgressIndicator();
                                  }

                                  return attended == true
                                      ? RaisedButton(
                                          onPressed: null,
                                          child: Text(
                                            '已參加',
                                          ),
                                        )
                                      : RaisedButton(
                                          splashColor: appbarcolor,
                                          onPressed: () {
                                            if (snapshot.hasData) {
                                              print(
                                                  'Total Data: ${snapshot.data.length}');
                                              if (snapshot.data.length >= 0) {
                                                for (var i = 0;
                                                    i < snapshot.data.length;
                                                    i++) {
                                                  if (snapshot.data[i]
                                                          .eventsTitle ==
                                                      widget.eventsTitle) {
                                                    print('Same Record');
                                                    return null;
                                                  }
                                                }
                                                //Database
                                                DateTime now = DateTime.now();
                                                String newNow = DateFormat(
                                                        'yyyy-MM-dd – hh:mm')
                                                    .format(now);
                                                var historyInfo = HistoryInfo(
                                                  eventsTitle:
                                                      '${widget.eventsTitle}',
                                                  location:
                                                      '${widget.location}',
                                                  points: widget.pointsNum,
                                                  organizer:
                                                      '${widget.organizer}',
                                                  pointsType:
                                                      '${widget.pointsType}',
                                                  currentTime: newNow,
                                                  
                                                );
                                                _dbHelper
                                                    .insertHistory(historyInfo);
                                                _dbHelper.update2(
                                                    widget.pointsNum,
                                                    ids: widget.typeInt);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HistoryPage(
                                                            eventsTitle:
                                                                '${widget.eventsTitle}',
                                                            location:
                                                                '${widget.location}',
                                                            points:
                                                                '${widget.pointsNum}',
                                                            organizer:
                                                                '${widget.organizer}',
                                                            startDate:
                                                                '${widget.startDate}',
                                                          )),
                                                );
                                              }
                                            }
                                          },
                                          child: Text(button),
                                          color: Colors.white,
                                        );
                                })),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ]),
        ));
  }
}
