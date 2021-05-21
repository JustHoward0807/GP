import 'package:GP/database/dbhelper.dart';
import 'package:GP/home/events.dart';
import 'package:GP/list/Pages/customDialog.dart';
import 'package:GP/list/list.dart';
import 'package:GP/map/mapscreen.dart';
import 'package:GP/setting/setting.dart';
import 'package:GP/styles/bar_icon_icons.dart';
import 'package:GP/styles/home_icon_icons.dart';
import 'package:GP/styles/list_icon_icons.dart';
import 'package:GP/styles/myColor.dart';
import 'package:GP/write/write.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class NewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appbarcolor,
        title: Icon(
          BarIcon.homenew2_01,
          size: 40,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: NewHomeBody(),
    );
  }
}

class NewHomeBody extends StatefulWidget {
  @override
  _NewHomeBodyState createState() => _NewHomeBodyState();
}

class _NewHomeBodyState extends State<NewHomeBody> {
  Future _data;
  DbHelper _dbHelper = DbHelper();
  Future<int> _getCount() async {
    final prefs = await SharedPreferences.getInstance();
    final startUpNumber = prefs.getInt('startUpNumber');
    if (startUpNumber == null) {
      return 0;
    }
    return startUpNumber;
  }

  @override
  void initState() {
    super.initState();
    _data = getData();
    _dbHelper
        .initializeDatabase()
        .then((value) => print("Database initialized"));
    _incrementStartUp();
  }

  Future<void> _incrementStartUp() async {
    final prefs = await SharedPreferences.getInstance();
    int lastStartUpNumber = await _getCount();
    int currentStartUpnumber = lastStartUpNumber + 1;
    await prefs.setInt('startUpNumber', currentStartUpnumber);
    if (currentStartUpnumber == 1) {
      await _dbHelper.insertTrackingDatabase();
      print(currentStartUpnumber);
      //print(_dbHelper.insertTrackingDatabase());
    } else {
      return null;
    }
  }

  Future getData() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("德").getDocuments();
    QuerySnapshot qn2 = await firestore.collection("智").getDocuments();
    QuerySnapshot qn3 = await firestore.collection("體").getDocuments();
    QuerySnapshot qn4 = await firestore.collection("群").getDocuments();
    QuerySnapshot qn5 = await firestore.collection("美").getDocuments();

    List documents = qn.documents +
        qn2.documents +
        qn3.documents +
        qn4.documents +
        qn5.documents;
    documents.shuffle();
    return documents;
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context);
    return ListView(shrinkWrap: true, children: <Widget>[
      Column(children: <Widget>[
        Container(
            decoration: BoxDecoration(
              color: appbarcolor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4)),
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
            ),
            height: 250.0,
            width: MediaQuery.of(context).size.width,
            child: Carousel(
              images: [
                Image.asset('assets/Pics/slider2.PNG'),
                Image.asset('assets/Pics/slider1.png'),
                Image.asset('assets/Pics/slider.PNG'),
                Image.asset('assets/Pics/slider4.jpg'),
                Image.asset('assets/Pics/slider5.png'),
              ],
              autoplayDuration: Duration(seconds: 8),
              animationCurve: Curves.easeInOut,
              boxFit: BoxFit.contain,
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.lightGreenAccent,
              dotIncreasedColor: Colors.black54,
              indicatorBgPadding: 5.0,
              dotBgColor: Colors.transparent,
              borderRadius: true,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildIconButton(
                  Icon(
                    BarIcon.mapfigmaver_01,
                    size: 50,
                    color: black,
                  ),
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return GMap();
                        }),
                      )),
              buildIconButton(
                Icon(
                  ListIcon.listicon,
                  size: 50,
                  color: black,
                ),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ListPage();
                  }),
                ),
              ),
              buildIconButton(
                Icon(
                  BarIcon.handpoint_01,
                  size: 50,
                  color: black,
                ),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return WritePage();
                  }),
                ),
              ),
              buildIconButton(
                Icon(
                  HomeIcon.pccusetting_01__2_,
                  size: 60,
                  color: black,
                ),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SettingPage();
                  }),
                ),
              ),
            ],
          ),
        ),
        Container(
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EventsPage())),
              child: Row(
                children: <Widget>[
                  Text("推薦活動",
                      style: GoogleFonts.notoSans(
                          textStyle: TextStyle(fontSize: 18))),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    iconSize: 20,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsetsDirectional.only(),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EventsPage())),
                  ),
                ],
              ),
            ),
            //margin: EdgeInsets.only(top: 25),
            padding: EdgeInsets.only(left: 27, bottom: 27),
            width: screenwidth.size.width),
        //活動下方
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          //color: Colors.black,
          child: FutureBuilder(
              future: _data,
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                margin: EdgeInsets.only(right: 15, left: 20),
                                width: 178,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4,
                                        offset: Offset(0, 4)),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomDialog(
                                                eventsTitle: snapshot
                                                    .data[index]
                                                    .data['eventsTitle'],
                                                location: snapshot.data[index]
                                                    .data['location'],
                                                eventsDetail: snapshot
                                                    .data[index]
                                                    .data['eventsDetail'],
                                                organizer: snapshot.data[index]
                                                    .data['organizer'],
                                                pointsNum: snapshot
                                                    .data[index].data['points'],
                                                startDate: snapshot.data[index]
                                                    .data['startTime'],
                                                endDate: snapshot.data[index]
                                                    .data['endTime'],
                                                pointsType: snapshot
                                                    .data[index].data['type'],
                                                typeInt: snapshot.data[index]
                                                    .data['typeInt'],
                                              ));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                                snapshot.data[index]
                                                    .data['eventsTitle'],
                                                overflow: TextOverflow.fade,
                                                style: GoogleFonts.notoSans(
                                                    textStyle: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ))))),
                                  ),
                                )),
                          );
                        }),
                  );
                }
              }),
        ),
        /*Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
            color: appbarcolor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4)),
            ],
          ),
          child: ListView(
            children: <Widget>[
              FutureBuilder(
                  future: _data,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Text(
                        "Loading ...",
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ));
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) => Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomDialog(
                                          eventsTitle: snapshot
                                              .data[index].data['eventsTitle'],
                                          location: snapshot
                                              .data[index].data['location'],
                                          eventsDetail: snapshot
                                              .data[index].data['eventsDetail'],
                                          organizer: snapshot
                                              .data[index].data['organizer'],
                                          pointsNum: snapshot
                                              .data[index].data['points'],
                                          startDate: snapshot
                                              .data[index].data['startTime'],
                                          endDate: snapshot
                                              .data[index].data['endTime'],
                                          pointsType:
                                              snapshot.data[index].data['type'],
                                          typeInt: snapshot
                                              .data[index].data['typeInt'],
                                        ));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data[index].data['eventsTitle'],
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ),
                            )),
                      );
                    }
                  })
            ],
          ),
        ),*/
      ])
    ]);
  }

  Widget buildIconButton(Icon icon, Function onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: appbarcolor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4)),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon),
    );
  }
}
