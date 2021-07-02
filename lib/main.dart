

import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:one/Controller/TabBar/SBTabbarViewController.dart';
import 'package:one/Controller/start/countdown.dart';
import 'package:one/Provider/API.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/IM.dart';
import 'package:one/Provider/Location.dart';
import 'package:one/Provider/ShopManager.dart';
import 'package:one/Provider/ShopProviders.dart';
import 'package:one/utils/sp_util/sp_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amap_location_plugin/flutter_amap_location_plugin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:provider/provider.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  /// 设置ios的key，android可以直接在配置文件中设置
  FlutterAmapLocationPlugin.setApiKey("e1fb1d475908f4c30945844e0f488768");

  //是否检查无效的值类型
  Provider.debugCheckInvalidValueType = null;
  /// TODO: onError
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IM()),
        ChangeNotifierProvider(create: (_) => Account()),
        ChangeNotifierProvider(create: (_) => ShopProviders()),
        ChangeNotifierProvider(create: (_) => ShopManager()),

      ],
      child: MyApp(),
    ),
  );

}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    await SpUtil.getInstance();
    //设置状态颜色为透明
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.white, statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    /// HUD 默认设置
    Progresshud.setDefaultMaskTypeClear();
    // setLocaleInfo('zh_alipay',ZHAliPayTimelineInfo());

    /// iOS社会化分享组件
    if(Platform.isIOS){
      //ios相关代码
      ShareSDKRegister register = ShareSDKRegister();
      register.setupWechat("wxff3811ed4eee8aaf", "07a005b72995743166465a93e0887971", "https://www.dandankj.com/cgi/api/share/");
      SharesdkPlugin.regist(register);
    }
    await Location.updateCurrentLocations();
    await API.getAdList(type: 1);
  }

  @override
  Widget build(BuildContext context) {
    Progresshud.dismiss();

    return MaterialApp(
      title: "蛋蛋",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      navigatorKey: navGK,
      home: CountdownViewController(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [                                   //此处
        const Locale.fromSubtags(languageCode: 'zh')
      ],
    );

  }
}




// class ZHAliPayTimelineInfo implements TimelineInfo {
//   String suffixAgo() => '前';
//   String suffixAfter() => '后';
//   String lessThanTenSecond() => '刚刚';
//   String customYesterday() => '昨天';
//   bool keepOneDay() => true;
//   bool keepTwoDays() => false;
//   String oneMinute(int minutes) => '$minutes分';
//   String minutes(int minutes) => '$minutes分';
//   String anHour(int hours) => '$hours小时';
//   String hours(int hours) => '$hours小时';
//   String oneDay(int days) => '$days天';
//   String days(int days) => '$days天';
// }