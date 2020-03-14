import 'package:flutter/material.dart';
import 'package:timu/new_button.dart';
import 'package:timu/new_text.dart';
import 'package:timu/db_helpers.dart';
import 'dart:math';


class Danxuanti extends StatelessWidget {

  Danxuanti({Key key, this.title}) : super(key: key);

    final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("单选题"),
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

  GlobalKey<TextWidgetState> textKey = GlobalKey();
var _count = 1;

  int counter = 0;

var ran = (1 + (Random().nextInt(801)));
 
 var todo = Timu();

   int num = 0;

  var shengxia = 1;
  var daan = "";

  var wrong  = 1 ;

  var id = 1;

  var tigan = "";
  var xuanxiang = "";
 
  var result = "";

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
      child: 
        ListView(
        
        children: <Widget>[
          
          Padding(
      padding: EdgeInsets.all(20),
      child: FutureBuilder<Timu>(
        //  future: DBProvider.db.getOne(ran,"danxuanti"),
        future: DBProvider.db.getFirst("danxuanti"),
         builder: (BuildContext context, AsyncSnapshot<Timu> snapshot) {

            num = 0;

           if (snapshot.hasData) {
              id = snapshot.data.id;
             daan = snapshot.data.daan;
              tigan = snapshot.data.tigan;
              xuanxiang = snapshot.data.xuanxiang;
              xuanxiang = xuanxiang.replaceAll("|", "\n");
               result = tigan + '\n\n' + xuanxiang;
            wrong = snapshot.data.wrong;
              todo = snapshot.data;
     
 
             return Text(result,style:TextStyle(fontSize: 25),);

          } else {
             return Center(child: CircularProgressIndicator());
           }
         },
       ),
          ),


          Row(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             
              RaisedButton(
                color: Colors.redAccent,
                child: Text("A", style: TextStyle(fontSize: 24, color: Colors.white),),
                onPressed: () {

                  if (daan == "A" && num == 0) {
                    //第一次就回答正确,直接删除题目;
                    DBProvider.db.delete(id, "danxuanti");
                    textKey.currentState.onPressed( "");
                    setState(() {
                      MyCounterState();
                    });
                  } else if (daan == "A" && num > 0) {
                    //非首次回答正确,更新题目到最后一列;

                    var maxid = DBProvider.db.maxId("danxuanti");

                    maxid.then((maxid) => (todo.id = maxid + 1));

                    maxid.then(
                        (maxid) => (DBProvider.db.insert(todo, "danxuanti")));

                    DBProvider.db.delete(id, "danxuanti");
                    textKey.currentState.onPressed( "");

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
                child: Text("B", style: TextStyle(fontSize: 24, color: Colors.white),),
                onPressed: () {
                    
                    if (daan == "B" && num == 0) {
                    //第一次就回答正确,直接删除题目;
                    DBProvider.db.delete(id, "danxuanti");
                    textKey.currentState.onPressed( "");
                    setState(() {
                      MyCounterState();
                    });
                  } else if (daan == "B" && num > 0) {
                    //非首次回答正确,更新题目到最后一列;

                    var maxid = DBProvider.db.maxId("danxuanti");

                    maxid.then((maxid) => (todo.id = maxid + 1));

                    maxid.then(
                        (maxid) => (DBProvider.db.insert(todo, "danxuanti")));

                    DBProvider.db.delete(id, "danxuanti");
                    textKey.currentState.onPressed( "");

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
                color: Colors.greenAccent,
                child: Text("C", style: TextStyle(fontSize: 24, color: Colors.white),),
                onPressed: () {
                    

                    if (daan == "C" && num == 0) {
                    //第一次就回答正确,直接删除题目;
                    DBProvider.db.delete(id, "danxuanti");
                    textKey.currentState.onPressed( "");
                    setState(() {
                      MyCounterState();
                    });
                  } else if (daan == "C" && num > 0) {
                    //非首次回答正确,更新题目到最后一列;

                    var maxid = DBProvider.db.maxId("danxuanti");

                    maxid.then((maxid) => (todo.id = maxid + 1));

                    maxid.then(
                        (maxid) => (DBProvider.db.insert(todo, "danxuanti")));

                    DBProvider.db.delete(id, "danxuanti");
                    textKey.currentState.onPressed( "");

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
                color: Colors.blueAccent,
                child: Text("D", style: TextStyle(fontSize: 24, color: Colors.white),),
                onPressed: () {
                    
                    if (daan == "D" && num == 0) {
                    //第一次就回答正确,直接删除题目;
                    DBProvider.db.delete(id, "danxuanti");
                    textKey.currentState.onPressed( "");
                    setState(() {
                      MyCounterState();
                    });
                  } else if (daan == "D" && num > 0) {
                    //非首次回答正确,更新题目到最后一列;

                    var maxid = DBProvider.db.maxId("danxuanti");

                    maxid.then((maxid) => (todo.id = maxid + 1));

                    maxid.then(
                        (maxid) => (DBProvider.db.insert(todo, "danxuanti")));

                    DBProvider.db.delete(id, "danxuanti");
                    textKey.currentState.onPressed( "");

                    setState(() {
                      MyCounterState();
                    });
                  } else {
                    //直接答错
                    num = num + 1;
                  }
             
                },
              ),

  


            ],
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
                  "收藏",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                onPressed: () {

                  DBProvider.db.delete(id, "danxuanti");


                  var maxid = DBProvider.db.maxId("danxuanti");

                  maxid.then((maxid) => (todo.id = maxid + 1));

                  maxid.then(
                      (maxid) => (DBProvider.db.insert(todo, "danxuanti")));


                 textKey.currentState.onPressed( "");

                   setState(() {
                    MyCounterState();
                  });
                },
              ),
              // RaisedButton(
              //   color: Colors.orangeAccent,
              //   child: Text(
              //     "下一题",
              //     style: TextStyle(fontSize: 24, color: Colors.white),
              //   ),
              //   onPressed: () {
                
              //     ran = (1 + (Random().nextInt(623)));

              //     setState(() {
              //       MyCounterState();
              //     });
              //   },
              // ),
            ],
          ),

          TextWidget(textKey),

           Center(
            child:FutureBuilder<int>(
          future: DBProvider.db.sum("danxuanti"),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {

            shengxia = snapshot.data;

      //单选801
        //多选623
        //判断680
            //  return Text(shengxia.toString(),style:TextStyle(fontSize: 25),);
             return  Text("剩余未做题目: $shengxia/801",style: TextStyle(fontSize: 16),);
        
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
    print("执行MyCounterState的dispose方法");
  }
}
