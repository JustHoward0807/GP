import 'package:GP/setting/team_custom.dart';
import 'package:GP/styles/myColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:vibration/vibration.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  void _launchURL(_url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text('關於我們'),
              centerTitle: true,
              backgroundColor: appbarcolor,
              bottom: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(fontSize: 15),
                  indicatorColor: Colors.white,
                  indicatorWeight: 5,
                  labelColor: Colors.white,
                  onTap: (tabs) {
                    //Vibration.vibrate(duration: 100, amplitude: 80);
                    print('Tab: $tabs');
                  },
                  tabs: [
                    Tab(
                      text: '汪幸妃',
                    ),
                    Tab(
                      text: '董龍澔',
                    ),
                    Tab(
                      text: '吳玟萱',
                    ),
                    Tab(
                      text: '吳怡萱',
                    ),
                    Tab(
                      text: '陳昶屹',
                    ),
                  ])),
          body: TabBarView(children: [
            buildContainerTeam(context,
                imagePath: 'assets/Pics/0.jpg', job: '組長', text: '我是幸妃，擔任組長的職位，負責各種大小事，歡迎大家多多使用我們的APP!'),
            TeamCustomPage(),
            buildContainerTeam(context,
                imagePath: 'assets/Pics/4.jpg',
                job: '形象',
                text: '哈囉~ 我是玟萱，負責app形象的部分，歡迎大家多多使用畢點唷!'),
            buildContainerTeam(context,
                imagePath: 'assets/Pics/2.jpg',
                job: '設計',
                text: '我是怡萱，負責APP的美術設計，歡迎大家多多使用!'),
            buildContainerTeam(context,
                imagePath: 'assets/Pics/3.jpg',
                job: '行銷',
                text: '嗨～ 很高興您的使用我是 昶屹 目前主要以行政行銷希望我們的App系統功能您會喜歡'),
          ]),
        ),
      ),
    );
  }

  Container buildContainerTeam(BuildContext context,
      {String imagePath, String job, text, url, instagram}) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          )),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '$job',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      '$text',
                      style: TextStyle(fontSize: 20),
                    ),
                    ('$instagram' == null)
                        ? GestureDetector(
                            onTap: () => _launchURL(url),
                            child: Text(
                              '$instagram',
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        : Container()
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
