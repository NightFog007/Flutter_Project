import 'dart:math';
import 'package:dio/dio.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import './details.dart';
// import './ui/widgets/mybottomnavbar.dart';
import '../widgets/mybottomnavbaritem.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:haomacejixiongPro/global.dart';
import 'package:haomacejixiongPro/copy.dart';
import 'package:admob_flutter/admob_flutter.dart';

// class HomeScreen extends StatelessWidget {
int _active = 0;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();
    bannerSize = AdmobBannerSize.BANNER;
    interstitialAd = AdmobInterstitial(
      adUnitId: "ca-app-pub-9010870803829618/9968137595",
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

  @override
  void dispose() {
    // appAds.dispose();
    super.dispose();
  }

  //选择按下处理, 设置当前索引为index值
  void _onItemTapped(int index) {
    setState(() {
      _active = index;
      // appAds.showBannerAd(state: this, anchorOffset: null);
    });
  }

  var number = "1";

  var result_str = " ";

  void getHttp() async {
    try {
      // Response response = await Dio().get("http://api.tianapi.com/txapi/jixiong/?key=ca4f25b93495f1001c3a81dd9972b89c&number=138001381235");

      var request_str =
          "http://api.tianapi.com/txapi/jixiong/?key=ca4f25b93495f1001c3a81dd9972b89c&number=" +
              number;
      Response response = await Dio().get(request_str);

      print(response);

      print("-------------");

      // print(response.data.toString());

      result_str = response.data.toString();

      var s1 = response.data["newslist"];
      var s2 = s1[0];
      var s3 = s2["conclusion"];
      var s4 = s2["result"];
      var s5 = s2["score"];

      result_str = "凶吉结果: " + s4 + "\n" + "号码评分: " + s5 + "\n" + "号码解析: " + s3 ;

      setState(() {
        HomeScreen();
      });
    } catch (e) {
      print(e);
    }
  }

  void buttonPressed() {
    // print('按下按钮');
    // print(number);
    getHttp();

    // appAds.showBannerAd(state: this, anchorOffset: null);

    print("main进入处理");
    // appAds.showFullScreenAd();
    // appAds.showBannerAd(state: this, anchorOffset: 500);
  }

  

  int _selectedIndex = 0; //当前选中项索引
  final _widgetOptions = [
    Text('QQ预测'),
    Text('手机预测'),
    Text('生日预测'),
    Text('车牌预测'),
    // Text('Index 3: 其他'),
  ];

  final _widgetOptionsDetail = [
    Text('输入QQ号码',
        style: TextStyle(
          // color:Colors.blue,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        )),
    Text('输入手机号码'),
    Text('格式19950508'),
    // Text('Index 3: 其他'),
    Text('输入车牌号'),
  ];

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    controller.addListener(() {
      // print('your input is : ${controller.text}');
    });
    return Scaffold(
      backgroundColor: Color(0xff2446a6),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: MediaQuery.of(context).size.height / 3,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(
                      color: Color(0xff4169d8),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Color(0xff3a5fc8),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 70,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    // Text(
                    //   "My Profile",
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .display1
                    //       .apply(color: Colors.white),
                    // ),

                    Container(
                      alignment:Alignment.center,
                      child: AdmobBanner(
                        adUnitId: "ca-app-pub-9010870803829618/8330787683",
                        adSize: bannerSize,
                        listener:
                            (AdmobAdEvent event, Map<String, dynamic> args) {
                          handleEvent(event, args, 'Banner');
                        },
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      User.profilePicture,
                                      fit: BoxFit.cover,
                                      height: 35,
                                      width: 35,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    // "${User.fullname}",
                                    // "请输入电话号码",
                                    _widgetOptionsDetail
                                        .elementAt(_active)
                                        .data,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline
                                        .apply(
                                            color: MyColors.darkBlue,
                                            fontWeightDelta: 2),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.flaky,
                                      color: MyColors.red,
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextField(
                                controller: controller, //绑定controller
                                maxLength: 30, //最大长度,右下角会出现输入数量统计
                                maxLines: 1, //最大行数
                                autocorrect: true, //是否自动更正
                                autofocus: true, //是否自动对焦
                                obscureText: false, //是否为密码
                                textAlign: TextAlign.center, //文本对齐方式
                                style: TextStyle(
                                    fontSize: 26.0,
                                    color: Colors.green), //输入文本的样式
                                //文本内容改变时回调
                                onChanged: (text) {
                                  print('文本内容改变时回调 $text');
                                  number = text;
                                },
                                //文本内容提交时回调
                                onSubmitted: (text) {
                                  print('内容提交时回调 $text');
                                  // number = text;
                                },
                                enabled: true, //是否禁用
                                //添加装饰效果
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade200, //添加灰色填充色
                                  filled: true,
                                  // helperText: 'QQ号码',
                                  helperText:
                                      _widgetOptions.elementAt(_active).data,

                                  prefixIcon:
                                      Icon(Icons.confirmation_number), //左侧图标
                                  // suffixText: _widgetOptionsDetail
                                  //     .elementAt(_active)
                                  //     .data, //右侧文本提示
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              color: MyColors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: RaisedButton(
                                      key:
                                          ValueKey<String>('SHOW INTERSTITIAL'),
                                      child: const Text('预测'),
                                      // onPressed: buttonPressed,
                                      onPressed: () async {
                                        getHttp();
          if (await interstitialAd.isLoaded) {
            interstitialAd.show();
          } else {
            print("Interstitial ad is still loading...");
          }
        },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: RaisedButton(
                                      child: const Text('一键复制'),
                                      onPressed: () {
                                        ClipboardData data = new ClipboardData(
                                            text: this.result_str);
                                        Clipboard.setData(data);
                                        ToastHelper.showToast(context, "复制成功");
                                      },

                                     


                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Spacer(),
                    Container(
                      height: 250,
                      
                      child: AutoSizeText(
                        '$result_str',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        // style: Theme.of(context)
                        //                 .textTheme
                        //                 .display1
                        //                 .apply(color: Colors.white),
                      ),
                    ),

                    //               Text(
                    //   //  Key key = key: "text_res",
                    //   '$result_str',
                    //   // '运气太好啦,哈哈哈哈哈',
                    //   textAlign: TextAlign.center,
                    //   style: Theme.of(context)
                    //                     .textTheme
                    //                     .display1
                    //                     .apply(color: Colors.white),
                    // ),

                    // SizedBox(
                    //   height: 5,
                    // ),
                    Container(
                      alignment:Alignment.center,
                      child: AdmobBanner(
                        adUnitId: "ca-app-pub-9010870803829618/7785357619",
                        adSize: bannerSize,
                        listener:
                            (AdmobAdEvent event, Map<String, dynamic> args) {
                          handleEvent(event, args, 'Banner');
                        },
                      ),
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              height: 60,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                // child: MyBottomNavBar(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyBottomNavBarItem(
                      active: _active,
                      id: 0,
                      icon: Icons.send,
                      text: "QQ预测",
                      function: () {
                        setState(() {
                          _active = 0;
                        });
                      },
                    ),
                    MyBottomNavBarItem(
                      active: _active,
                      id: 1,
                      icon: Icons.phone,
                      text: "手机预测",
                      function: () {
                        setState(() {
                          _active = 1;
                        });
                      },
                    ),
                    MyBottomNavBarItem(
                      active: _active,
                      id: 2,
                      icon: Icons.cake,
                      text: "生日预测",
                      function: () {
                        setState(() {
                          _active = 2;
                        });
                      },
                    ),
                    MyBottomNavBarItem(
                      active: _active,
                      id: 3,
                      icon: Icons.car_rental,
                      text: "车牌预测",
                      function: () {
                        setState(() {
                          _active = 3;
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
