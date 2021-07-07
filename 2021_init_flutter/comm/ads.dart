import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import 'package:flutter/material.dart';

const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

class AdsBannerWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AdsBannerWidgetState();
  }
}


class AdsBannerWidgetState extends State<AdsBannerWidget> {

  BannerAd? anchoredBanner;
  bool loadingAnchoredBanner = false;


  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  
  
  Future<void> createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }
    

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

    @override
  void dispose() {
    super.dispose();

    anchoredBanner?.dispose();
  }



  @override
  Widget build(BuildContext context) {

     if (!loadingAnchoredBanner) {
          loadingAnchoredBanner = true;
          createAnchoredBanner(context);
        }

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (anchoredBanner != null)
                  Container(
                    color: Colors.green,
                    width: anchoredBanner!.size.width.toDouble(),
                    height: anchoredBanner!.size.height.toDouble(),
                    child: AdWidget(ad: anchoredBanner!),
                  ),
          ],
        ),

    );
  }
}



//---------------InterstitialAd

class AdsInterstitialWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdsInterstitialWidgetState();
  }
}


class AdsInterstitialWidgetState extends State<AdsInterstitialWidget> {

  InterstitialAd? interstitialAd;
  int numInterstitialLoadAttempts = 0;


  @override
  void initState() {
    super.initState();
    createInterstitialAd();
  }

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  
  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            interstitialAd = ad;
            numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            numInterstitialLoadAttempts += 1;
            interstitialAd = null;
            if (numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  

  @override
  void dispose() {
    super.dispose();
    interstitialAd?.dispose();
  }



  @override
  Widget build(BuildContext context) {

     

    return FlatButton(
          child: Text("", 
                  style: TextStyle(color: Colors.black)
                  ),
                color: Colors.orange, // 按钮的颜色
                // highlightColor: Colors.orange[700], // 按下去高亮颜色
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // 圆角的实现
                  onPressed:showInterstitialAd ,
);
  }
}



//----------------reward

class AdsRewardWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AdsRewardWidgetState();
  }
}


class AdsRewardWidgetState extends State<AdsRewardWidget> {


  RewardedAd? rewardedAd;
  int numRewardedLoadAttempts = 0;

 

  @override
  void initState() {
    super.initState();
    createRewardedAd();
  }

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            rewardedAd = ad;
            numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            rewardedAd = null;
            numRewardedLoadAttempts += 1;
            if (numRewardedLoadAttempts <= maxFailedLoadAttempts) {
              createRewardedAd();
            }
          },
        ));
  }

  void showRewardedAd() {
    if (rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    rewardedAd = null;
  }


    @override
  void dispose() {
    super.dispose();
    rewardedAd?.dispose();
  }



  @override
  Widget build(BuildContext context) {

 

    return FlatButton(
          child: Text("", 
                  style: TextStyle(color: Colors.black)
                  ),
                color: Colors.orange, // 按钮的颜色
                  onPressed:showRewardedAd ,
);
  }
}