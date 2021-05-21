import 'dart:io';
import 'dart:io' show Platform;
import 'package:GP/list/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../database/dbhelper.dart';
import '../database/historyInfo.dart';
import '../styles/myColor.dart';

class HistoryPage extends StatefulWidget {
  final String eventsTitle,
      location,
      points,
      eventsDetail,
      organizer,
      startDate,
      endDate,
      imagePath,
      pointsType;
  final int pointsNum;

  HistoryPage(
      {Key key,
      this.eventsTitle,
      this.location,
      this.points,
      this.eventsDetail,
      this.organizer,
      this.endDate,
      this.startDate,
      this.pointsNum,
      this.imagePath,
      this.pointsType})
      : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //Image_Picker
  //File _imageFile;
  String _imagePath;
  var _image;
  // List<File> images = List<File>();
  // List images1 = List.filled(100, 0, growable: true);
  final picker = ImagePicker();
  getImage({int index, title}) async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(source: ImageSource.camera);
    _imagePath = _image.path;
    print('The image path is $_imagePath');
    _dbHelper.updateImagePath(imagePath2: _imagePath, id: title);
    refreshList();
  }

  refreshList() {
    setState(() {
      _history = _dbHelper.getHistory();
    });
  }

  //Database
  DbHelper _dbHelper = DbHelper();
  Future<List<HistoryInfo>> _history;

  @override
  void initState() {
    _dbHelper.initializeDatabase().then((value) {
      print('database initialized');
      loadHistory();
    });
    super.initState();
  }

  void loadHistory() {
    _history = _dbHelper.getHistory();
    if (mounted) setState(() {});
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarcolor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ListPage()));
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          '歷史紀錄',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                title: Text(
                  '注意事項',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                content: Text('這些 ' "'歷史紀錄'" ' 與 ' "'點數'" ' 並不會與資訊系統連動唷!!',
                    style: TextStyle(fontSize: 20)),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 25),
                    child: FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('了解', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
                elevation: 24.0,
              ),
              barrierDismissible: false,
            ),
          ),
        ],
      ),
      body: buildContainer(context),
    );
  }

  Widget buildContainer(BuildContext context) {
    return FutureBuilder(
        future: _history,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data.length != 0) {
            return buildListView(snapshot);
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data.length == 0) {
            return Center(
                child: Text(
              '沒有歷史紀錄',
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ));
          } else {
            return Center(child: Text('Loading...'));
          }
        });
  }

  Widget buildListView(AsyncSnapshot snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
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
                              text: '紀錄',
                              onPress: () {
                                final snackbar = SnackBar(content: Text('已刪除'));
                                print('delete');
                                setState(
                                  () {
                                    // images1.removeAt(index);
                                    // images1.insert(index, 0);

                                    _dbHelper
                                        .deleteHistory(snapshot.data[index].id);
                                    loadHistory();
                                  },
                                );

                                Navigator.of(context).pop();
                                Scaffold.of(context).showSnackBar(snackbar);
                              },
                            )
                          : _showMyDialog(
                              text: '紀錄',
                              onPress: () {
                                final snackbar = SnackBar(content: Text('已刪除'));
                                print('delete');
                                setState(
                                  () {
                                    // images1.removeAt(index);
                                    // images1.insert(index, 0);
                                    _dbHelper
                                        .deleteHistory(snapshot.data[index].id);
                                    loadHistory();
                                    _dbHelper.update3(
                                        snapshot.data[index].points,
                                        ids: snapshot.data[index].pointsType,
                                        pointsTyp:
                                            snapshot.data[index].pointsType);
                                    print(
                                        '點數是: ${snapshot.data[index].pointsType}');
                                    print('點數是: $index');
                                  },
                                );
                                Navigator.of(context).pop();
                                Scaffold.of(context).showSnackBar(snackbar);
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
                    child: Text('${snapshot.data[index].eventsTitle}'),
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
                      child: Text('${snapshot.data[index].location}')),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, bottom: 5),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('主辦單位：${snapshot.data[index].organizer}')),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '參加時間：${snapshot.data[index].currentTime}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ExpansionTile(
                  title: Text('拍攝照片'),
                  children: <Widget>[
                    FutureBuilder(
                        future: _history,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: cameraImage(index, snapshot, context));
                        })
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget cameraImage(int index, AsyncSnapshot snapshot, context) {
    try {
      return (snapshot.data[index].imagePath != null)
          ? Stack(
              children: <Widget>[
                Center(child: Image.file(File(snapshot.data[index].imagePath))),
                Positioned(
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        Platform.isIOS
                            ? _showCupertinoDialog(
                                text: '照片',
                                onPress: () {
                                  final snackbar =
                                      SnackBar(content: Text('已刪除'));
                                  print('delete');
                                  setState(() {
                                    _dbHelper.deleteImagePath(
                                        id: snapshot.data[index].id);
                                    // images1.removeAt(index);
                                    // images1.insert(index, 0);
                                    print('id 是 : ${snapshot.data[index].id}');
                                    refreshList();
                                  });

                                  Navigator.of(context).pop();
                                  Scaffold.of(context).showSnackBar(snackbar);
                                })
                            : _showMyDialog(
                                text: '照片',
                                onPress: () {
                                  final snackbar =
                                      SnackBar(content: Text('已刪除'));
                                  print('delete');
                                  setState(() {
                                    _dbHelper.deleteImagePath(
                                        id: snapshot.data[index].id);
                                    // images1.removeAt(index);
                                    // images1.insert(index, 0);
                                    print('id 是 : ${snapshot.data[index].id}');
                                    refreshList();
                                  });
                                  Navigator.of(context).pop();
                                  Scaffold.of(context).showSnackBar(snackbar);
                                });
                      },
                    ),
                  ),
                  top: -170,
                  right: -180,
                  left: 0,
                  bottom: 0,
                ),
              ],
              overflow: Overflow.visible,
            )
          : Center(
              child: Opacity(
              opacity: 0.4,
              child: IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 100,
                  onPressed: () {
                    getImage(title: snapshot.data[index].id);
                    setState(() {});
                    print('id是:${snapshot.data[index].id}');
                  }),
            ));
    } catch (e) {}
    return null;
  }
}
