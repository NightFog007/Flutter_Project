import 'package:flutter/material.dart';
import 'about_page.dart';
import 'shoucang_page.dart';
import 'zaixian_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '面试冲鸭'),
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

  //当前选中页面索引
  var _currentIndex = 0;

  ZaiXianPage zaixianPage;
  ShouCangePage shoucangPage;
  AboutPage aboutPage;
  

  //根据当前索引返回不同的页面
  currentPage() {
    switch (_currentIndex) {
      case 0:
        if (zaixianPage == null) {
          zaixianPage = ZaiXianPage();
        }
        return zaixianPage;
      case 1:
        if (shoucangPage == null) {
          shoucangPage = ShouCangePage();
        }
        return shoucangPage;
      case 2:
        if (aboutPage == null) {
          aboutPage = AboutPage();
        }
        return aboutPage;
      default:
    }
  }


  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      //底部导航按钮
      bottomNavigationBar: BottomNavigationBar(
        //通过fixedColor设置选中item 的颜色
        type: BottomNavigationBarType.fixed,
        //当前页面索引
        currentIndex: _currentIndex,
        //按下后设置当前页面索引
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
        //底部导航按钮项
        items: [
          //导航按钮项传入文本及图标
          BottomNavigationBarItem(
              title: Text(
                '答题',
                style: TextStyle(
                    color: _currentIndex == 0
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              ),
              //判断当前索引作图片切换显示
              icon: _currentIndex == 0
                  ? Image.asset(
                      'images/message_pressed.png',
                      width: 32.0,
                      height: 28.0,
                    )
                  : Image.asset(
                      'images/message_normal.png',
                      width: 32.0,
                      height: 28.0,
                    )),
          BottomNavigationBarItem(
              title: Text(
                '错题',
                style: TextStyle(
                    color: _currentIndex == 1
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              ),
              icon: _currentIndex == 1
                  ? Image.asset(
                      'images/contact_list_pressed.png',
                      width: 32.0,
                      height: 28.0,
                    )
                  : Image.asset(
                      'images/contact_list_normal.png',
                      width: 32.0,
                      height: 28.0,
                    )),
          BottomNavigationBarItem(
              title: Text(
                '关于我',
                style: TextStyle(
                    color: _currentIndex == 2
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              ),
              icon: _currentIndex == 2
                  ? Image.asset(
                      'images/profile_pressed.png',
                      width: 32.0,
                      height: 28.0,
                    )
                  : Image.asset(
                      'images/profile_normal.png',
                      width: 32.0,
                      height: 28.0,
                    )),
        ],
      ),
      //中间显示当前页面
      body: currentPage(),
      // body: Text('123'),
    
    );
  }
}


