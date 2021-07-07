import os,sys,re

admobinfo_path = '/Users/gsky/my_github/flutter_project/2021_init_flutter/comm/admob_info.dart'
new_widgets_path = '/Users/gsky/my_github/flutter_project/2021_init_flutter/comm/new_widgets'
my_file_path = '/Users/gsky/my_github/flutter_project/2021_init_flutter/comm'

now_path = os.path.abspath('.')

test_app_id = 'ca-app-pub-3940256099942544~1458002511'


# 跳转到项目根目录
# os.chdir(res_path)
# print(os.path.abspath('.'))

# 修改文本的指定行; 找到old_text,并且在它上方插入new_text
def change_line(file_path,old_text,new_text):

    file = open( file_path, "r" ) 
    content = file.read() 
    pos = content.find( old_text)

    if pos != -1:
        print("找到了")
        content = content[:pos] + new_text + content[pos:] +'\n'
        file.close() 
        file = open( file_path, "w" ) 
        file.write( content ) 
        file.close() 
    else:
        print("没找到"+str(file_path))


# 1. 修改pubspec.yaml内容
path = './pubspec.yaml'

# new_path = '''
#   google_mobile_ads: ^0.13.1
# '''

change_line(path,'cupertino_icons','google_mobile_ads: ^0.13.1\n  dio: ^3.0.9\n  shared_preferences: ^2.0.6\n  provider: ^3.0.0+1\n  sqflite: ^1.1.7+1\n  path_provider: ^2.0.2\n  ')
# change_line(path,'  cupertino_icons',new_path)




# 2. 修改 info.list内容
infoPlist_path = now_path + '/ios/Runner/Info.plist'
print(infoPlist_path)
old_info = '<key>CFBundleDevelopmentRegion'
new_info = '<key>GADApplicationIdentifier</key>\n<string>%s</string>\n<key>io.flutter.embedded_views_preview</key>\n<true/>\n' % test_app_id

change_line(infoPlist_path,old_info,new_info)

# 3.重构main函数
main_path = '/Users/gsky/my_github/flutter_project/2021_init_flutter/init_main/*'

os.system("cp  -r %s ./lib/" % main_path )


# 3. 复制admob_info.dart文件
# os.system("cp %s ./lib/admob_info.dart" % admobinfo_path )

# 4. 修改main文件
main_path = './lib/main.dart'
old_info = 'runApp'
new_info = 'WidgetsFlutterBinding.ensureInitialized(); \n  MobileAds.instance.initialize(); \n '

# change_line(main_path,old_info,new_info)

old_info = 'import'
# new_info = 'import \'package:admob_flutter/admob_flutter.dart\';\n'
new_info = '''
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ads.dart';
//! 注意,广告的app_id在ios plist里是测试id,需要改为正式的
'''


# change_line(main_path,old_info,new_info)

old_info = 'int _counter = 0;'

new_info = '''

   GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  
  var bannerAds = AdsBannerWidget();
  var interAds = AdsInterstitialWidgetState();
  var rewardAds = AdsRewardWidgetState();
  
    @override
  void initState() {
    super.initState();
    interAds.createInterstitialAd();
    rewardAds.createRewardedAd();
  }
  
void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        print('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      default:
    }
  }
  
  //使用横幅,直接当控件使用;
//      AdmobBanner(
//               adUnitId: "ca-app-pub-3940256099942544/2934735716",
//               adSize: bannerSize,
//               listener: (AdmobAdEvent event, Map<String, dynamic> args) {
//                 handleEvent(event, args, 'Banner');
//               },
//             ),

//使用插页的按钮

//       onPressed: () async {
//           if (await interstitialAd.isLoaded) {
//             interstitialAd.show();
//           } else {
//             print("Interstitial ad is still loading...");
//           }
//         },
  
'''
main_path = './lib/pages/home_page.dart'
# change_line(main_path,old_info,new_info)



old_info = 'import'
# new_info = 'import \'package:admob_flutter/admob_flutter.dart\';\n'
new_info = '''
import 'package:admob_flutter/admob_flutter.dart';
import '../comm/admob_info.dart';
//! 注意,广告的app_id在ios plist里是测试id,需要改为正式的
'''
# change_line(main_path,old_info,new_info)


# 5. 复制自定义控件
# os.system("cp  -r %s ./lib/" % new_widgets_path )

# 6. 复制我的自定义类
os.system("cp  -r %s ./lib/" % my_file_path )
