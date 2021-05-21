import 'package:GP/home/home.dart';
import 'package:GP/list/list.dart';
import 'package:GP/setting/details_screen.dart';
//import 'package:GP/styles/myIcon.dart';
import 'package:GP/write/write.dart';
import 'package:flutter/material.dart';
import '../styles/myColor.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import '../map/mapscreen.dart';
import '../styles/bar_icon_icons.dart';

class BottomBar extends StatefulWidget {
  final bool isSelected;
  BottomBar({this.isSelected});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedItemIndex;
  int index;
  @override
  void initState() { 
    super.initState();
    setState(() {
            _selectedItemIndex = index;
          });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 90,
          color: appbarcolor,
        ),
        Positioned(
          child: Stack(
            children: <Widget>[
              Row(children: <Widget>[
                buildBottomBar(
                    Icon(
                      BarIcon.mapfigmaver_01,
                      size: 40,
                      color: Colors.white,
                    ),
                    0,
                    GMap()),
                buildBottomBar(
                    Icon(
                      BarIcon.handpoint_01,
                      size: 40,
                      color: Colors.white,
                    ),
                    1,
                    ListPage()),
                buildBottomBar(
                    Icon(
                      BarIcon.homenew2_01,
                      size: 40,
                      color: Colors.white,
                    ),
                    2,
                    HomePage()),
                buildBottomBar(
                    Icon(
                      BarIcon.pennofont_01,
                      size: 40,
                      color: Colors.white,
                    ),
                    3,
                    WritePage()),
                buildBottomBar(
                  Icon(
                    BarIcon.settingnopccu_01_01,
                    size: 40,
                    color: Colors.white,
                  ),
                  4,
                  DetailsScreen(),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBottomBar(Icon icon, int index, page) {
    return GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => page));
              
          setState(() {
            _selectedItemIndex = index;
          });
          
          print("success");
        },
        
        child: Stack(children: <Widget>[
          Container(
            child: icon,
            width: MediaQuery.of(context).size.width / 5,
            height: 90,
            
          ),
          
          Positioned(
            //todo: AnimationContainer
            child: AnimatedContainer(
        
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                color: Color(0xff204051),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50.0),
                  bottomLeft: Radius.circular(50.0),
                ),
              )
            : BoxDecoration(),
        width: MediaQuery.of(context).size.width,
        height: 5,
        duration: Duration(milliseconds: 100),
        
      ),
            
            top: 0,
            left: 10,
            right: 10,
          )
        ]));
  }

}