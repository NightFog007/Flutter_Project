import 'package:flutter/material.dart';

//调用方法
//TextWidget(textKey),

class TextWidget extends StatefulWidget {
  TextWidget(Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TextWidgetState();
  }
}

class TextWidgetState extends State<TextWidget> {
  String _text="";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_text,
      style: TextStyle(
          fontSize: 20,
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
          ]),
      ),
    );
  }

  void onPressed(String count) {
    setState(() {
      _text = count;
    });
  }

  
}