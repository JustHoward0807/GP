import 'package:GP/setting/questions.dart';
import 'package:GP/styles/myColor.dart';
import 'package:flutter/material.dart';

class QuestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questions = Question.fetchAll();
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150,
              floating: true,
              pinned: true,
              backgroundColor: appbarcolor,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: EdgeInsets.only(bottom: 10, right: 200),
                  title: Text(
                    '常見問題',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context)),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: bgcolor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 20, bottom: 20),
                                child: Text(
                                  '${questions[index].question}',
                                  style: TextStyle(fontSize: 20),
                                )),
                            ExpansionTile(
                              title: Text(
                                '展開',
                                overflow: TextOverflow.fade,
                              ),
                              children: <Widget>[
                                Container( 
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text('${questions[index].answer}',style: TextStyle(fontSize:20),),
                                    )),
                              ],
                            ),
                          ],
                        )),
                  ),
                );
              },
              childCount: questions.length,
            ))
          ],
        ),
      ),
    );
  }
}
