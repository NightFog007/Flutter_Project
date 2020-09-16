import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:ui';
import 'package:admob_flutter/admob_flutter.dart';

// import './common/http_service.dart';
// import 'dart:convert';
// import 'package:provider/provider.dart';
// import './provider/product_provider.dart';
// import './common/question_data.dart';
import './copy.dart';

class OnePage extends StatelessWidget {
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

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();
    bannerSize = AdmobBannerSize.BANNER;
    interstitialAd = AdmobInterstitial(
      adUnitId: "ca-app-pub-9010870803829618/1375664498",
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

  var res_text = "古来万事东流水";

  onFresh(){
    setState(() {
      
    });
  }

  Future<String> mockNetworkData() async {
    //请求url
    var url =
        'http://api.tianapi.com/txapi/pyqwenan/index?key=ca4f25b93495f1001c3a81dd9972b89c';
    try {
      Response response = await Dio().get(url);
      print(response);
      print("------------");
      var ttt = response.data["newslist"];
      var res_text = ttt[0]["content"];
      print(ttt[0]["content"]);
      return res_text;
    } catch (e) {
      print(e);
      return '获取数据失败';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backpic.png"),
            fit: BoxFit.cover,
          ),
        ),
        // color: Colors.blue,
        // alignment: AlignmentDirectional.topStart,
        // margin: const EdgeInsets.only(right: 1.0,top: 1.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   color: Colors.red,
            //   //时间顶部对齐
            //   alignment: AlignmentDirectional.topStart,
            //   height: 70,
            //   // margin: const EdgeInsets.only(right: 2.0,top: 22.0),
            //   child: Text(
            //     //格式化时间
            //     '广告占位',
            //     style: TextStyle(fontSize: 22.0, color: Colors.white),
            //   ),
            // ),

            Container(
              child: AdmobBanner(
                adUnitId: "ca-app-pub-9010870803829618/6614999991",
                adSize: bannerSize,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  handleEvent(event, args, 'Banner');
                },
              ),
              padding: EdgeInsets.all(1.0), // 内边距
              margin: EdgeInsets.all(1.0), // 外边距

              alignment: Alignment.center, // 子Widget居中对齐
            ),

            Container(
              child: FlatButton(
                color: Colors.yellow,
                child: Text("刷新文案"),
                onPressed: () async {
          if (await interstitialAd.isLoaded) {
            interstitialAd.show();
          } else {
            print("Interstitial ad is still loading...");
          }
          onFresh();
        },

               
              ),
              // padding: EdgeInsets.all(1.0), // 内边距
              // margin: EdgeInsets.all(44.0), // 外边距
              //  width: 180.0,
              //  height:240,
              alignment: Alignment.center, // 子Widget居中对齐
              decoration: BoxDecoration(
                //Container样式
                //  color: Colors.yellow, // 背景色
                borderRadius: BorderRadius.circular(10.0), // 圆角边框
              ),
            ),

            Container(
              // color: Colors.lightGreen,
              //时间顶部对齐
              alignment: Alignment.center, // 子Widget居中对齐
              height: 200,
              // margin: const EdgeInsets.only(right: 2.0,top: 22.0),
              child: FutureBuilder<String>(
                future: mockNetworkData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // 请求已结束
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // 请求失败，显示错误
                      return Text("Error: ${snapshot.error}");
                    } else {
                      this.res_text = snapshot.data;

                      return Text.rich(
                        TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: res_text,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                  color: Colors.lightGreen)),
                        ]),
                        textAlign: TextAlign.left,
                      );

                      // 请求成功，显示数据
                      // return Text("${snapshot.data}");
                    }
                  } else {
                    // 请求未结束，显示loading
                    return CircularProgressIndicator();
                  }
                },
              ),
              padding: EdgeInsets.all(5.0), // 内边距
              margin: EdgeInsets.all(11.0), // 外边距
              decoration: BoxDecoration(
                //Container样式
                //  color: Colors.yellow,

                borderRadius: BorderRadius.circular(10.0), // 圆角边框
              ),
            ),

            Container(
              child: FlatButton(
                child: Text("复制"),
                onPressed: () {
                  ClipboardData data = new ClipboardData(text: this.res_text);
                  Clipboard.setData(data);
                  ToastHelper.showToast(context, "复制成功");
                },
              ),
              padding: EdgeInsets.all(1.0), // 内边距
              //  margin: EdgeInsets.all(80.0), // 外边距
              margin: EdgeInsets.fromLTRB(150, 40, 150, 20),
              //  width: 180.0,
              //  height:240,
              alignment: Alignment.center, // 子Widget居中对齐
              decoration: BoxDecoration(
                //Container样式
                color: Colors.yellow, // 背景色
                borderRadius: BorderRadius.circular(10.0), // 圆角边框
              ),
            ),
          ],
        ),
      ),

    );
  }

 
}
