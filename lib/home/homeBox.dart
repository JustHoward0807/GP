import 'package:GP/list/list.dart';
import 'package:GP/map/mapscreen.dart';
import 'package:GP/setting/details_screen.dart';
import 'package:GP/styles/home_icon_icons.dart';
import 'package:GP/styles/list_icon_icons.dart';
import 'package:GP/styles/myColor.dart';
import 'package:GP/write/write.dart';
import 'package:flutter/material.dart';

import '../styles/bar_icon_icons.dart';

class HomeBox extends StatelessWidget {
  const HomeBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: 246,
      height: 82,
    );
  }
}

class TopStackBox1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        HomeBox(),
        Positioned(
          child: buildGestureDetector(context),
          top: -6,
          left: -6,
        ),
      ],
      overflow: Overflow.visible,
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return GMap();
        }),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: appbarcolor,
            ),
            width: 246,
            height: 82,
          ),
          Positioned(
            child: Row(
              children: <Widget>[
                Icon(
                  BarIcon.mapfigmaver_01,
                  size: 90,
                ),
                SizedBox(width: 40),
                Text(
                  "地圖",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            top: -10,
            left: 5,
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}

class TopStackBox2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        HomeBox(),
        Positioned(
          child: buildGestureDetector(context),
          top: -6,
          left: -6,
        ),
      ],
      overflow: Overflow.visible,
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ListPage();
        }),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: appbarcolor,
            ),
            width: 246,
            height: 82,
          ),
          Positioned(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Icon(
                    ListIcon.listicon,
                    size: 70,
                  ),
                ),
                SizedBox(width: 28),
                Text(
                  "全人點數",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            top: -5,
            left: -30,
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}

class TopStackBox3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        HomeBox(),
        Positioned(
          child: buildGestureDetector(context),
          top: -6,
          left: -6,
        ),
      ],
      overflow: Overflow.visible,
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return WritePage();
        }),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: appbarcolor,
            ),
            width: 246,
            height: 82,
          ),
          Positioned(
            child: Row(
              children: <Widget>[
                Icon(
                  BarIcon.handpoint_01,
                  size: 80,
                ),
                SizedBox(width: 20),
                Text(
                  "手動輸入",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            top: 0,
            left: 15,
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}

class TopStackBox4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        HomeBox(),
        Positioned(
          child: buildGestureDetector(context),
          top: -6,
          left: -6,
        ),
      ],
      overflow: Overflow.visible,
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return DetailsScreen();
        }),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: appbarcolor,
            ),
            width: 246,
            height: 82,
          ),
          Positioned(
            child: Row(
              children: <Widget>[
                Icon(
                  HomeIcon.pccusetting_01__2_,
                  size: 100,
                ),
                SizedBox(width: 30),
                Text(
                  "設定",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            top: -10,
            left: 10,
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}
