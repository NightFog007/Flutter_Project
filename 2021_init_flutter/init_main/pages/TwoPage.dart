import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../comm/ads.dart';

class TwoPage extends StatefulWidget {
    @override
    createState() => new TwoPageState();
}

class TwoPageState  extends State<TwoPage> {

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
  			
  		return new Text("two");
    }
}


