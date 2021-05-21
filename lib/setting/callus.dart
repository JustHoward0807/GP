import 'package:GP/styles/myColor.dart';
import 'package:flutter/material.dart';
//import 'package:GP/list/bottomBar.dart';

class Callus extends StatelessWidget {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              iconSize: 30,
            ),
            title: Text(
              '問題回報',
              style: TextStyle(fontSize: 40),
            ),
            centerTitle: true,
            backgroundColor: appbarcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(150.0),
        ),
        body: CallusPage(),
        //bottomNavigationBar: BottomBar(),
      ),
    );
  }
}

class CallusPage extends StatelessWidget {
  final String svgSrc;
  final String title;
  final String yee;
  final double number;
  const CallusPage({
    Key key,
    this.svgSrc,
    this.title,
    this.number,
    this.yee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 288,
              height: 6,
              color: YColors.deepyellow,
              margin: EdgeInsets.only(top: 20, bottom: 20),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              width: 320,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                color: YColors.deepyellow,
              ),
              child: Text(
                '聯絡我們',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              width: 320,
              height: 300,
              child: TextField(
                maxLines: 15,
                decoration: InputDecoration(
                    fillColor: YColors.lightyellow,
                    filled: true,
                    contentPadding: EdgeInsets.all(20.0),
                    enabledBorder: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: YColors.lightyellow,
                        )),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: YColors.deepyellow,
                        ))),
              ),
            ),
            Container(
              width: 107,
              height: 32,
              child: RaisedButton(
                onPressed: btnClickEvent,
                child: Text(
                  '確認送出',
                  style: TextStyle(fontSize: 18),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                color: YColors.deepyellow,
              ),
              margin: EdgeInsets.only(top: 20),
            ),
          ],
        ),
      ),
    );
  }

  void btnClickEvent() {
    print('已送出');
  }
}
