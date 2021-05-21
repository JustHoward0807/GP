import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamCustomPage extends StatefulWidget {
  @override
  _TeamCustomPageState createState() => _TeamCustomPageState();
}

class _TeamCustomPageState extends State<TeamCustomPage> {
  bool _light = true;

  onSwitch(bool _dark) {
    setState(() {
      _light = _dark;
    });
  }

  void _launchURL(_url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _light == true ? Colors.white38 : Colors.black87,
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                  child: Image.asset(
                'assets/Pics/1.jpg',
                fit: BoxFit.contain,
              )),
              Positioned(
                  child: Platform.isIOS
                      ? CupertinoSwitch(
                          value: _light,
                          onChanged: (_dark) {
                            onSwitch(_dark);
                          })
                      : Switch(
                          value: _light,
                          onChanged: (_dark) {
                            onSwitch(_dark);
                          }))
            ]),
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
                        '程式',
                        style: TextStyle(
                            color:
                                _light == false ? Colors.white : Colors.black,
                            fontSize: 24),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              '我是龍澔，負責APP的程式，謝謝你使用我們的APP',
                              style: TextStyle(
                                  color: _light == false
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () =>
                            _launchURL('https://www.instagram.com/howard_.t/'),
                        child: Text(
                          'IG: howard_.t',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ),
                      _light == false
                          ? Text(
                              'Dark Mode 萬歲',
                              style: TextStyle(
                                  color: _light == false
                                      ? Colors.yellow
                                      : Colors.black,
                                  fontSize: 20),
                            )
                          : Container(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
