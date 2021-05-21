import 'package:GP/home/events.dart';
import 'package:GP/list/Pages/customDialog.dart';
import 'package:GP/styles/bar_icon_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/dbhelper.dart';
import '../home/homeBox.dart';
import '../styles/myColor.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainbgcolor,
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
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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

  /*Future<void> _resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('startUpNumber', 0);
  }*/

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
      Column(
        children: <Widget>[
          Container(
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EventsPage())),
                child: Row(
                  children: <Widget>[
                    Text(
                      "活動",
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      iconSize: 20,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsetsDirectional.only(),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventsPage())),
                    ),
                  ],
                ),
              ),
              margin: EdgeInsets.only(top: 25),
              padding: EdgeInsets.only(left: 27),
              width: screenwidth.size.width),
          //活動下方
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            color: appbarcolor,
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
                          itemBuilder: (BuildContext context, int index) =>
                              Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
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
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ),
                                  )),
                        );
                      }
                    })
              ],
            ),
          ),

          Divider(
            indent: 40,
            endIndent: 40,
            height: 40,
            color: Colors.black,
            thickness: 1,
          ),

          Center(
            child: Container(
              child: Center(
                child: Column(children: <Widget>[
                  Center(child: TopStackBox1()),
                  SizedBox(height: 20),
                  Center(child: TopStackBox2()),
                  SizedBox(height: 20),
                  Center(child: TopStackBox3()),
                  SizedBox(height: 20),
                  Center(child: TopStackBox4()),
                ]),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
