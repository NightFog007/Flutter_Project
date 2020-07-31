import 'package:flutter/material.dart';


class four extends StatefulWidget {
  
  four() {
    print("执行了structure");
  }
  
  @override
  State<StatefulWidget> createState() {
    print("执行了createState方法");
    // 将创建的State返回
    return fourState();
  }
}

class fourState extends State<four> {
  
  fourState() {
    print("执行MyCounterState的构造方法");
  }

  @override
  void initState() {
    super.initState();
    print("执行MyCounterState的init方法");
  }
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("执行MyCounterState的didChangeDependencies方法");
  }


  @override
  Widget build(BuildContext contet){
    return Scaffold(
      
      body: Container(
        color: Colors.green,
        child: Text("container",
            style: TextStyle(color: Colors.white, fontSize: 30.0)),
        constraints: BoxConstraints(
          maxHeight: 200.0,
          maxWidth: 200.0,
          minWidth: 50.0,
          minHeight: 50.0,
        ),
        // padding: EdgeInsets.only(),//外边距
        // margin: EdgeInsets.only(top: 50.0,left: 50.0), //内边距
        alignment: Alignment.center,
      ),
    );
  }



  @override
  void didUpdateWidget(four oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("执行MyCounterState的didUpdateWidget方法");
  }

  @override
  void dispose() {
    super.dispose();
    print("执行MyCounterState的dispose方法");
  }
}