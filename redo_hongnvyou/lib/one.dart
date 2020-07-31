import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:redo_hongnvyou/db_helpers.dart';
import 'package:redo_hongnvyou/com.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:redo_hongnvyou/admob_info.dart';

class one extends StatefulWidget {
  one() {
    print("执行了structure");
  }

  @override
  State<StatefulWidget> createState() {
    print("执行了createState方法");
    // 将创建的State返回
    return oneState();
  }
}

class oneState extends State<one> {
  oneState() {
    get_love_word();
    get_english();

    get_weather(city);
  }

  Timu todo = new Timu();

  var weather = "";

  var english = "Hi, My Sweet!";

  var hername = " ";
  var myname = "最爱你的我";
  var city = "";

  var date = "20170101";
  var love_word = "";

  var id = 1;

  void get_english() async {
    try {
      Response response = await Dio().get("https://api.ooopn.com/ciba/api.php");
      var tmp = response.data["ciba"];
      var tmp_en = response.data["ciba-en"];
      english = tmp + "\n" + tmp_en;
    } catch (e) {
      print(e);
    }
  }

  void get_love_word() async {
    try {
      Response response = await Dio().get(
          "https://api.lovelive.tools/api/SweetNothings/1/Serialization/Json");
      // var tmp = response.data.toString();
      var tmp = response.data;
      print("-------------");
      print(tmp);

      var tmp2 = tmp["returnObj"];

      love_word = tmp2[0];
    } catch (e) {
      print(e);
    }
  }

  String get_day(String theday) {
    // theday = "20170124";
    var year = theday.substring(0, 4);
    var month = theday.substring(4, 6);
    var day = theday.substring(6, 8);

    var d1 = new DateTime(int.parse(year), int.parse(month), int.parse(day));
    var d2 = new DateTime(2019, 10, 10);
    d2 = new DateTime.now();

    var difference = d2.difference(d1);
    var res = difference.inDays;
    print(res);

    var fianl = "这是我们在一起的第" + res.toString() + "天.";

    return fianl;
  }

  void get_weather(String city) async {
    var tmp = await DBProvider.db.getFirst("one");

    if (city == "") {
      city = tmp.city;
      print("the now city is : " + city);
    }

    var final_text = "123";

    try {
      Response response =
          await Dio().get("https://www.mxnzp.com/api/weather/current/" + city);
      var tmp = response.data["data"];

      var tianqi = tmp["weather"];
      var wendu = tmp["temp"];
      var feng = tmp["windDirection"];
      var fengli = tmp["windPower"];
      var address = tmp["address"];
      var shidu = tmp["humidity"];
      var time = "";
      time = tmp["reportTime"];
      time = time.substring(0, 10);

      final_text = time +
          "  " +
          address +
          "  " +
          tianqi +
          "  " +
          feng +
          "风" +
          fengli +
          "  " +
          "当前温度:" +
          wendu +
          "  " +
          "空气湿度:" +
          shidu;

      this.weather = final_text;
      print(this.weather);
    } catch (e) {
      print(e);
    }
  }

  final registerFormKey = GlobalKey<FormState>();

