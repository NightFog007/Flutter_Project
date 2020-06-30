import 'package:flutter/material.dart';

import 'dart:ui';
import '../common/http_service.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../common/question_data.dart';

class WrongPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => GetData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        // home:FirstPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var sum = 0;

  var answer = 'A';
  @override
  Widget build(BuildContext context) {
    if (Provider.of<GetData>(context).title != null) {
    } else {
      Provider.of<GetData>(context).getTitleList();
    }

    answer = Provider.of<GetData>(context).answer;

    return Scaffold(
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
              // margin: const EdgeInsets.only(right: 2.0,top: 22.0),
              child: Text(
                //格式化时间
                '广告占位',
                style: TextStyle(fontSize: 22.0, color: Colors.white),
              ),
            ),
            Text("${Provider.of<GetData>(context).title}",
                style: TextStyle(fontSize: 22.0, color: Colors.white)),
           
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    // padding: new EdgeInsets.only(right: 200),
                    color: Colors.blueGrey,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "A. ${Provider.of<GetData>(context).answerA}",
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                    onPressed: () {
                      if (answer == "A") {
                        print("回答正确");
                        sum++;
                        _changQuestion();
                      } else {
                        print("回答错误");
                      }
                    },
                  ),
                )
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    // padding: new EdgeInsets.only(right: 200),
                    color: Colors.blueGrey,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "B. ${Provider.of<GetData>(context).answerB}",
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                    onPressed: () {
                      if (answer == "B") {
                        print("回答正确");
                        sum++;
                        _changQuestion();
                      } else {
                        print("回答错误");
                      }
                    },
                  ),
                )
              ],
            ),

            Row(
              // mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    // padding: new EdgeInsets.only(right: 200),
                    color: Colors.blueGrey,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "C. ${Provider.of<GetData>(context).answerC}",
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                    onPressed: () {
                      if (answer == "C") {
                        print("回答正确");
                        sum++;
                        _changQuestion();
                      } else {
                        print("回答错误");
                      }
                    },
                  ),
                )
              ],
            ),


            Row(
              // mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    // padding: new EdgeInsets.only(right: 200),
                    color: Colors.blueGrey,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "D. ${Provider.of<GetData>(context).answerD}",
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                    onPressed: () {
                      if (answer == "D") {
                        print("回答正确");
                        sum++;
                        _changQuestion();
                      } else {
                        print("回答错误");
                      }
                    },
                  ),
                )
              ],
            ),


          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _changQuestion,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _changQuestion() {
    setState(() {
      Provider.of<GetData>(context).getTitleList();
      print("the sum is:");
      print(sum);
    });
  }
}

//使用mixin混入ChangeNotifier类,这个类能够自动管理所有听众.
class GetData with ChangeNotifier {
//存储数据
  String _title;
  String _answerA;
  String _answerB;
  String _answerC;
  String _answerD;
  String _answer;
  //提供外部能够访问的数据
  String get title => _title;
  String get answerA => _answerA;
  String get answerB => _answerB;
  String get answerC => _answerC;
  String get answerD => _answerD;
  String get answer => _answer;
  //提供更改数据的方法
  void getTitleList() async {
    //请求url
    var url =
        'http://api.tianapi.com/txapi/baiketiku/index?key=ca4f25b93495f1001c3a81dd9972b89c';
    //调用请求方法传入url
    await request(url).then((value) {
      //Json解码 value为服务端返回的数据
      var data = json.decode(value.toString());
      //打印数据
      print('获取的数据Json格式:::' + data.toString());
      //将Json数据转换成ProductListModel
      ProductListModel productList = ProductListModel.fromJson(data);
      //将返回的数据放入ProductProvider里
      if (productList.newslist == null) {
        // Provider.of<Counter>(context).getProductList([]);
      } else {
        // Provider.of<Counter>(context).getProductList(productList.data);
        _title = productList.newslist[0].title;
        _answerA = productList.newslist[0].answerA;
        _answerB = productList.newslist[0].answerB;
        _answerC = productList.newslist[0].answerC;
        _answerD = productList.newslist[0].answerD;
        _answer = productList.newslist[0].answer;
      }
    });
    //通知所有听众进行刷新
    notifyListeners();
  }
}
