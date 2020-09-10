import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import '../admob_info.dart';
import 'package:dio/dio.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  var input_text = '测试的中文啊';

    void getHttp(input_text) async {
    try {
      Response response = await Dio().get(
          "http://japi.juhe.cn/charconvert/change.from?text=" + input_text + "&type=2&key=3f598eb8834c968feefe1a63f1fbeabe");
      // var tmp = response.data.toString();
      var tmp = response.data;
      print("-------------");
      print(tmp);

      var tmp2 = tmp["returnObj"];

      final_text = tmp2[0];

      print(final_text);

      setState(() {
        print("刷新");
      });
    } catch (e) {
      print(e);
    }
  }


  var final_text = "none";
  final FocusNode _focusNode = FocusNode();

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
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var new_banner = AdmobBanner(
      adUnitId: ad.bannerUnitIdOne,
      adSize: AdmobBannerSize(width: 320, height: 50, name: 'BANNER'),
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

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new_banner,
            _buildTextField(context),
            _buildSubmitBtn(),
        
            //new_flatButton,
          
            Text(
     final_text,
      style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          backgroundColor: Colors.black,
          shadows: [
            Shadow(
                color: Colors.cyanAccent, 
                offset: Offset(1, 1), 
                blurRadius: 10),
            Shadow(
                color: Colors.blue, 
                offset: Offset(-0.1, 0.1), 
                blurRadius: 10),
          ]),),


            Spacer(),
            new_banner,
          ],
        ),
      ),
    );
  }

  Container _buildTextField(BuildContext context) {
    return Container(
      width: 300,
      child: TextField(
        style: TextStyle(color: Colors.blue),
        minLines: 3,
        maxLines: 5,
        cursorColor: Colors.green,
        cursorRadius: Radius.circular(3),
        cursorWidth: 5,
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "请输入...",
          border: OutlineInputBorder(),
        ),
        onChanged: (v) {},
      ),
    );
  }

  _buildSubmitBtn() => FlatButton(
      color: Colors.blue,
      child: Text(
        "提交",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      // onPressed: () => FocusScope.of(context).requestFocus(_focusNode)
      onPressed: (){
        getHttp('哈哈哈');
      },



      );
}
