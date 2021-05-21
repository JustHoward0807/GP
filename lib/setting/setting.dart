import 'package:GP/newBottomBar.dart';
import 'package:GP/setting/common_questions.dart';
import 'package:GP/setting/team.dart';
import 'package:GP/styles/myColor.dart';
import 'package:GP/styles/setting_icon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarcolor,
        automaticallyImplyLeading: false,
        title: Text(
          '設定',
          style: TextStyle(fontSize: 36, color: black),
        ),
        centerTitle: true,
      ),
      body: SettingPageBody(),
      bottomNavigationBar: NewBottomBar(4),
    );
  }
}

class SettingPageBody extends StatefulWidget {
  @override
  _SettingPageBodyState createState() => _SettingPageBodyState();
}

class _SettingPageBodyState extends State<SettingPageBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildContainerIcon(
          context,
          Icon(
            SettingIcon.aboutus_01,
            size: 80,
            color: Colors.blueGrey,
          ),
          Text(
            '關於我們',
            style: TextStyle(fontSize: 30),
          ),
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return TeamPage();
            }),
          ),
        ),
        buildContainerIcon(
          context,
          Icon(
            SettingIcon.report_01,
            size: 80,
            color: Colors.blueGrey,
          ),
          Text(
            '問題回報',
            style: TextStyle(fontSize: 30),
          ),
          () => _launchURL('https://forms.gle/bjR56Q38LAGVtHbm7'),
        ),
        buildContainerIcon(
            context,
            Icon(
              Icons.help_outline,
              size: 80,
              color: black,
            ),
            Text(
              '常見問題',
              style: TextStyle(fontSize: 30),
            ), () {
          Navigator.push(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => QuestionsPage()));
        }),
        Container(
          width: 335,
          height: 60,
          decoration: BoxDecoration(
            color: appbarcolor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4)),
            ],
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '訊息通知',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.radio_button_checked),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildSocialIcon(
              () => _launchURL(
                  'https://www.facebook.com/%E7%95%A2%E9%BB%9Egp_pccudic-108488077724270/'),
              Image.asset(
                'assets/Icons/facebook.png',
              ),
            ),
            buildSocialIcon(
              () => _launchURL('https://www.instagram.com/pccu_gp/'),
              Image.asset('assets/Icons/instagram.png'),
            )
          ],
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: 335,
            height: 39,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  '中國文化大學 \n 資傳傳播學系 2021畢業製作 \n「畢點」',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 9, letterSpacing: 10, color: Colors.grey),
                )),
          ),
        )
      ],
    ));
  }

  Widget buildSocialIcon(Function ontap, Image icon) {
    return GestureDetector(
      onTap: ontap,
      child: Stack(children: <Widget>[
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4)),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Positioned.fill(child: icon)
      ]),
    );
  }

  Widget buildContainerIcon(
      BuildContext context, Icon icon, Text text, Function ontap) {
    return InkWell(
      onTap: ontap,
      child: Center(
        child: Container(
          width: 250,
          height: 100,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              icon,
              SizedBox(
                width: 20,
              ),
              text,
            ],
          ),
        ),
      ),
    );
  }
}

_launchURL(_url) async {
  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw 'Could not launch $_url';
  }
}
