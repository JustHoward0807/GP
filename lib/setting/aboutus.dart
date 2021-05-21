import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:GP/styles/myColor.dart';
//import 'package:GP/list/bottomBar.dart';

class Aboutus extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=> Navigator.pop(context), iconSize: 30,),
          title: Text('關於我們',style: TextStyle(fontSize:40),),
          centerTitle: true,
          backgroundColor: appbarcolor,
          /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),*/
        ),
        preferredSize: Size.fromHeight(70.0),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: AboutusPage(),
          ),
        ],
      )),
      //bottomNavigationBar: BottomBar(),
    );
  }
}

class AboutusPage extends StatelessWidget {
  final String svgSrc;
  final String title;
  final String yee;
  final double number;
  const AboutusPage({
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
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /*Container(
            width: 288,
            height: 6,
            color: YColors.deepyellow,
          ),*/
          BodyBtnBlue(
            svgSrc: 'assets/mainicons/newmap1.svg',
            title: '董龍澔',
          ),
          BodyBtnBlue(
            svgSrc: 'assets/mainicons/newmap1.svg',
            title: '陳昶屹',
          ),
          BodyBtnPink(
            svgSrc: 'assets/mainicons/newmap1.svg',
            title: '汪幸妃',
          ),
          BodyBtnPink(
            svgSrc: 'assets/mainicons/newmap1.svg',
            title: '吳怡萱',
          ),
          BodyBtnPink(
            svgSrc: 'assets/mainicons/newmap1.svg',
            title: '吳玟萱',
          ),
        ],
      ),
    );
  }

  void btnClickEvent() {
    print('已送出');
  }
}

class BodyBtnBlue extends StatelessWidget {
  final String svgSrc;
  final String title;
  const BodyBtnBlue({Key key, this.svgSrc, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 316,
      height: 100,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  color: YColors.deepblue,
                ),
                width: 110,
                height: 110,
              ),
              Container(
                child: SvgPicture.asset(svgSrc),
                width: 87,
                height: 87,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 24),
            ),
            width: 206,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              color: YColors.lightblue,
            ),
          )
        ],
      ),
    );
  }
}

class BodyBtnPink extends StatelessWidget {
  final String svgSrc;
  final String title;
  const BodyBtnPink({Key key, this.svgSrc, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 316,
      height: 110,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  color: YColors.deeppink,
                ),
                width: 110,
                height: 110,
              ),
              Container(
                child: SvgPicture.asset(svgSrc),
                width: 87,
                height: 87,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 24),
            ),
            width: 206,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              color: YColors.lightpink,
            ),
          )
        ],
      ),
    );
  }
}
