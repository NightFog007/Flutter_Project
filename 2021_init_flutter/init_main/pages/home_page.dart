import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../comm/ads.dart';
import 'AboutPage.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var bannerAds = AdsBannerWidget();

  var interAds = AdsInterstitialWidgetState();

  var rewardAds = AdsRewardWidgetState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    interAds.createInterstitialAd();
    rewardAds.createRewardedAd();
  }



   var _message = '';

  _onPushTop(BuildContext context) {
    final future = Navigator.of(context)
        .pushNamed('/detail', arguments: "a home message of naned route");

    // 2.获取结果
    future.then((res) {
      setState(() {
        _message = res;
      });
    });
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
      appBar: AppBar(title: Text(widget.title),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '显示结果: ' + _message,
            ),
            FlatButton(
              child: Text("跳转下一页", style: TextStyle(color: Colors.black)),
              onPressed: () => _onPushTop(context),
            ),
            RaisedButton(
              child: Text("打开关于页"),
              onPressed: () {
                Navigator.of(context).pushNamed(AboutPage.routeName,
                    arguments: "a home message");
              },
            ),
            RaisedButton(
              child: Text("打开未知页面"),
              onPressed: () {
                Navigator.of(context).pushNamed("/abc");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: _buildHomeButton()
    );
  }

  //抽离成方法单独管理
  Widget _buildHomeButton() {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}