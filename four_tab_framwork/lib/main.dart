import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';


import './app.dart';



//应用程序入口
void main(){
    Admob.initialize("ca-app-pub-9010870803829618~9269083498");
runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '聊天室',
      //自定义主题
      theme: mDefaultTheme,
      //添加路由表
      routes: <String, WidgetBuilder>{
        "app": (BuildContext context) => App(),
       
      },
      //指定首页 默认为加载页面
      home:App(),
    ));
} 



//自定义主题 绿色小清新风格
final ThemeData mDefaultTheme = ThemeData(
  primaryColor: Colors.green,
  scaffoldBackgroundColor: Color(0xFFebebeb),
  cardColor: Colors.green,
);




