import 'package:flutter/material.dart';
import 'Pages/fantiPage.dart';
import 'Pages/huoxingPage.dart';
import 'Pages/myPage.dart';
import 'Pages/startPage.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() {
  Admob.initialize("ca-app-pub-3940256099942544~1458002511");

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

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;
  
    @override
  void initState() {
        _controller = PageController(initialPage: _position,);

    super.initState();
    bannerSize = AdmobBannerSize.BANNER;
    interstitialAd = AdmobInterstitial(
      adUnitId: "ca-app-pub-3940256099942544/4411468910",
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
  }
  
void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        print('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;

      default:
    }
  }


  final pages = [StartPage(), FantiPage(), HuoxingPage(), MyPage()];


  var _position = 0;

  final iconsMap = {
    "图鉴":Icons.home,
    "动态":Icons.toys,
    "喜欢":Icons.favorite,
    // "手册":Icons.class_,
    "我的":Icons.account_circle,
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

      // body: AdmobBanner(
      //     adUnitId: "ca-app-pub-3940256099942544/2934735716",
      //     adSize: bannerSize,
      //     listener: (AdmobAdEvent event, Map<String, dynamic> args) {
      //       handleEvent(event, args, 'Banner');
      //     },
      //   ),

    //   body: Column(
        
    //     children: [
    //       pages[_position],
    //     // AdmobBanner(
    //     //   adUnitId: "ca-app-pub-3940256099942544/2934735716",
    //     //   adSize: bannerSize,
    //     //   listener: (AdmobAdEvent event, Map<String, dynamic> args) {
    //     //     handleEvent(event, args, 'Banner');
    //     //   },
    //     // ),
    //     ],
    // ),
      
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
