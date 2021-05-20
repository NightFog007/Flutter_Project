
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {


  @override
  Widget build(BuildContext context) {
   
    var choice_answer = '0';

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('111'),
      // ),
      body: Container(
        color: Colors.blue,
        // alignment: AlignmentDirectional.topStart,
        // margin: const EdgeInsets.only(right: 1.0,top: 1.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.red,
              //时间顶部对齐
              alignment: AlignmentDirectional.topStart,
              height: 70,
              // margin: const EdgeInsets.only(right: 55.0,top: 22.0),
              child: Text(
                //格式化时间
                '广告占位',
                style: TextStyle(fontSize: 22.0, color: Colors.white),
              ),
            ),
            Text(
              '新冠肺炎的最长潜伏期一般是多久？',
              style: TextStyle(fontSize: 22.0, color: Colors.white),
            ),
            Container(
              child: FlatButton(
                padding: new EdgeInsets.only(right: 280),
                color: Colors.blueGrey,
                child: Text(
                  "A. 1-2天",
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                onPressed: () {
                  print("FlatButton Click");
                },
              ),
            ),
            Container(
              child: FlatButton(
                padding: new EdgeInsets.only(right: 280),
                color: Colors.blueGrey,
                child: Text(
                  "B. 3-7天",
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                onPressed: () {
                  print("FlatButton Click");
                },
              ),
            ),
            Container(
              child: FlatButton(
                padding: new EdgeInsets.only(right: 280),
                color: Colors.blueGrey,
                child: Text(
                  "C. 15天",
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                onPressed: () {
                  print("FlatButton Click");
                },
              ),
            ),
            Container(
              child: FlatButton(
                padding: new EdgeInsets.only(right: 280),
                color: Colors.blueGrey,
                child: Text(
                  "D. 32天",
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                onPressed: () {
                  print("FlatButton Click");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}