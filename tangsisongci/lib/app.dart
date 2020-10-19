import 'package:flutter/material.dart';
// import 'package:four_tab_framwork/four.dart';
// import 'package:four_tab_framwork/one.dart';
// import './personal.dart';
// import './wrong/wrongPage.dart';

// import './right/rightPage.dart';
import './one.dart';
import './two.dart';
import './three.dart';
import './four.dart';

//应用页面使用有状态Widget
class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

//应用页面状态实现类
class AppState extends State<App> {
  //当前选中页面索引
  var _currentIndex = 0;

  //聊天页面
  // MessagePage message;
 
  // WrongPage wrongPage;
  

  //好友页面
  // Contacts contacts;
 OnePage onePage;
 TwoPage twoPage;
 ThreePage threePage;
 FourPage fourPage;
//   //我的页面
  // Personal me;

  //根据当前索引返回不同的页面
  currentPage() {
    switch (_currentIndex) {
      case 0:
        if (onePage == null) {
          onePage = OnePage();
        }
        return onePage;
      case 1:
        if (twoPage == null) {
          twoPage = TwoPage();
        }
        return twoPage;
      case 2:
         if (threePage == null) {
          threePage = ThreePage();
        }
        return threePage;
      case 3:
        if (fourPage == null) {
          fourPage = FourPage();
        }
        return fourPage;
      default:
    }
  }

  //渲染某个菜单项 传入菜单标题 图片路径或图标
  _popupMenuItem(String title, {String imagePath, IconData icon}) {
    return PopupMenuItem(
      child: Row(
        children: <Widget>[
          //判断是使用图片路径还是图标
          imagePath != null
              ? Image.asset(
                  imagePath,
                  width: 32.0,
                  height: 32.0,
                )
              : SizedBox(
                  width: 32.0,
                  height: 32.0,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
          //显示菜单项文本内容
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('最美古文'),
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
                '情诗',
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
                '名句',
                style: TextStyle(
                    color: _currentIndex == 1
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              ),
              icon: _currentIndex == 1
                  ? Image.asset(
                      'images/close.png',
                      width: 32.0,
                      height: 28.0,
                    )
                  : Image.asset(
                      'images/close.png',
                      width: 32.0,
                      height: 28.0,
                    )),
          BottomNavigationBarItem(
              title: Text(
                '唐诗',
                style: TextStyle(
                    color: _currentIndex == 2
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              ),
              icon: _currentIndex == 2
                  ? Image.asset(
                      'images/shi.png',
                      width: 32.0,
                      height: 28.0,
                    )
                  : Image.asset(
                      'images/shi.png',
                      width: 32.0,
                      height: 28.0,
                    )),
          BottomNavigationBarItem(
              title: Text(
                '宋词',
                style: TextStyle(
                    color: _currentIndex == 3
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              ),
              icon: _currentIndex == 3
                  ? Image.asset(
                      'images/taici.png',
                      width: 32.0,
                      height: 28.0,
                    )
                  : Image.asset(
                      'images/taici.png',
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
