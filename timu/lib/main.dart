import 'package:flutter/material.dart';

import 'package:timu/danxuanti.dart';
import 'package:timu/duoxuanti.dart';
import 'package:timu/panduanti.dart';
import 'package:timu/store_page.dart';



// void main() => runApp(MyApp());

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '上岗专业A证题目',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/单选题': (context) =>
            Danxuanti(title: '单选题'),
        '/多选题': (context) => Duoxuanti(title: '多选题'),
        '/判断题': (context) => Panduanti(
              title: '判断题',
              // storage: InfoStorage(),
            ),
      },
      home: StorePage(title: '上岗专业A证题目'),
    );
  }
}

