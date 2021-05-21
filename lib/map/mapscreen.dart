import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:GP/home/newHome.dart';
import 'package:GP/list/Pages/customDialog.dart';
import 'package:GP/list/list.dart';
import 'package:GP/setting/setting.dart';
import 'package:GP/styles/list_icon_icons.dart';
import 'package:GP/styles/myColor.dart';
import 'package:GP/write/write.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../map/map_painter.dart';
import '../map/my_flutter_app_icons.dart';

class GMap extends StatefulWidget {
  GMap({
    Key key,
  }) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  //Firestore
  Future _data;
  Future getData() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn0 =
        await firestore.collection("德").where('location').getDocuments();
    QuerySnapshot qn1 =
        await firestore.collection("智").where('location').getDocuments();

    QuerySnapshot qn2 =
        await firestore.collection("體").where('location').getDocuments();

    QuerySnapshot qn3 =
        await firestore.collection("群").where('location').getDocuments();

    QuerySnapshot qn4 =
        await firestore.collection("美").where('location').getDocuments();


    return qn0.documents +
        qn1.documents +
        qn2.documents +
        qn3.documents +
        qn4.documents;
    

  }

  List daEn0 = [];
  List daYi1 = [];
  List baiHua2 = [];
  List daDian3 = [];
  List memHall4 = [];
  List daXiao5 = [];
  List daGong6 = [];
  List daZhong7 = [];
  List daXian8 = [];
  List feiHwa9 = [];
  List daDe10 = [];
  List daRen11 = [];
  List daCheng12 = [];

  List numberlist = [];
  var finaldata;
  Future numberData() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn0 = await firestore.collection('德').getDocuments();
    QuerySnapshot qn1 = await firestore.collection('智').getDocuments();
    QuerySnapshot qn2 = await firestore.collection('體').getDocuments();
    QuerySnapshot qn3 = await firestore.collection('群').getDocuments();
    QuerySnapshot qn4 = await firestore.collection('美').getDocuments();

    var allDataFromFirestore = qn0.documents +
        qn1.documents +
        qn2.documents +
        qn3.documents +
        qn4.documents;

    finaldata = allDataFromFirestore.map((e) {
      if (e.data['location'].contains('大恩館') ||
          e.data['location'].contains('大恩')) {
        daEn0.add(e.data['location']);
      } else if (e.data['location'].contains('大義館')) {
        daYi1.add(e.data['location']);
      } else if (e.data['location'].contains('百花池')) {
        baiHua2.add(e.data['location']);
      } else if (e.data['location'].contains('大典館')) {
        daDian3.add(e.data['location']);
      } else if (e.data['location'].contains('曉峰紀念館')) {
        memHall4.add(e.data['location']);
      } else if (e.data['location'].contains('大孝館')) {
        daXiao5.add(e.data['location']);
      } else if (e.data['location'].contains('大功館')) {
        daGong6.add(e.data['location']);
      } else if (e.data['location'].contains('大忠')) {
        daZhong7.add(e.data['location']);
      } else if (e.data['location'].contains('大賢')) {
        daXian8.add(e.data['location']);
      } else if (e.data['location'].contains('菲華')) {
        feiHwa9.add(e.data['location']);
      } else if (e.data['location'].contains('大德')) {
        daDe10.add(e.data['location']);
      } else if (e.data['location'].contains('大仁')) {
        daRen11.add(e.data['location']);
      } else if (e.data['location'].contains('大成')) {
        daCheng12.add(e.data['location']);
      }
    }).toList();

    numberlist.add(daEn0.length);
    numberlist.add(daYi1.length);
    numberlist.add(baiHua2.length);
    numberlist.add(daDian3.length);
    numberlist.add(memHall4.length);
    numberlist.add(daXiao5.length);
    numberlist.add(daGong6.length);
    numberlist.add(daZhong7.length);
    numberlist.add(daXian8.length);
    numberlist.add(feiHwa9.length);
    numberlist.add(daDe10.length);
    numberlist.add(daRen11.length);
    numberlist.add(daCheng12.length);

    print('number is ' + '$numberlist');

    return numberlist;
  }

  Map<MarkerId, Marker> _markers = Map();
  int _currentIndex = 0;
  int count = 0;

  var listname = [
    '大恩館',
    '大義館',
    '百花池',
    '大典館',
    '曉峰紀念館',
    '大孝館',
    '大功館',
    '大忠館',
    '大賢館',
    '菲華樓',
    '大德館',
    '大仁館',
    '大成館'
  ];

  final List<LatLng> _markerLocations = [
    LatLng(25.136493, 121.5389585), //大恩館
    LatLng(25.136284815385523, 121.53959639498177), //大義館
    LatLng(25.1367908, 121.5395372), //百花池
    LatLng(25.13596672028512, 121.53890438511213), //大典館
    LatLng(25.13736, 121.5405954), //曉峰紀念館
    LatLng(25.1347965, 121.5395222), //大孝館
    LatLng(25.136241107712653, 121.53855569794197), //大功館
    LatLng(25.13563587620824, 121.53805046325319), //大忠館
    LatLng(25.13582782586489, 121.5395699793126), //大賢館
    LatLng(25.13585380846268, 121.54019720981705), //菲華樓
    LatLng(25.135584181174455, 121.54016689307934), //大德館
    LatLng(25.1373124897456, 121.53943282659367), //大仁館
    LatLng(25.13701451919516, 121.5404650115956), //大成館
  ];

  @override
  void initState() {
    _data = getData();
    numberData();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) async {
    await numberData();
    for (int i = 0; i < listname.length; i++) {
      for (LatLng markerLocation in _markerLocations) {
        final position = markerLocation;
        final markerId = MarkerId(_markers.length.toString());
        final bytes = await _myPainterToBitmap(
            label: '${listname[i++]}', number: '${numberlist[i - 1]}');

        final locationNames = '${listname[i - 1]}';
        final marker = Marker(
          markerId: markerId,
          position: position,
          icon: BitmapDescriptor.fromBytes(bytes),
          onTap: () => showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)),
            ),
            backgroundColor: appbarcolor,
            isScrollControlled: true, // set this to true
            builder: (_) {
              return DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.5,
                  maxChildSize: 0.9,
                  expand: false,
                  builder: (_, controller) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.2,
                      margin: EdgeInsets.only(top: 18),
                      child: Column(
                        children: [
                          Container(
                            width: 126,
                            height: 3,
                            color: Colors.grey,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '$locationNames',
                                style: TextStyle(
                                    fontSize: 36, color: Colors.white),
                              ),
                            ),
                          ),
                          //SizedBox(height: 10),
                          Container(
                            height: 5,
                            color: Colors.white,
                          ),
                          FutureBuilder(
                              future: _data,
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('Loading...');
                                } else {
                                  return Expanded(
                                    child: ListView.builder(
                                        controller: controller,
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var location = snapshot
                                              .data[index].data['location'];
                                          var filterLocation;
                                          DateTime now = DateTime.now();
                                          //大恩館
                                          if (locationNames == '大恩館') {
                                            filterLocation =
                                                location.contains('大恩館');
                                            if (filterLocation) {
                                              //print(DateTime.now());
                                              // DateTime newTime = DateFormat('y-M-d H:m').parse(snapshot.data[index].data['endTime']);
                                              //   print('newTime is $newTime');
                                              
                                              
                                                  return buildMapMarkerEvents(context, snapshot, index);
                                              
                                                
                                            }else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          }

                                          //大義館
                                          else if (locationNames == '大義館') {
                                            filterLocation =
                                                location.contains('大義館');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          }

                                          //大典館
                                          else if (locationNames == '大典館') {
                                            filterLocation =
                                                location.contains('大典館');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          }

                                          //百花池
                                          else if (locationNames == '百花池') {
                                            filterLocation =
                                                location.contains('百花池');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          }

                                          //曉峰紀念館
                                          else if (locationNames == '曉峰紀念館') {
                                            filterLocation =
                                                location.contains('曉峰紀念館');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          }

                                          //大孝館
                                          else if (locationNames == '大孝館') {
                                            filterLocation =
                                                location.contains('大孝館');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          } else if (locationNames == '大功館') {
                                            filterLocation =
                                                location.contains('大功館');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          } else if (locationNames == '大忠館') {
                                            filterLocation =
                                                location.contains('大忠館');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          } else if (locationNames == '大賢館') {
                                            filterLocation =
                                                location.contains('大賢館');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          } else if (locationNames == '菲華樓') {
                                            filterLocation =
                                                location.contains('菲華樓');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          }else if (locationNames == '大德館') {
                                            filterLocation =
                                                location.contains('大德館');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          } else if (locationNames == '大仁館') {
                                            filterLocation =
                                                location.contains('大仁館');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          } else if (locationNames == '大成館') {
                                            filterLocation =
                                                location.contains('大成館');
                                            if (filterLocation) {
                                              
                                                return buildMapMarkerEvents(
                                                    context, snapshot, index);
                                            } else if (filterLocation ==
                                                false) {
                                              return SizedBox(height: 0);
                                            }
                                          }

                                          return null;
                                        }),
                                  );
                                }
                              }),
                        ],
                      ),
                    );
                  });
            },
          ),
        );

        setState(() {
          _markers[markerId] = marker;
        });
      }
    }
  }

  Padding buildMapMarkerEvents(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(
                        eventsTitle: snapshot.data[index].data['eventsTitle'],
                        location: snapshot.data[index].data['location'],
                        eventsDetail: snapshot.data[index].data['eventsDetail'],
                        organizer: snapshot.data[index].data['organizer'],
                        pointsNum: snapshot.data[index].data['points'],
                        startDate: snapshot.data[index].data['startTime'],
                        endDate: snapshot.data[index].data['endTime'],
                        pointsType: snapshot.data[index].data['type'],
                        typeInt: snapshot.data[index].data['typeInt'],
                      ));
            },
            child: Container(
              width: 50,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Container(
                      //color:Colors.blue,
                      height: MediaQuery.of(context).size.height,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${snapshot.data[index].data['type']}',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  //SizedBox(width: 10),
                  Container(
                    //color: Colors.black,
                    width: 250,
                    height: MediaQuery.of(context).size.height,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${snapshot.data[index].data['eventsTitle']}',
                        style: TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  //SizedBox(width: 40),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      //color: Colors.red,
                      height: MediaQuery.of(context).size.height,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${snapshot.data[index].data['points']}點',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _myPainterToBitmap({String label, number}) async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    MyPainter myPainter = MyPainter(label, number);

    myPainter.paint(canvas, Size(280, 100));
    final ui.Image image = await recorder.endRecording().toImage(280, 100);
    final ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData.buffer.asUint8List();
  }

  static final CameraPosition _position1 =
      CameraPosition(target: LatLng(25.1365181, 121.5401166), zoom: 18);

  /*void _goToPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: YColors.deepblue,
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: MapType.terrain,
            initialCameraPosition: _position1,
            markers: Set.of(_markers.values),
            //myLocationEnabled: true,
          ),
          /*Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  button(_goToPosition, Icons.gps_fixed),
                  SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),*/
          //Navigation Button
          Positioned(
            bottom: 20,
            child: Container(
              width: 360,
              height: MediaQuery.of(context).size.height / 9,
              child: CustomNavigationBar(
                strokeColor: Colors.transparent,
                //strokeColor: YColors.lightyellow,
                unSelectedColor: Colors.white,
                selectedColor: Colors.black,
                elevation: 0.0,
                iconSize: 40,
                backgroundColor: YColors.deepyellow,
                borderRadius: Radius.circular(40),
                isFloating: true,
                items: [
                  CustomNavigationBarItem(
                    icon: MyFlutterApp.mapfigmaver,
                  ),
                  CustomNavigationBarItem(
                    icon: ListIcon.listicon,
                  ),
                  CustomNavigationBarItem(
                    icon: MyFlutterApp.home,
                  ),
                  CustomNavigationBarItem(
                    icon: MyFlutterApp.handpoint,
                  ),
                  CustomNavigationBarItem(
                    icon: MyFlutterApp.settingnopccu,
                  ),
                ],
                currentIndex: _currentIndex,
                onTap: (index) {
                  if (index == 0) {
                    Navigator.push(context,
                        PageRouteBuilder(pageBuilder: (_, __, ___) => GMap()));
                    /*Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => GMap()));*/
                  } else if (index == 1) {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => ListPage()));
                    /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ListPage()));*/
                  } else if (index == 2) {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => NewHomePage()));
                    /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NewHomePage()));*/
                  } else if (index == 3) {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => WritePage()));
                    /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => WritePage()));*/
                  } else {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SettingPage()));
                    /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SettingPage()));*/
                  }

                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          trip.title,
                          style: new TextStyle(fontSize: 36.0),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        child: Text(
                          trip.event,
                          style: new TextStyle(fontSize: 18.0),
                        ),
                      ),
                      Spacer(
                        flex: 4,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 23),
                        child: Text(
                          trip.whatpoints,
                          style: new TextStyle(fontSize: 30.0),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    ); */
