import 'package:flutter/material.dart';
import './rightData.dart';
import 'dart:ui';
import '../common/http_service.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class RightPage extends StatefulWidget {
  RightPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _RightPageState createState() => _RightPageState();
}

class _RightPageState extends State<RightPage> {
   @override
  void initState() {
    super.initState();
    //获取产品数据
    getProductList();
  }
  //获取产品数据
  void getProductList() async {
    //请求url
    var url = 'http://api.tianapi.com/txapi/baiketiku/index?key=ca4f25b93495f1001c3a81dd9972b89c';
    
    //调用请求方法传入url及表单数据
    await request(url).then((value) {
      //Json解码 value为服务端返回的数据
      var data = json.decode(value.toString());
      //打印数据
      print('产品列表数据Json格式:::' + data.toString());
      //将Json数据转换成ProductListModel
      ProductListModel productList = ProductListModel.fromJson(data);
      //将返回的数据放入ProductProvider里
      if (productList.data == null) {
        Provider.of<ProductProvider>(context).getProductList([]);
      } else {
        Provider.of<ProductProvider>(context).getProductList(productList.data);
      }
    });
  }

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
