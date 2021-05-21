import 'package:GP/database/dbhelper.dart';
import 'package:GP/database/historyInfo.dart';
import 'package:GP/database/watchLaterInfo.dart';
import 'package:GP/list/Pages/customDialog.dart';
import 'package:GP/styles/myColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:io' show Platform;

import 'package:google_fonts/google_fonts.dart';

class BookmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '收藏',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: appbarcolor,
        centerTitle: true,
      ),
      body: BookmarkBody(),
    );
  }
}

class BookmarkBody extends StatefulWidget {
  @override
  _BookmarkBodyState createState() => _BookmarkBodyState();
}

class _BookmarkBodyState extends State<BookmarkBody> {
  //Database
  DbHelper _dbHelper = DbHelper();
  Future<List<WatchLaterInfo>> _getWatchLater;
  Future<List<HistoryInfo>> _historyDatabase;

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
    return documents;
  }

  Future<void> _showMyDialog({onPress, String text}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text('確定刪除$text?'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            FlatButton(
              onPressed: onPress,
              child: Text('確定'),
            )
          ],
        );
      },
    );
  }

  Future<void> _showCupertinoDialog({onPress, String text}) async {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CupertinoAlertDialog(
            title: Text('確定刪除$text?'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
              CupertinoDialogAction(
                child: Text('確定'),
                onPressed: onPress,
              )
            ],
          );
        });
  }

  @override
  void initState() {
    loadWatchLater();
    loadHistory();
    _data = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool attended;
    bool watchLater;

    return FutureBuilder(
        future: _getWatchLater,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data.length == 0) {
            return Center(
                child: Text(
              '沒有收藏',
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ));
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data.length != 0) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                              eventsTitle: snapshot.data[index].eventsTitle,
                              location: snapshot.data[index].location,
                              eventsDetail: snapshot.data[index].eventsDetail,
                              organizer: snapshot.data[index].organizer,
                              pointsNum: snapshot.data[index].points,
                              startDate: snapshot.data[index].startDate,
                              endDate: snapshot.data[index].endDate,
                              pointsType: snapshot.data[index].pointsType,
                              typeInt: snapshot.data[index].typeInt,
                            ));
                    setState(() {});
                  },
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            setState(
                              () {
                                Platform.isIOS
                                    ? _showCupertinoDialog(
                                        text: '收藏',
                                        onPress: () {
                                          final snackbar =
                                              SnackBar(content: Text('已刪除'));
                                          print('delete');
                                          setState(
                                            () {
                                              _dbHelper.deleteWatchLater(
                                                  snapshot.data[index]
                                                      .watchLaterId);
                                              loadWatchLater();
                                            },
                                          );

                                          Navigator.of(context).pop();
                                          Scaffold.of(context)
                                              .showSnackBar(snackbar);
                                        },
                                      )
                                    : _showMyDialog(
                                        text: '收藏',
                                        onPress: () {
                                          final snackbar =
                                              SnackBar(content: Text('已刪除'));
                                          print('delete');
                                          setState(
                                            () {
                                              _dbHelper.deleteWatchLater(
                                                  snapshot.data[index]
                                                      .watchLaterId);
                                              loadWatchLater();
                                            },
                                          );
                                          Navigator.of(context).pop();
                                          Scaffold.of(context)
                                              .showSnackBar(snackbar);
                                        },
                                      );
                              },
                            );
                            print("deleted");
                          }),
                    ],
                    child: Card(
                      margin: EdgeInsets.only(top: 10, right: 23, left: 23),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text('${snapshot.data[index].eventsTitle}'),
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
                                  '${snapshot.data[index].pointsType}${snapshot.data[index].points}點',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, bottom: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    Text('${snapshot.data[index].location}')),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, bottom: 5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    '主辦單位：${snapshot.data[index].organizer}')),
                          ),
                          // Container(
                          //   padding: EdgeInsets.only(left: 15, bottom: 5),
                          //   child: Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Text(
                          //       '參加時間：${snapshot.data[index].currentTime}',
                          //       style: TextStyle(
                          //           fontSize: 14,
                          //           color: Colors.red,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
