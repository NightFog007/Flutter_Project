import 'package:flutter/material.dart';
import 'package:redo_hongnvyou/com.dart';

import 'package:dio/dio.dart';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/services.dart';

import 'package:redo_hongnvyou/admob_info.dart';

class three extends StatefulWidget {
  three() {
    print("执行了structure");
  }

  @override
  State<StatefulWidget> createState() {
    print("执行了createState方法");
    // 将创建的State返回
    return threeState();
  }
}

class threeState extends State<three> {

    var la = new Launch();

  var ad = new admob_info();

  threeState() {
    print("执行MyCounterState的构造方法");
  }

  @override
  void initState() {
    super.initState();
    ad.bannerSize = AdmobBannerSize.BANNER;

    ad.init_screenad();

    print("执行MyCounterState的init方法");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("执行MyCounterState的didChangeDependencies方法");
  }

  @override
  Widget build(BuildContext contet) {
     var flatButton = FlatButton(
      // color: Colors.lightGreen,
      color: Color.fromARGB(0, 22, 17, 175),
      child: Text(
        "点我,来一句晚安心语吧",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      textColor: Colors.white,

      onPressed: () async {
        if (await ad.interstitialAd.isLoaded) {
          ad.interstitialAd.show();
        } else {
          print("Interstitial ad is still loading...");
        }

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return three_result();
        }));
      },
    );
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/34.png"),
          fit: BoxFit.cover,
        ),
      ),
      child:Stack(
          children: <Widget>[
            Positioned(
                child: flatButton,
                // left: 0,
                top: 150),
              // Positioned(
              //     child:FlatButton(
              //           color: Colors.blue,
              //           child: Text("淘抢购"),
              //           textColor: Colors.white,
              //           onPressed: (){
              //             la.launchURL();
              //           },
              //         ),
              //         bottom:80,
              //   ),
            Positioned(
                child: AdmobBanner(
              adUnitId: ad.bannerUnitIdOne,
              // adSize: AdmobBannerSize(width: 320, height: 50, name: 'BANNER'),
              adSize: ad.bannerSize,

              listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                ad.handleEvent(event, args, 'Banner');
              },
            ),
                bottom: 20),
        
          ],
          alignment: Alignment.center,
        )
      // child: Center(
      //     child: ListView(
      //   children: <Widget>[
      //     Center(
      //       child: flatButton,
      //     ),
      //     Container(
      //       margin: EdgeInsets.only(bottom: 20.0),
      //       child: AdmobBanner(
      //         adUnitId: "ca-app-pub-9010870803829618/4747943384",
      //                   adSize: AdmobBannerSize(width: 320, height: 50, name: 'BANNER'),

      //         listener: (AdmobAdEvent event, Map<String, dynamic> args) {
      //           ad.handleEvent(event, args, 'Banner');
      //         },
      //       ),
      //     ),
      //   ],
      // )),
    ));
  }

  @override
  void didUpdateWidget(three oldWidget) {
    super.didUpdateWidget(oldWidget);
   }

  @override
  void dispose() {
    super.dispose();
   }
}


@immutable
class ClipboardData {
  /// Creates data for the system clipboard.
  const ClipboardData({ this.text });

  /// Plain text variant of this clipboard data.
  final String text;
}


class Clipboard {
  Clipboard._();

  // Constants for common [getData] [format] types.

  /// Plain text data format string.
  ///
  /// Used with [getData].
  static const String kTextPlain = 'text/plain';

  /// Stores the given clipboard data on the clipboard.
  ///将ClipboardData中的内容复制的粘贴板
  static Future<void> setData(ClipboardData data) async {
    await SystemChannels.platform.invokeMethod<void>(
      'Clipboard.setData',
      <String, dynamic>{
        'text': data.text,
      },
    );
  }
}




//展示结果界面
class three_result extends StatefulWidget {
  three_result() {}

  @override
  State<StatefulWidget> createState() {
    // 将创建的State返回
    return three_resultState();
  }
}

class three_resultState extends State<three_result> {
  var result_text = "";

  void getHttp() async {
    try {
      Response response = await Dio().get(
          "http://api.tianapi.com/txapi/wanan/?key=ca4f25b93495f1001c3a81dd9972b89c");
       var tmp = response.data;

      var tmp2 = tmp["newslist"];

      result_text = tmp2[0]["content"];

      setState(() {
        // appAds.showBannerAd(state: this, anchorOffset: null);
      });
    } catch (e) {
      print(e);
    }
  }

  three_resultState() {}

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  

  @override
  Widget build(BuildContext contet) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/34.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(

              padding: EdgeInsets.fromLTRB(80, 200, 80, 50),
              child: Column(
                children: <Widget>[
                  Center(
                    // color: Colors.green,
                    child: Text(result_text,
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    child: Text("一键复制"),
                    textColor: Colors.white,
                    onPressed: () {
                      ClipboardData data = new ClipboardData(text: result_text);
                      Clipboard.setData(data);
                      ToastHelper.showToast(context,"复制成功");

                    },
                  ),
                ],
              ))
      ),
    );
  }

  @override
  void didUpdateWidget(three_result oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
