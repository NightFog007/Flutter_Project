//常见属性
//iconSize: double.  按钮图标大小.
//items: List<BottomNavigationBarItem>.  底部导航条按钮集. 每一项是一个BottomNavigationBarItem,有icon图标及title文本属性.

import 'package:flutter/material.dart';
import 'package:redo_hongnvyou/one.dart';
import 'package:redo_hongnvyou/two.dart';
import 'package:redo_hongnvyou/three.dart';
import 'package:redo_hongnvyou/four.dart';

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

  int _selectedIndex = 1; //当前选中项索引
  final _widgetOptions = [
    one(),
    two(),
    three(),
    four(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题栏'),
      ),
      body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
      ),

      //  body: one(),


      //底部导航按钮,包含图标及文本
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('每日暖心')),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), title: Text('一句情话')),
          BottomNavigationBarItem(icon: Icon(Icons.timer), title: Text('晚安心语')),
          BottomNavigationBarItem(icon: Icon(Icons.devices_other), title: Text('其他')),
        ],
        currentIndex: _selectedIndex, ////currentIndex: int . 当前索引,用来切换按钮控制. 底部导航条按下按钮切换不同页面,所以需要当前索引来控制当前具体切换的页面.

        fixedColor: Colors.deepPurple, //fixedColor: Color. 选中按钮的颜色.如果没有指定值,则用系统主题色.

        onTap: _onItemTapped, //onTap: ValueChanged<int> . 按下其中某一个按钮回调事件. 需要根据返回的索引设置当前索引.

      ),
    );
  }

  //选择按下处理, 设置当前索引为index值
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }


  @override
  void dispose() {
    super.dispose();
  }


}
