import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:timu/db_helpers.dart';
import 'dart:math';

class Panduanti extends StatelessWidget {
  Panduanti({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("判断题"),
        ),
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyCounterWidget();
  }
}

class MyCounterWidget extends StatefulWidget {
  MyCounterWidget() {
  }

  @override
  State<StatefulWidget> createState() {
    // 将创建的State返回
    return MyCounterState();
  }
}

class MyCounterState extends State<MyCounterWidget> {

   

   final String appId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544~3347511713'
      : 'ca-app-pub-9010870803829618~6496226013';

  final String bannerUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-9010870803829618/6165053524';

  final String screenUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-9010870803829618/3295347606';

  // final String videoUnitId = Platform.isAndroid
  //     ? 'ca-app-pub-3940256099942544/5224354917'
  //     : 'ca-app-pub-3940256099942544/1712485313';

  int counter = 0;

  var num = 0;

  var ran = (1 + (Random().nextInt(680)));
  var id = 1;

  var daan = "";

  var shengxia = 1;

  var todo = Timu();

  MyCounterState() {
  }

  @override
  void initState() {
    super.initState();

    
 
 

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: FutureBuilder<Timu>(
              future: DBProvider.db.getFirst("panduanti"),
              builder: (BuildContext context, AsyncSnapshot<Timu> snapshot) {
                num = 0;
                if (snapshot.hasData) {
                  daan = snapshot.data.daan;
                  id = snapshot.data.id;
                  todo.tigan = snapshot.data.tigan;
                  todo.daan = snapshot.data.daan;

              

                  return Text(
                    snapshot.data.tigan,
                    style: TextStyle(fontSize: 25),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                    semanticsLabel: "卡住了",
                  ));
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.redAccent,
                child: Text(
                  "对",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                onPressed: () {
                  if (daan == "A" && num == 0) {
                    //第一次就回答正确,直接删除题目;
                    DBProvider.db.delete(id, "panduanti");
                    setState(() {
                      MyCounterState();
                    });
                  } else if (daan == "A" && num > 0) {
                    //非首次回答正确,更新题目到最后一列;

                    var maxid = DBProvider.db.maxId("panduanti");

                    maxid.then((maxid) => (todo.id = maxid + 1));

                    maxid.then(
                        (maxid) => (DBProvider.db.insert(todo, "panduanti")));

                    DBProvider.db.delete(id, "panduanti");

                    setState(() {
                      MyCounterState();
                    });
                  } else {
                    //直接答错
                    num = num + 1;
                  }
                },
              ),
              RaisedButton(
                color: Colors.orangeAccent,
                child: Text(
                  "错",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                onPressed: () {
                  if (daan == "B" && num == 0) {
                    //第一次就回答正确,直接删除题目;

                    DBProvider.db.delete(id, "panduanti");

                    setState(() {
                      MyCounterState();
                    });
                  } else if (daan == "B" && num > 0) {
                    //非首次回答正确,更新题目到最后一列;
                    var maxid = DBProvider.db.maxId("panduanti");

                    maxid.then((maxid) => (todo.id = maxid + 1));
                    maxid.then(
                        (maxid) => (DBProvider.db.insert(todo, "panduanti")));

                    DBProvider.db.delete(id, "panduanti");

                    setState(() {
                      MyCounterState();
                    });
                  } else {
                    //直接答错
                    num = num + 1;
                  }
                },
              ),
              // RaisedButton(
              //   color: Colors.greenAccent,
              //   child: Text(
              //     "不会",
              //     style: TextStyle(fontSize: 24, color: Colors.white),
              //   ),
              //   onPressed: () {
              //     var maxid = DBProvider.db.maxId("panduanti");

              //     maxid.then((maxid) => (todo.id = maxid + 1));

              //     maxid.then(
              //         (maxid) => (DBProvider.db.insert(todo, "panduanti")));

              //       DBProvider.db.delete(id, "panduanti");

              //       setState(() {
              //         MyCounterState();
              //       });

              //   },
                
              // ),
            ],
          ),


          Center(
            child: FutureBuilder<int>(
              future: DBProvider.db.sum("panduanti"),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                shengxia = snapshot.data;

                //单选801
                //多选623
                //判断680
                return Text(
                  "剩余未做题目: $shengxia/680",
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
          ),

      


        ],
      ),
    );
  }

  @override
  void dispose() {
        

    super.dispose();
  }
}
