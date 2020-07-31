import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dart:io' show Platform;
import 'package:admob_flutter/admob_flutter.dart';





class admob_info {
  GlobalKey<ScaffoldState> scaffioldState = GlobalKey();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;

  final String appId = Platform.isAndroid
      ? 'ca-app-pub-9010870803829618~5717554287'
      : 'ca-app-pub-9010870803829618~8886498940';

  final String bannerUnitIdOne = Platform.isAndroid
      ? 'ca-app-pub-9010870803829618/5854614646'
      : 'ca-app-pub-9010870803829618/4747943384';

   final String bannerUnitIdTwo = Platform.isAndroid
      ? 'ca-app-pub-9010870803829618/5854614646'
      : 'ca-app-pub-9010870803829618/1937947215';

  final String screenUnitId = Platform.isAndroid
      ? 'ca-app-pub-9010870803829618/1754258542'
      : 'ca-app-pub-9010870803829618/9425554997';

  final String videoUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-9010870803829618/1547064974';

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