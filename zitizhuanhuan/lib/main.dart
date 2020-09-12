import 'package:flutter/material.dart';
import 'Pages/secondPage.dart';
import 'Pages/thirdPage.dart';
import 'Pages/myPage.dart';
import 'Pages/startPage.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() {
  Admob.initialize("ca-app-pub-9010870803829618~8140498881");

  runApp(MyApp());  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '字体转换'),
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
  void initState() {
        _controller = PageController(initialPage: _position,);

    super.initState();
    
  }
  


  final pages = [StartPage(), SecondPage(), ThirdPage(), MyPage()];


  var _position = 0;

  final iconsMap = {
    "繁体":Icons.home,
    "火星":Icons.toys,
    "简体":Icons.favorite,
    // "手册":Icons.class_,
    // "设置":Icons.account_circle,
  };
  final _colors = [
    Colors.lightGreen,
    // Colors.yellow,
    Colors.blueGrey,
    Colors.lightBlue,
    Colors.purple,
  ];

  PageController _controller;

  

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


// //定义每个item对应的页面
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("首页"),
//     );
//   }
// }

// class CartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("CartPage"),
//     );
//   }
// }

// class MsgPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("MsgPage"),
//     );
//   }
// }

// class PersonPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("PersonPage"),
//     );
//   }
// }

// class FivePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("FivePage"),
//     );
//   }
// }
