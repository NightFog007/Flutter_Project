import 'package:flutter/material.dart';
import './rightData.dart';

class RightPage extends StatefulWidget {
  RightPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _RightPageState createState() => _RightPageState();
}

class _RightPageState extends State<RightPage> {
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('111'),
      // ),
      body: Container(
        color: Colors.blue,
        // alignment: AlignmentDirectional.topStart,
              // margin: const EdgeInsets.only(right: 1.0,top: 1.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          
            Container(
              color: Colors.red,
              //时间顶部对齐
              alignment: AlignmentDirectional.topStart,
              height: 70,
              // margin: const EdgeInsets.only(right: 55.0,top: 22.0),
              child: Text(
                //格式化时间
                '广告占位',
                style: TextStyle(fontSize: 22.0,color: Colors.white),
              ),
            ),
           
            Text(
              '新冠肺炎的最长潜伏期一般是多久？',
              style: TextStyle(fontSize: 22.0,color: Colors.white),
            ),  

            
            Container(
              // color: Colors.red,
              //时间顶部对齐
              alignment: AlignmentDirectional.topStart,
              // height: 70,
              // margin: const EdgeInsets.only(right: 55.0,top: 22.0),
    child: FlatButton(
          child: Text("A. 1-2天",style: TextStyle(fontSize: 22.0,color: Colors.white),),
          onPressed: () {
            print("FlatButton Click");
          },
        ),

            ),   

             Container(
              // color: Colors.red,
              //时间顶部对齐
              alignment: AlignmentDirectional.topStart,
              // height: 70,
              // margin: const EdgeInsets.only(right: 55.0,top: 22.0),
    child: FlatButton(
          child: Text("B. 3-7天",style: TextStyle(fontSize: 22.0,color: Colors.white),),
          onPressed: () {
            print("FlatButton Click");
          },
        ),

            ),  


             Container(
              // color: Colors.red,
              //时间顶部对齐
              alignment: AlignmentDirectional.topStart,
              // height: 70,
              // margin: const EdgeInsets.only(right: 55.0,top: 22.0),
    child: FlatButton(
          child: Text("C. 14天",style: TextStyle(fontSize: 22.0,color: Colors.white),),
          onPressed: () {
            print("FlatButton Click");
          },
        ),

            ), 


             Container(
              // color: Colors.red,
              //时间顶部对齐
              alignment: AlignmentDirectional.topStart,
              // height: 70,
              // margin: const EdgeInsets.only(right: 55.0,top: 22.0),
    child: FlatButton(
          child: Text("D. 28天",style: TextStyle(fontSize: 22.0,color: Colors.white),),
          onPressed: () {
            print("FlatButton Click");
          },
        ),

            ), 
          
          

          ],
        ),
      ),
      
    );
  }
}