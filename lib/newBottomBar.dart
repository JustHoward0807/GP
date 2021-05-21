import 'package:GP/home/newHome.dart';
import 'package:GP/list/list.dart';
import 'package:GP/map/mapscreen.dart';
import 'package:GP/map/my_flutter_app_icons.dart';
import 'package:GP/setting/setting.dart';
import 'package:GP/styles/list_icon_icons.dart';
import 'package:GP/styles/myColor.dart';
import 'package:GP/write/write.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class NewBottomBar extends StatefulWidget {
  final _currentIndex;
  NewBottomBar(this._currentIndex);
  @override
  _NewBottomBarState createState() => _NewBottomBarState();
}

class _NewBottomBarState extends State<NewBottomBar> {
  int _currentIndex;
  int count = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = widget._currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: CustomNavigationBar(
        strokeColor: Colors.transparent,
        //strokeColor: YColors.lightyellow,
        unSelectedColor: Colors.white,
        selectedColor: Colors.black,
        iconSize: 40,
        backgroundColor: YColors.deepyellow,
        /*scaleFactor: 0.5,
                scaleCurve: Curves.bounceIn,*/

        items: [
          CustomNavigationBarItem(
            icon: MyFlutterApp.mapfigmaver,
          ),
          CustomNavigationBarItem(
            icon: ListIcon.listicon,
          ),
          CustomNavigationBarItem(
            icon: MyFlutterApp.home,
          ),
          CustomNavigationBarItem(
            icon: MyFlutterApp.handpoint,
          ),
          CustomNavigationBarItem(
            icon: MyFlutterApp.settingnopccu,
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => GMap()));
            /*Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => GMap()));*/
          } else if (index == 1) {
            Navigator.push(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => ListPage()));
            /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ListPage()));*/
          } else if (index == 2) {
            Navigator.push(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => NewHomePage()));
            /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NewHomePage()));*/
          } else if (index == 3) {
            Navigator.push(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => WritePage()));
            /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => WritePage()));*/
          } else {
            Navigator.push(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => SettingPage()));
            /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SettingPage()));*/
          }

          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
