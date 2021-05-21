import 'package:GP/database/historyInfo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CheckHistory extends StatefulWidget {
  const CheckHistory({
    Key key,
    @required Future<List<HistoryInfo>> historyDatabase,
    @required this.widget,
  }) : _historyDatabase = historyDatabase, super(key: key);

  final Future<List<HistoryInfo>> _historyDatabase;
  final widget;
  

  @override
  _CheckHistoryState createState() => _CheckHistoryState();
}

class _CheckHistoryState extends State<CheckHistory> {
  bool attended;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._historyDatabase,
      builder: (context, historySnapshot) {
        try {
          for (var r = 0;
              r < historySnapshot.data.length;
              r++) {
            if (historySnapshot.data[r].eventsTitle ==
                    widget.widget.snapshot.data[widget.widget.index]
                        .data['eventsTitle'] &&
                historySnapshot.data[r].pointsType ==
                    widget.widget.snapshot.data[widget.widget.index]
                        .data['type']) {
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
    );
  }
}
