import '../New_Widgets/new_button.dart';
import '../New_Widgets/new_text.dart';

import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import '../admob_info.dart';
import 'package:dio/dio.dart';

import 'package:zitizhuanhuan/myClass.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  var tmpgethttp = MyClass();

    var input_text = '明知道让你离开他的世界不可能会';

  void getHttp(input_text, input_type) async {
    try {
      Response response = await Dio().get(
          "http://japi.juhe.cn/charconvert/change.from?text=" +
              input_text +
              "&type=" +
              input_type +
              "&key=3f598eb8834c968feefe1a63f1fbeabe");

      var tmp = response.data;
      print("-------------");

      var new_index = tmp.indexOf('"outstr":"') + 10;

      var final_text = tmp.substring(new_index);

      var xx = final_text.indexOf('"');
      var yyy = final_text.substring(0, xx);
      // print("***********************************************");
      // print(yyy);
      textKey.currentState.onPressed(yyy);
    } catch (e) {
      print(e);
    }
  }



  GlobalKey<TextWidgetState> textKey = GlobalKey();  //同步刷新数据

  final TextEditingController controller = TextEditingController();  //监听文本输入框


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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      print('你输入的内容为:${controller.text}');
      input_text = controller.text;
    });

    var new_banner = AdmobBanner(
      adUnitId: ad.bannerUnitIdOne,
      adSize: AdmobBannerSize(width: 320, height: 50, name: 'BANNER'),
      // adSize: ad.bannerSize,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        ad.handleEvent(event, args, 'Banner');
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            new_banner,

            _buildTextField(context),

            ButtonWidget(
              onPressed: () {
                // getHttp(input_text, "1");
                tmpgethttp.getHttp(input_text, "1", textKey);
              },
            ),

            TextWidget(textKey),

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
        keyboardType: TextInputType.text,
        controller: controller,
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

}
