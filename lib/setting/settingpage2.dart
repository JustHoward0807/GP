import 'package:GP/setting/team.dart';
import 'package:GP/styles/myColor.dart';
import 'package:GP/styles/setting_icon_icons.dart';
import 'package:flutter/material.dart';

import '../setting/callus.dart';

class SettingPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: mainbgcolor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: Offset(0, 4)),
                ],
              ),
              width: 268,
              height: 208,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    SettingIcon.aboutus_01,
                    size: 100,
                    color: Colors.blueGrey,
                  ),
                  Text(
                    "關於我們",
                    style: TextStyle(fontSize: 50),
                  )
                ],
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return TeamPage();
              }),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            child: Container(
              width: 268,
              height: 208,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: mainbgcolor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: Offset(0, 4)),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    SettingIcon.report_01,
                    size: 100,
                    color: Colors.blueGrey,
                  ),
                  Text(
                    "問題回報",
                    style: TextStyle(fontSize: 50),
                  )
                ],
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Callus();
              }),
            ),
          ),
        ],
      ),
    );
  }
}

/*class SettingPage extends StatelessWidget {
  final String svgSrc;
  final String title;
  final String yee;
  final double number;
  const SettingPage({
    Key key,
    this.svgSrc,
    this.title,
    this.number,
    this.yee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 288,
            height: 6,
            color: YColors.deepyellow,
          ),
          SettingBtn(
            svgSrc: "assets/Icons/btnsetting.svg",
            title: "關於我們",
            yee: "傳送至關於我們",
            number: 0,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Aboutus();
                }),
              );
            },
          ),
          SettingBtn(
            svgSrc: "assets/Icons/btnsetting.svg",
            title: "聯絡我們",
            yee: "傳送至聯絡我們",
            number: 20,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Callus();
                }),
              );
            },
          )
        ],
      ),
    );
  }
}

class BodyBtn extends StatelessWidget {
  const BodyBtn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: YColors.lightyellow,
      ),
      width: 268,
      height: 180,
    );
  }
}

class SettingBtn extends StatelessWidget {
  final String svgSrc;
  final String title;
  final double number;
  final String yee;
  final Function press;
  const SettingBtn({
    Key key,
    this.svgSrc,
    this.title,
    this.number,
    this.yee,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            BodyBtn(),
            Container(
              child: Column(
                children: [
                  Container(
                    child: SvgPicture.asset(svgSrc),
                  ),
                  Container(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        margin: EdgeInsets.only(bottom: number),
      ),
      onTap: press,
    );
  }
}*/
