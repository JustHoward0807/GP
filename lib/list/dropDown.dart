import 'package:GP/list/Pages/pointsScreen.dart';
import 'package:GP/list/bookmark.dart';
import 'package:GP/list/history.dart';
import 'package:flutter/material.dart';
import '../styles/myColor.dart';

class DropDownButton extends StatefulWidget {
  DropDownButton({Key key}) : super(key: key);

  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      width: 310,
      height: 30,
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: Container(
          color: Colors.transparent,
        ),
        value: dropdownValue,
        icon: Icon(
          Icons.arrow_drop_down,
        ),
        iconSize: 30,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            switch (newValue) {
              case "德":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PointsScreen(
                            indexNum: 0,
                            pointName: "德",
                          )),
                );
                break;
              case "智":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PointsScreen(
                            indexNum: 1,
                            pointName: "智",
                          )),
                );
                break;
              case "體":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PointsScreen(
                            indexNum: 2,
                            pointName: "體",
                          )),
                );
                break;
              case "群":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PointsScreen(
                            indexNum: 3,
                            pointName: "群",
                          )),
                );
                break;
              case "美":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PointsScreen(
                            indexNum: 4,
                            pointName: "美",
                          )),
                );
                break;
            }
          });
        },
        items: <String>['德', '智', '體', '群', '美']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(fontSize: 20)),
          );
        }).toList(),
      ),
    );
  }
}

class DropContainer extends StatelessWidget {
  const DropContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appbarcolor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 1, offset: Offset(0, 2)),
        ],
      ),
      width: 310,
      height: 50,
    );
  }
}

class ListHead extends StatefulWidget {
  @override
  _ListHeadState createState() => _ListHeadState();
}

class _ListHeadState extends State<ListHead> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Stack(children: <Widget>[
        DropContainer(),
        Positioned(
          child: DropDownButton(),
          top: 10,
          left: 25,
          right: 25,
        ),
      ]),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.history),
          iconSize: 35,
          color: Colors.black,
          tooltip: "歷史紀錄",
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryPage(),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.bookmark_border),
          iconSize: 35,
          color: Colors.black,
          tooltip: "收藏",
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookmarkPage(),
            ),
          ),
        ),
      ],
    );
  }
}
