import 'package:GP/setting/settingpage2.dart';
import 'package:GP/styles/myColor.dart';
import 'package:flutter/material.dart';

import '../newBottomBar.dart';

class DetailsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 4;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        /*appBar: PreferredSize(
          child: AppBar(
            title: Center(child: Text("設定", style: TextStyle(fontSize: 60),)),
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
                
              ),
            ),
          ),
          preferredSize: Size.fromHeight(150.0),
        ),*/
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Center(
                      child: Text(
                    '設定',
                    style: TextStyle(fontSize: 60, color: Colors.white),
                  )),
                ],
              ),
              decoration: BoxDecoration(
                color: appbarcolor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: Offset(0, 4)),
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
              ),
              width: width,
              height: height,
            ),
            SettingPage2(),
          ],
        ),
        bottomNavigationBar: NewBottomBar(4),
      ),
    );
  }
}
