import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ZaiXianPage extends StatefulWidget {
  ZaiXianPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ZaiXianPageState createState() => _ZaiXianPageState();
}

class _ZaiXianPageState extends State<ZaiXianPage> {


  var get_res;

  var timu = '新冠肺炎的最长潜伏期一般是多久？';
  var daan = '21天';

  Future getHttp() async {


    try {

      var http_url = "http://8.129.108.187:8081/timu";
      Response response = await Dio().get(http_url);
  
      get_res = response.data;
      // get_res = get_res.toString();
      
      print(get_res['timu']);

      if (get_res.length > 0) {
        print('res有数据');
        // print(get_res);
        timu = get_res['timu'];
        daan = get_res['daan'];
      }
      return get_res;
    } catch (e) {
      print("错误请求");
      print(e);
      return 0;
    }
  }



  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      color: Colors.black,
      fontSize: 20,
      // fontWeight: FontWeight.bold,
      // fontStyle: FontStyle.italic,
      letterSpacing: 10,
    );

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
              color: Colors.red[100],
              //时间顶部对齐
              alignment: AlignmentDirectional.topStart,
              height: 70,
              // margin: const EdgeInsets.only(right: 55.0,top: 22.0),
              // child: Text(
              //   //格式化时间
              //   '广告占位',
              //   style: TextStyle(fontSize: 22.0, color: Colors.white),
              // ),
            ),
            AutoSizeText(
              timu,
              style: TextStyle(fontSize: 26.0, color: Colors.white),
            ),
             Text(''),
              Text(''),
            Divider(
              height: 1.0,
              indent: 60.0,
              color: Colors.red,
            ),

        Expanded(
              child: new Container(
                height: 50,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16),
                child: AutoSizeText(
  daan,
  style: style,
),
              ),
        ),

        


            // Container(
            //   child: Text(
            //       daan,
            //       style: style),
            // ),
            Text(''),
             Text(''),
              Text(''),
            Divider(
              height: 1.0,
              indent: 60.0,
              color: Colors.red,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text("收藏", style: TextStyle(color: Colors.black)),
                  color: Colors.green, // 按钮的颜色
                  // highlightColor: Colors.orange[700], // 按下去高亮颜色
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // 圆角的实现
                  onPressed: () {
                    print("FlatButton Click");
                  },
                ),
                FlatButton(
                  child: Text("答案", style: TextStyle(color: Colors.black)),
                  color: Colors.orange, // 按钮的颜色
                  // highlightColor: Colors.orange[700], // 按下去高亮颜色
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // 圆角的实现
                  onPressed: () {
                    print("FlatButton Click");
                  },
                ),
                FlatButton(
                  child: Text("下一题", style: TextStyle(color: Colors.black)),
                  color: Colors.white, // 按钮的颜色
                  // highlightColor: Colors.orange[700], // 按下去高亮颜色
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // 圆角的实现
                  onPressed: () {
                    // getHttp();
                    setState(() {
                      getHttp();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
