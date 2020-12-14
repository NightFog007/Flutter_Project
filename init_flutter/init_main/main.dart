import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/DetailPage.dart';
import 'pages/AboutPage.dart';
import 'pages/UnknownPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home:HomePage(title: 'Flutter Demo Home Page'),
      initialRoute: "/",
      routes: {
        //注册首页路由
        "/": (context) => HomePage(title: 'Flutter Demo Home Page'), 
        "/detail": (context) => DetailPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/about") {
          return MaterialPageRoute(builder: (ctx) {
            return AboutPage(settings.arguments);
          });
        }
        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) {
          return UnknownPage();
        });
      },
    );
  }
}


