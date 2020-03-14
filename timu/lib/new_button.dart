import 'package:timu/new_text.dart';
import 'package:flutter/material.dart';

typedef OnPressed();

class ButtonWidget extends StatefulWidget {
  OnPressed onPressed;

  ButtonWidget({this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return _ButtonWidgetState(onPressed);
  }
}

class _ButtonWidgetState extends State<ButtonWidget> {
  OnPressed _onPressed;

  _ButtonWidgetState(this._onPressed);

  GlobalKey<TextWidgetState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('答案',style: TextStyle(fontSize: 20),),
        onPressed: _onPressed,
      ),
    );
  }
}