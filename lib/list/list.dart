import '../newBottomBar.dart';
import 'package:GP/styles/myColor.dart';
import 'package:flutter/material.dart';
import '../list/dropDown.dart';
import 'progressCircle.dart';
import '../database/trackingInfo.dart';
import '../database/dbhelper.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: ListHead(),
        preferredSize: Size.fromHeight(65.0),
      ),

      /*appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Stack(children: <Widget>[
              
              DropContainer(),
              
              Positioned(
                child: DropDownButton(),
                top: 10,
                left: 25,
                right: 25,
              ),
            ]),
            centerTitle: true,
            

            /*child: AppBar(
                backgroundColor: appbarcolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  DropDownButton(),
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: () {},
                    iconSize: 40,
                  )
                ],
              )),*/
          )),*/
      body: ListBody(),
      bottomNavigationBar: NewBottomBar(1),
    );
  }
}

class ListBody extends StatefulWidget {
  const ListBody({Key key}) : super(key: key);

  @override
  _ListBodyState createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {
  DbHelper _dbHelper = DbHelper();
  Future<List<TrackingInfo>> _trackingPoints;

  @override
  void initState() {
    _dbHelper.initializeDatabase().then((value) {
      print('database initialized');
      loadPoints();
    });
    super.initState();
  }

  void loadPoints() {
    _trackingPoints = _dbHelper.getPoints();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<int> color = [
      0xffF35151,
      0xffFF4D00,
      0xffFFC700,
      0xff0047AB,
      0xff3B9E0C
    ];
    return FutureBuilder(
        future: _trackingPoints,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: Offset(0, 4)),
                  ],
                  color: mainbgcolor,
                  borderRadius: BorderRadius.circular(39),
                ),
                width: 314,
                height: 560,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    //shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //Padding(padding: EdgeInsets.only(left: 10)),
                                ProgressCircle(
                                  text: "${snapshot.data[index].pointsType}",
                                  color: Color(color[index]),
                                  width: 60,
                                  height: 60,
                                  fontsize: 35,
                                  value: snapshot.data[index].currentPoints /
                                      18.toDouble(),
                                ),
                                
                                ProgressBar(
                                  color: Color(color[index]),
                                  text:
                                      '${snapshot.data[index].currentPoints} / 18',
                                  value:
                                      snapshot.data[index].currentPoints /
                                          18.toDouble(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            );
          } else {
            return Container(
              child: Center(child: Text("Loading")),
            );
          }
        });
  }
}

/*Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        ProgressCircle(
                          text: "${snapshot.data.pointsType}",
                          color: Color(0xffF35151),
                          width: 60,
                          height: 60,
                          fontsize: 35,
                        ),
                        ProgressBar(
                          color: Color(0xffF35151),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        ProgressCircle(
                          text: "智",
                          color: Color(0xffFF4D00),
                          width: 60,
                          height: 60,
                          fontsize: 35,
                        ),
                        ProgressBar(
                          color: Color(0xffFF4D00),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        ProgressCircle(
                          text: "體",
                          color: Color(0xffFFC700),
                          width: 60,
                          height: 60,
                          fontsize: 35,
                        ),
                        ProgressBar(
                          color: Color(0xffFFC700),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        ProgressCircle(
                          text: "群",
                          color: Color(0xff0047AB),
                          width: 60,
                          height: 60,
                          fontsize: 35,
                        ),
                        ProgressBar(
                          color: Color(0xff0047AB),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        ProgressCircle(
                          text: "美",
                          color: Color(0xff3B9E0C),
                          width: 60,
                          height: 60,
                          fontsize: 35,
                        ),
                        ProgressBar(
                          color: Color(0xff3B9E0C),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: Offset(0, 4)),
                  ],
                  color: mainbgcolor,
                  borderRadius: BorderRadius.circular(39),
                ),
                width: 314,
                height: 556,
              ),
            );*/
