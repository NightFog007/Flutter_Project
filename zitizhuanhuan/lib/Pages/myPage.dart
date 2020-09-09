import 'package:flutter/material.dart';

    import 'package:admob_flutter/admob_flutter.dart';
import '../admob_info.dart';
class MyPage extends StatefulWidget {
    @override
    createState() => new MyPageState();
}

class MyPageState  extends State<MyPage> {


 GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  var ad = new admob_info();
  AdmobBannerSize bannerSize;

  @override
  void initState() {
    super.initState();
    ad.bannerSize = AdmobBannerSize.BANNER;
    ad.init_screenad();
  }

  @override
  Widget build(BuildContext context) {
    var new_banner = AdmobBanner(
      adUnitId: ad.bannerUnitIdOne,
      adSize: AdmobBannerSize(width: 320, height: 90, name: 'BANNER'),
      // adSize: ad.bannerSize,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        ad.handleEvent(event, args, 'Banner');
      },
    );

    var new_flatButton = FlatButton(
      color: Colors.lightGreen,
      // color: Color.fromARGB(0, 22, 17, 175),
      child: Text(
        "点我,来一句情话吧",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      textColor: Colors.white,

      onPressed: () async {
        print("hahahaha");
        if (await ad.interstitialAd.isLoaded) {
          ad.interstitialAd.show();
        } else {
          print("Interstitial ad is still loading...");
        }
      },
    );
    
    // return Scaffold(
  			
  		return new Text("hello");
    }
}