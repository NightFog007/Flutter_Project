import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:zitizhuanhuan/main.dart';
import 'package:zitizhuanhuan/admob_info.dart';


class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  var ad = new admob_info();

  AdmobBannerSize bannerSize;


  @override
  void initState() {
    super.initState();
    ad.bannerSize = AdmobBannerSize.BANNER;
    ad.init_screenad();
  }


  @override
  Widget build(BuildContext context) {

        return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Positioned(
                    child: AdmobBanner(
                      adUnitId: ad.bannerUnitIdOne,
                      adSize: ad.bannerSize,
                      listener:
                          (AdmobAdEvent event, Map<String, dynamic> args) {
                        ad.handleEvent(event, args, 'Banner');
                      },
                    ),
                    bottom: 20),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '3213',
              style: Theme.of(context).textTheme.display1,
            ),      
          ],
        ),
    
    );
  

    
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text(
    //           'You have pushed the button this many times:',
    //         ),
    //         Text(
    //           '$_counter',
    //           style: Theme.of(context).textTheme.display1,
    //         ),      
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: Icon(Icons.add),
    //   ), 
    // );
  }
}


// class StartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("StartPage"),
//     );
//   }
// }