import 'package:flutter/material.dart';
import 'package:timu/new_button.dart';
import 'package:timu/new_text.dart';
import 'package:timu/db_helpers.dart';
import 'dart:math';

class Duoxuanti extends StatelessWidget {
  Duoxuanti({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("多选题"),
        ),
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("HomeBody build");
    return MyCounterWidget();
  }
}

class MyCounterWidget extends StatefulWidget {
  MyCounterWidget() {
    print("执行了MyCounterWidget的构造方法");
  }

  @override
  State<StatefulWidget> createState() {
    print("执行了MyCounterWidget的createState方法");
    // 将创建的State返回
    return MyCounterState();
  }
}

class MyCounterState extends State<MyCounterWidget> {
  int counter = 0;

GlobalKey<TextWidgetState> textKey = GlobalKey();
var _count = 1;
  var ran = (1 + (Random().nextInt(623)));

  var shengxia = 1;

  var daan = "";

  var todo = new Timu();
  var tigan = "";
  var xuanxiang = "";

  var result = "";
  var id = 1;
  var tmp = "";

  MyCounterState() {
    print("执行MyCounterState的构造方法");
  }

  @override
  void initState() {
    super.initState();
    print("执行MyCounterState的init方法");
  }

  @override
  Widget build(BuildContext context) {
    print("执行执行MyCounterState的build方法");
    return Center(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: FutureBuilder<Timu>(
              future: DBProvider.db.getFirst("duoxuanti"),
              builder: (BuildContext context, AsyncSnapshot<Timu> snapshot) {
                if (snapshot.hasData) {
                  print("*************");
                  print(snapshot.data);
                  id = snapshot.data.id;
                  daan = snapshot.data.daan;
                  tigan = snapshot.data.tigan;
                  xuanxiang = snapshot.data.xuanxiang;
                  xuanxiang = xuanxiang.replaceAll("|", "\n");
                  result = tigan + '\n\n' + xuanxiang;

                   tmp = snapshot.data.daan;

                  todo.tigan = snapshot.data.tigan;
                  todo.daan = snapshot.data.daan;
                  todo.xuanxiang = snapshot.data.xuanxiang;

                  DBProvider.db.delete(id, "duoxuanti");

                  return Column(
                    children: <Widget>[
                      Text(
                        result,
                        style: TextStyle(fontSize: 25),
                      ),
                      // Text(daan,style:TextStyle(fontSize: 10),textAlign: TextAlign.right,),

                      // Padding(
                      //   // padding: EdgeInsets.all(20),
                      //   padding: EdgeInsets.fromLTRB(300, 100, 20, 10),

                      //   child: Text(
                      //     daan,
                      //     style: TextStyle(fontSize: 8),
                      //   ),
                      // ),
                    ],
                  );
                } else {
                  print("没有数据没有数据没有数据没有数据");

                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            ButtonWidget(
            onPressed: () {
              ///点击button，调用TextWidget的onPressed方法
              ///在TextWidget的onPressed中单独调用TextWidget的setState，
          
              textKey.currentState.onPressed( daan);
            },
          ),

              
              RaisedButton(
                color: Colors.greenAccent,
                child: Text(
                  "不会",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                onPressed: () {
                  var maxid = DBProvider.db.maxId("duoxuanti");

                  maxid.then((maxid) => (todo.id = maxid + 1));

                  maxid.then(
                      (maxid) => (DBProvider.db.insert(todo, "duoxuanti")));

                 textKey.currentState.onPressed( "");

                      setState(() {
                    MyCounterState();
                  });

                },
                
              ),
              RaisedButton(
                color: Colors.orangeAccent,
                child: Text(
                  "下一题",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                onPressed: () {
                  tmp = "";
                  ran = (1 + (Random().nextInt(623)));

                 textKey.currentState.onPressed( "");

                  setState(() {
                    MyCounterState();
                  });
                },
              ),
            ],
          ),

          TextWidget(textKey),


          Center(
            child: FutureBuilder<int>(
              future: DBProvider.db.sum("duoxuanti"),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                shengxia = snapshot.data;

                //单选801
                //多选623
                //判断680
                //  return Text(shengxia.toString(),style:TextStyle(fontSize: 25),);
                return Text(
                  "剩余未做题目: $shengxia/623",
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
          ),

         
          // TextWidget(textKey),

            
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("执行MyCounterState的dispose方法");
  }
}
