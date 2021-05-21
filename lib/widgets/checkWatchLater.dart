import 'package:GP/database/watchLaterInfo.dart';
import 'package:GP/styles/myColor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
class CheckWatchLater extends StatefulWidget {
  const CheckWatchLater({
    Key key,
    @required Future<List<WatchLaterInfo>> getWatchLater,
    @required this.widget,
  }) : _getWatchLater = getWatchLater, super(key: key);

  final Future<List<WatchLaterInfo>> _getWatchLater;
  final widget;

  @override
  _CheckWatchLaterState createState() => _CheckWatchLaterState();
}

class _CheckWatchLaterState extends State<CheckWatchLater> {
  bool watchLater;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget._getWatchLater,
        builder: (context, watchLaterSnapshot) {
          try {
            for (var r = 0;
                r < watchLaterSnapshot.data.length;
                r++) {
              if (watchLaterSnapshot
                          .data[r].eventsTitle ==
                      widget.widget.snapshot.data[widget.widget.index]
                          .data['eventsTitle'] &&
                  watchLaterSnapshot.data[r].pointsType ==
                      widget.widget.snapshot.data[widget.widget.index]
                          .data['type']) {
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
        });
  }
}