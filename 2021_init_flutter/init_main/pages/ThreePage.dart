import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../comm/ads.dart';

class ThreePage extends StatefulWidget {
    @override
    createState() => new ThreePageState();
}

class ThreePageState  extends State<ThreePage> {

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


    @override
    Widget build(BuildContext context) {
  			
  		return new Text("three");
    }
}


