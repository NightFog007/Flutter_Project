import 'package:flutter/material.dart';
import './wrongData.dart';

class WrongPage extends StatefulWidget {
  WrongPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _WrongPageState createState() => _WrongPageState();
}

class _WrongPageState extends State<WrongPage> {
  

  @override
  Widget build(BuildContext context) {
    
   return Scaffold(
      appBar: AppBar(
        title: Text('111'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            Text(
              '错题集合',
              // style: Theme.of(context).textTheme.display1,
            ),      
          ],
        ),
      ),
      
    );
  }
}