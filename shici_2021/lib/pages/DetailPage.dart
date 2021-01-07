import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  // 按钮点击执行的代码
  _onBackTap(BuildContext context) {
    Navigator.of(context).pop("a detail message");
  }

  @override
  Widget build(BuildContext context) {
    //接收上级页面传过来的参数
    final message = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      appBar: new AppBar(
        title: Text('这是第二页'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop("a back detail message");
          },
        ),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '首页带来的内容: ' + message,
              ),

              // child:
              RaisedButton(
                child: Text("返回首页"),
                onPressed: () => _onBackTap(context),
              ),
            ]),
      ),
    );
  }
}