import '../New_Widgets/new_button.dart';
import '../New_Widgets/new_text.dart';
import '../New_Widgets/copy_button.dart';

import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import '../admob_info.dart';

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

  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  GlobalKey<TextWidgetState> textKey = GlobalKey(); //同步刷新数据

  final TextEditingController controller = TextEditingController(); //监听文本输入框

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
      backgroundColor: Colors.limeAccent,
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new_banner,
            _buildTextField(context),
            ButtonWidget(
              onPressed: () {
                tmpgethttp.getHttp(input_text, "1", textKey);
                print(textKey.currentState.toString());
              },
            ),
            TextWidget(textKey),
            CopyButtonWidget(),
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
