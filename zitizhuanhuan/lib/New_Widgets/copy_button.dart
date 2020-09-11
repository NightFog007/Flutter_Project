import 'new_text.dart';

import 'package:flutter/material.dart';
import 'package:zitizhuanhuan/copy.dart';




class CopyButtonWidget extends StatefulWidget {
  CopyButtonWidget(Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CopyButtonWidgetState();
  }
}

class CopyButtonWidgetState extends State<CopyButtonWidget> {
  String _text="";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('一键复制',
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
      // _text = count;
          ClipboardData data = new ClipboardData(text:count);
          Clipboard.setData(data);
          ToastHelper.showToast(context, "复制成功");
    });
  }

  
}