  void registerForm() {
    registerFormKey.currentState.save();

    todo.id = 1;
    todo.hername = hername;
    todo.city = city;
    todo.date = date;
    todo.myname = myname;

    DBProvider.db.update(todo, "one");

    // cunshuju(hername, date, city, myname);

    var final_day = get_day(date);

    var final_str = english +
        "\n\n" +
        weather +
        "\n\n" +
        hername +
        " " +
        final_day +
        "\n\n" +
        love_word +
        "\n\n" +
        "来自" +
        myname;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return one_result(
            // 路由参数
            text: final_str,
          );
        },
      ),
    );

    print("保存数据");
  }

  _launchURL() async {
    const url =
        "https://s.click.taobao.com/t?e=m%3D2%26s%3DL2CesJvCNgEcQipKwQzePCperVdZeJvi7UTzUAW%2BpR4YX8TY%2BNEwd6nH6WYiuhowTHm2guh0YLuPPeIuDtKbOVSu19OUhIzkKtj7QYO4MvYzaSBUzKe4y0I9rOd2bI%2Fcl9dxdp2kCvMAKqc2USsXlxmY%2BBNb7CKtfIrCKoPZYrQGZ%2FstJHrpqMR3fWzOxJq8naYpFBIfC%2F0TMkUtS6f4Uee2MEd8mDbNFeX0WK60lukwvJhybyexLXiugMmjfXDRDFhWT5oVJ5fGJe8N%2FwNpGw%3D%3D&union_lens=lensId%3APUB%401574410784%400b152c5a_0d16_16e92320e6a_049a%4001";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  var ad = new admob_info();

  AdmobBannerSize bannerSize;

  @override
  void initState() {
    //  chushihua();
    super.initState();

    ad.bannerSize = AdmobBannerSize.BANNER;
    ad.init_screenad();
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
          padding: EdgeInsets.all(20),
          child: Form(
            key: registerFormKey,
            child: FutureBuilder<Timu>(
              future: DBProvider.db.getFirst("one"),
              builder: (BuildContext context, AsyncSnapshot<Timu> snapshot) {
                if (snapshot.hasData) {
                  id = snapshot.data.id;
                  hername = snapshot.data.hername;
                  city = snapshot.data.city;
                  date = snapshot.data.date;
                  // date = date.replaceAll("|", "\n");
                  //  result = city + '\n\n' + date;
                  myname = snapshot.data.myname;
                  //  todo = snapshot.data;
                  print(hername);
                  print(id);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        initialValue: hername,
                        decoration: InputDecoration(
                            icon: Icon(Icons.people), labelText: "对方昵称"),
                        onSaved: (value) {
                          this.hername = value;
                        },
                      ),
                      TextFormField(
                        initialValue: city,
                        decoration: InputDecoration(
                            icon: Icon(Icons.location_city),
                            labelText: "对方所在城市"),
                        onSaved: (value) {
                          this.city = value;
                        },
                        onChanged: (text) {
                          get_weather(text);
                        },
                      ),
                      TextFormField(
                        initialValue: date,
                        decoration: InputDecoration(
                            icon: Icon(Icons.calendar_view_day),
                            labelText: "相识日期-格式20170201"),
                        onSaved: (value) {
                          this.date = value;
                        },
                      ),
                      TextFormField(
                        initialValue: myname,
                        decoration: InputDecoration(
                            icon: Icon(Icons.people_outline),
                            labelText: "你的称呼"),
                        onSaved: (value) {
                          this.myname = value;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        height: 44,
                        child: RaisedButton(
                          color: Colors.lightGreen,
                          child: Text(
                            "生成",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: () async {
                            if (await ad.interstitialAd.isLoaded) {
                              ad.interstitialAd.show();
                            } else {
                              print("Interstitial ad is still loading...");
                            }
                            registerForm();
                          },
                        ),
                      ),
                      // FlatButton(
                      //   color: Colors.blue,
                      //   child: Text("淘抢购"),
                      //   textColor: Colors.white,
                      //   onPressed: _launchURL,
                      // ),
                      AdmobBanner(
                        adUnitId: ad.bannerUnitIdOne,
                        adSize: ad.bannerSize,
                        listener:
                            (AdmobAdEvent event, Map<String, dynamic> args) {
                          ad.handleEvent(event, args, 'Banner');
                        },
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(one oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("执行MyCounterState的didUpdateWidget方法");
  }

  @override
  void dispose() {
    super.dispose();
    print("执行MyCounterState的dispose方法");
  }
}

class Todo {
  final String title = "1";
  final String description = "2";

  String weather;
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

class one_result extends StatelessWidget {
  // Declare a field that holds the Todo
  // final Todo todo;
  final String text;
  // var xyz;
  // In the constructor, require a Todo
  one_result({
    Key key,
    @required this.text, // 接收一个text参数
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("暖心话"),
        // title: new Text("123"),
      ),
      body: new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/34.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 10),
              child: Column(
                children: <Widget>[
                  Center(
                    // color: Colors.green,
                    child: Text(text,
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    child: Text("一键复制"),
                    textColor: Colors.white,
                    onPressed: () {
                      ClipboardData data = new ClipboardData(text: text);
                      Clipboard.setData(data);
                      ToastHelper.showToast(context, "复制成功");
                    },
                  ),
                ],
              ))),
    );
  }
}
