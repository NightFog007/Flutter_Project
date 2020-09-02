import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
         
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  final pages = [HomePage(), MsgPage(), CartPage(), PersonPage(),FivePage()];


  var _position = 0;

  final iconsMap = {
    "图鉴":Icons.home,
    "动态":Icons.toys,
    "喜欢":Icons.favorite,
    "手册":Icons.class_,
    "我的":Icons.account_circle,
  };
  final _colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  PageController _controller;

  @override
  void initState(){
    _controller = PageController(initialPage: _position,);
    super.initState();
  }

  @override 
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: iconsMap.keys
        .map((key) => BottomNavigationBarItem(
          title:Text(key,),
          icon:Icon(iconsMap[key]),
          backgroundColor: _colors[_position]))
        .toList(),
        currentIndex: _position,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          _changePage(index);
        },
      ),      
      
      body: pages[_position],
      
    );
  }


/*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != _position) {
      setState(() {
        _position = index;
      });
    }
  }


}


//定义每个item对应的页面
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("首页"),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("CartPage"),
    );
  }
}

class MsgPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("MsgPage"),
    );
  }
}

class PersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("PersonPage"),
    );
  }
}

class FivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("FivePage"),
    );
  }
}
