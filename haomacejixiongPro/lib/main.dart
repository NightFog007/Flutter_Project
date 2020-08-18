//常见属性
//currentIndex: int . 当前索引,用来切换按钮控制. 底部导航条按下按钮切换不同页面,所以需要当前索引来控制当前具体切换的页面.
//fixedColor: Color. 选中按钮的颜色.如果没有指定值,则用系统主题色.
//iconSize: double.  按钮图标大小.
//items: List<BottomNavigationBarItem>.  底部导航条按钮集. 每一项是一个BottomNavigationBarItem,有icon图标及title文本属性.
//onTap: ValueChanged<int> . 按下其中某一个按钮回调事件. 需要根据返回的索引设置当前索引.

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io' show Platform;
import './copy.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  void initState() {
    super.initState();



  
  }

  @override
  void dispose() {
    // appAds.dispose();
    super.dispose();
  }

  var number = "1";

  var result_str = " ";

  void getHttp() async {
    try {
      // Response response = await Dio().get("http://api.tianapi.com/txapi/jixiong/?key=ca4f25b93495f1001c3a81dd9972b89c&number=138001381235");

      var request_str =
          "http://api.tianapi.com/txapi/jixiong/?key=ca4f25b93495f1001c3a81dd9972b89c&number=" +
              number;
      Response response = await Dio().get(request_str);

      print(response);

      print("-------------");

      // print(response.data.toString());

      result_str = response.data.toString();

      var s1 = response.data["newslist"];
      var s2 = s1[0];
      var s3 = s2["conclusion"];
      var s4 = s2["result"];
      var s5 = s2["score"];

      result_str = "凶吉结果: " +
          s4 +
          "\n" +
          "\n" +
          "号码评分: " +
          s5 +
          "\n" +
          "\n" +
          "号码解析: " +
          s3;

      setState(() {
        _MyHomePageState();
      });
    } catch (e) {
      print(e);
    }
  }

  void buttonPressed() {
    // print('按下按钮');
    // print(number);
    getHttp();

        // appAds.showBannerAd(state: this, anchorOffset: null);

     print("main进入处理");
    // appAds.showFullScreenAd();
    // appAds.showBannerAd(state: this, anchorOffset: 500);
  }

  int _selectedIndex = 0; //当前选中项索引
  final _widgetOptions = [
    Text('QQ预测'),
    Text('手机预测'),
    Text('生日预测'),
    Text('车牌预测'),
    // Text('Index 3: 其他'),
  ];


  final _widgetOptionsDetail = [
    Text('输入QQ号码',style: TextStyle(
    // color:Colors.blue,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    
  )),
    Text('输入手机号码'),
    Text('格式19950508'),
    // Text('Index 3: 其他'),
    Text('输入车牌号'),
  ];

  @override
  Widget build(BuildContext context) {


    //添加文本编辑控制器  监听文本输入内容变化
    final TextEditingController controller = TextEditingController();
    controller.addListener(() {
      // print('your input is : ${controller.text}');
    });

    var list = <Widget>[
      TextField(
        controller: controller, //绑定controller
        maxLength: 30, //最大长度,右下角会出现输入数量统计
        maxLines: 1, //最大行数
        autocorrect: true, //是否自动更正
        autofocus: true, //是否自动对焦
        obscureText: false, //是否为密码
        textAlign: TextAlign.center, //文本对齐方式
        style: TextStyle(fontSize: 26.0, color: Colors.green), //输入文本的样式
        //文本内容改变时回调
        onChanged: (text) {
          print('文本内容改变时回调 $text');
          number = text;
        },
        //文本内容提交时回调
        onSubmitted: (text) {
          print('内容提交时回调 $text');
          // number = text;
        },
        enabled: true, //是否禁用
        //添加装饰效果
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200, //添加灰色填充色
          filled: true,
          // helperText: 'QQ号码',
          helperText: _widgetOptions.elementAt(_selectedIndex).data,

          prefixIcon: Icon(Icons.confirmation_number), //左侧图标
          suffixText:
              _widgetOptionsDetail.elementAt(_selectedIndex).data, //右侧文本提示
        ),
      ),

      RaisedButton(
        key: ValueKey<String>('SHOW INTERSTITIAL'),
        child: const Text('预测'),
        onPressed: buttonPressed,
      ),

      Text(
        //  Key key = key: "text_res",
        '$result_str',
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontSize: 18.0,
          textBaseline: TextBaseline.alphabetic,

          // backgroundColor: Colors.grey,
        ),
      ),

          RaisedButton(
        child: const Text('一键复制'),
        onPressed: () {
                  ClipboardData data = new ClipboardData(text: this.result_str);
                  Clipboard.setData(data);
                  ToastHelper.showToast(context, "复制成功");
                },
      ),

      
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('号码测吉凶'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: list.map((Widget button) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: button,
              );
            }).toList(),
          ),
        ),
      ),

      //底部导航按钮,包含图标及文本
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.chat), title: Text(' QQ预测 ')),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), title: Text(' 手机预测 ')),
          BottomNavigationBarItem(
              icon: Icon(Icons.timer), title: Text(' 生日预测 ')),
            BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text(' 车牌预测 ')),
          // BottomNavigationBarItem(icon: Icon(Icons.devices_other), title:  Text(' 其他 ')),
        ],
        unselectedItemColor: Colors.blueGrey,
        currentIndex: _selectedIndex, //当前选中项的索引
        fixedColor: Colors.deepPurple, //当前选中项的颜色
        onTap: _onItemTapped, //选择按下处理
      ),
    );
  }

  //选择按下处理, 设置当前索引为index值
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // appAds.showBannerAd(state: this, anchorOffset: null);
    });
  }
}
