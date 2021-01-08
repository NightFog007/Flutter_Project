
import 'package:flutter/material.dart';

import 'dart:io' show Platform;
import 'package:admob_flutter/admob_flutter.dart';


var test_app_id = 'ca-app-pub-9010870803829618~7151491891';
var test_banner = 'ca-app-pub-9010870803829618/6800972251';
var test_intersitital = 'ca-app-pub-9010870803829618/2477927326';



class admob_info {
  GlobalKey<ScaffoldState> scaffioldState = GlobalKey();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;

  final String appId = Platform.isAndroid
      ? 'ca-app-pub-9010870803829618~7151491891'
      : 'ca-app-pub-9010870803829618~7151491891';

  final String bannerUnitIdOne = Platform.isAndroid
      ? 'ca-app-pub-9010870803829618/6800972251'
      : 'ca-app-pub-9010870803829618/6800972251';

   final String bannerUnitIdTwo = Platform.isAndroid
      ? 'ca-app-pub-9010870803829618/6800972251'
      : 'ca-app-pub-9010870803829618/6800972251';

  final String screenUnitId = Platform.isAndroid
      ? 'ca-app-pub-9010870803829618/2477927326'
      : 'ca-app-pub-9010870803829618/2477927326';

  final String videoUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-9010870803829618/2651860130';

  void init_screenad() {
    interstitialAd = AdmobInterstitial(
      adUnitId: screenUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );

    interstitialAd.load();
  }

  void load_screenad() async {
    print("进入全屏广告方法");
    if (await interstitialAd.isLoaded) {
      interstitialAd.show();
    } else {
      print("Interstitial ad is still loading...");
    }
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
}