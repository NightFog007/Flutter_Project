import 'package:flutter/material.dart';
import './mybottomnavbaritem.dart';
class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _active = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        MyBottomNavBarItem(
          active: _active,
          id: 0,
          icon: Icons.send,
          text: "QQ预测",
          function: () {
            setState(() {
              _active = 0;
            });
          },
        ),
        MyBottomNavBarItem(
          active: _active,
          id: 1,
          icon: Icons.phone,
          text: "手机预测",
          function: () {
            setState(() {
              _active = 1;
            });
          },
        ),
        MyBottomNavBarItem(
          active: _active,
          id: 2,
          icon: Icons.cake,
          text: "生日预测",
          function: () {
            setState(() {
              _active = 2;
            });
          },
        ),
        MyBottomNavBarItem(
          active: _active,
          id: 3,
          icon: Icons.car_rental,
          text: "车牌预测",
          function: () {
            setState(() {
              _active = 3;
            });
          },
        ),
      ],
    );
  }
}