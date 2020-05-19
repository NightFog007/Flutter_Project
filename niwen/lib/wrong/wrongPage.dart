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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${Provider.of<GetData>(context).title}"),
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
    });
  }


}



//使用mixin混入ChangeNotifier类,这个类能够自动管理所有听众.
class GetData with ChangeNotifier {
//存储数据
  String _title;
  String _answerA;

  //提供外部能够访问的数据
  String get title => _title;
  String get answerA => _answerA;

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
        _answerA = productList.newslist[0].answer;
      }
    });
    //通知所有听众进行刷新
    notifyListeners();
  }
}
