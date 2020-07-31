import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'dart:io' show Platform;

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/services.dart';
import 'package:redo_hongnvyou/admob_info.dart';
import 'package:redo_hongnvyou/com.dart';



class two extends StatefulWidget {
  two() {
    print("执行了structure");
  }

  @override
  State<StatefulWidget> createState() {
    print("执行了createState方法");
    // 将创建的State返回
    return twoState();
  }
}

class twoState extends State<two> {

  var la = new Launch();

  var ad = new admob_info();

  AdmobBannerSize bannerSize;


  twoState() {}

  @override
  void initState() {
    super.initState();
    ad.bannerSize = AdmobBannerSize.BANNER;
    ad.init_screenad();
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
    var flatButton = FlatButton(
      // color: Colors.lightGreen,
      color: Color.fromARGB(0, 22, 17, 175),
      child: Text(
        "点我,来一句情话吧",
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
          return two_result();
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
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: flatButton,
                    // left: 0,
                    top: 150),
                // Positioned(
                //   child:FlatButton(
                //         color: Colors.blue,
                //         child: Text("淘抢购"),
                //         textColor: Colors.white,
                //         onPressed: (){
                //           la.launchURL();
                //         },
                //       ),
                //       bottom:80,
                // ),
                Positioned(
                    child: AdmobBanner(
                      adUnitId: ad.bannerUnitIdOne,
                      adSize: ad.bannerSize,
                      listener:
                          (AdmobAdEvent event, Map<String, dynamic> args) {
                        ad.handleEvent(event, args, 'Banner');
                      },
                    ),
                    bottom: 20),
              ],
              alignment: Alignment.center,
            )

            ));
  }

  @override
  void didUpdateWidget(two oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("执行MyCounterState的didUpdateWidget方法");
  }

  @override
  void dispose() {
    super.dispose();
    ad.interstitialAd.dispose();

    print("执行MyCounterState的dispose方法");
  }
}

//展示结果界面
class two_result extends StatefulWidget {
  two_result() {
    print("执行了structure");
  }

  @override
  State<StatefulWidget> createState() {
    print("执行了createState方法");
    // 将创建的State返回
    return two_resultState();
  }
}

@immutable
class ClipboardData {
  /// Creates data for the system clipboard.
  const ClipboardData({this.text});

  /// Plain text variant of this clipboard data.
  final String text;
}

class Clipboard {
  Clipboard._();
 
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

class two_resultState extends State<two_result> {
  var ad = new admob_info();
  var helper = new ToastHelper();

  var result_text = "";

  void getHttp() async {
    try {
      Response response = await Dio().get(
          "https://api.lovelive.tools/api/SweetNothings/1/Serialization/Json");
      // var tmp = response.data.toString();
      var tmp = response.data;
      print("-------------");
      print(tmp);

      var tmp2 = tmp["returnObj"];

      result_text = tmp2[0];

      print(result_text);

      setState(() {
        // appAds.showBannerAd(state: this, anchorOffset: null);
      });
    } catch (e) {
      print(e);
    }
  }

  two_resultState() {
    print("执行MyCounterState的构造方法");
  }

  @override
  void initState() {
    super.initState();
    ad.bannerSize = AdmobBannerSize.BANNER;

    getHttp();
    print("执行MyCounterState的init方法");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("执行MyCounterState的didChangeDependencies方法");
  }



  @override
  Widget build(BuildContext context) {
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

                      //  _showToast();
                      ToastHelper.showToast(context,"复制成功");

                    },
                  ),
                ],
              ))

         

          ),
    );
  }

  @override
  void didUpdateWidget(two_result oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("执行MyCounterState的didUpdateWidget方法");
  }

  @override
  void dispose() {
    super.dispose();
    print("执行MyCounterState的dispose方法");
  }
}
