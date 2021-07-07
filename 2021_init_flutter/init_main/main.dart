import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/ThreePage.dart';
import 'pages/TwoPage.dart';
import 'pages/FourPage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import '../comm/ads.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}
class MyColors {
  static const Color mainColor = Color(0xfff8e6da),
      accentColor = Color(0xffffcda6);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    final pages = [HomePage(), TwoPage(), ThreePage(), FourPage()];

    int _selectedIndex = 0;

   void _onItemTapped(int index) {
    setState(() {
      print(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar( // 底部导航
        backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor:  MyColors.accentColor,
          unselectedItemColor: Colors.black12,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('people')),
        ],
        currentIndex: _selectedIndex,
        // fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
  body: pages[_selectedIndex],

    );
  }
}

