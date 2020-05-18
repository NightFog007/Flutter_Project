import 'package:flutter/material.dart';
import '../right/rightData.dart';
import 'dart:ui';
import '../common/http_service.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class WrongPage extends StatefulWidget {
  WrongPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _WrongPageState createState() => _WrongPageState();
}

class _WrongPageState extends State<WrongPage> {
   @override
  void initState() {
    super.initState();
    //获取产品数据
    getProductList();
  }
  //获取产品数据
  void getProductList() async {
    //请求url
    var url = 'http://api.tianapi.com/txapi/baiketiku/index?key=ca4f25b93495f1001c3a81dd9972b89c';
    
    //调用请求方法传入url及表单数据
    await request(url).then((value) {
      //Json解码 value为服务端返回的数据
      var data = json.decode(value.toString());
      //打印数据
      print('产品列表数据Json格式:::' + data.toString());
      //将Json数据转换成ProductListModel
      ProductListModel productList = ProductListModel.fromJson(data);
      //将返回的数据放入ProductProvider里
      if (productList.data == null) {
        Provider.of<ProductProvider>(context).getProductList([]);
      } else {
        Provider.of<ProductProvider>(context).getProductList(productList.data);
      }
    });
  }

  
  @override
  Widget build(BuildContext context) {
    //设备宽度
    double deviceWidth = MediaQuery.of(context).size.width;
    //使用Consumer获取ProductProvider对象
    return Consumer<ProductProvider>(builder: (BuildContext context, ProductProvider productProvider, Widget child) {
      //获取产品列表数据
      List<ProductModel> productList = productProvider.productList;
      return Container(
        width: deviceWidth,
        color: Colors.white,
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 7.5),
        child: buildProductList(context, deviceWidth, productList),
      );
    });
  }

  //返回标题及列表
  Widget buildProductList(BuildContext context, double deviceWidth, List<ProductModel> productList) {
    //Item宽度

    //返回产品列表
    List<Widget> listWidgets = productList.map((item) {
      
      //返回产品列表
      return InkWell(
        onTap: () {
         
          
        },
        //产品内容展示容器
        child: Container(
          // width: itemWidth,
          // margin: EdgeInsets.only(bottom: 5, left: 2),
          // padding: EdgeInsets.only(top: 10, left: 13, bottom: 7),
          // color: bgColor,
          //垂直布局
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //产品名称
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                // style: TextStyle(fontSize: 15, color: titleColor),
              ),
              //产品描述
              Text(
                item.answerA,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                // style: TextStyle(fontSize: 15, color: subtitleColor),
              ),
              // //产品图片
              // Container(
              //   alignment: Alignment(0, 0),
              //   margin: EdgeInsets.only(top: 5),
              //   child: Image.network(
              //     item.imageUrl,
              //     width: imageWidth,
              //     height: imageWidth,
              //   ),
              // ),
            ],
          ),
        ),
      );
    }).toList();

    //标题及产品列表
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 5, bottom: 10),
          child: Text(
            '最新产品',
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(51, 51, 51, 1),
            ),
          ),
        ),
        //流式布局列表
        Wrap(
          spacing: 2,
          children: listWidgets,
        ),
      ],
    );
  }
}
