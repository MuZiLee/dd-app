import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:demo2020/Controller/TabBar/Chat/ChatViewController.dart';
import 'package:demo2020/Controller/TabBar/Home/HomeViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/MeViewController.dart';
import 'package:demo2020/Model/VersionModel.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Provider/SBVersionsManager.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/utils/AppIconBadge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amap_location_plugin/amap_location_option.dart';
import 'package:flutter_amap_location_plugin/flutter_amap_location_plugin.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:location_service_check/location_service_check.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Provider/IM.dart';


class SBTabbarViewController extends StatefulWidget {

  int currentIndex;
  SBTabbarViewController({this.currentIndex = 0});

  @override
  _SBTabbarViewControllerState createState() => _SBTabbarViewControllerState();
}

class _SBTabbarViewControllerState extends State<SBTabbarViewController> {
  List _viewControllers = [];
  List<BottomNavigationBarItem> _items = [];

  final JPush jpush = new JPush();
  String debugLable = 'Unknown';



  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();





    // VersionModel versionModel = await SBVersionsManager.update();
    // PackageInfo info = await PackageInfo.fromPlatform();
    // print("最新版本Build号:${versionModel.build}");
    // print("当前版本Build号:${int.parse(info.buildNumber)}");
    // if (versionModel.build > int.parse(info.buildNumber)) {
    //   AwesomeDialog(
    //     context: context,
    //     dismissOnTouchOutside: false,
    //     animType: AnimType.BOTTOMSLIDE,
    //     dialogType: DialogType.SUCCES,
    //     btnOkText: "更新",
    //     btnOkColor: Colors.green,
    //     title: "${versionModel.title}:${versionModel.version}",
    //     desc: "${versionModel?.build}\n${versionModel?.subtitle}",
    //     useRootNavigator: true,
    //     btnOkOnPress: () async{
    //       if (await canLaunch(versionModel.url)) {
    //         await launch(versionModel.url);
    //       }
    //       return false;
    //     },
    //   ).show();
    // }
  }

  @override
  Widget build(BuildContext context) {

    // FlutterAppBadger.updateBadgeCount(IM.jmessage.getAllUnreadCount());
    // FlutterAppBadger.updateBadgeCount(1);
    AppIconBadge.updateBadge(1);


    return BaseTabBarScaffold(
      items: _items,
      currentIndex: widget.currentIndex,
      onTap: (value) async {
        setState(() {
          widget.currentIndex = value;
        });
        if (value == 2) {
          await Account.getUserInfo();
        }
      },
      visibleChild: _viewControllers[widget.currentIndex],
    );
  }



  _init() {
    HomeViewController home = new HomeViewController();
    ChatViewController chat = new ChatViewController();
    MeViewController me = new MeViewController();

    _viewControllers.add(home);
    _viewControllers.add(chat);
    _viewControllers.add(me);

    BottomNavigationBarItem homeItem = new BottomNavigationBarItem(
        icon: ImageIcon(AssetImage("images/Logo.png")), title: Text("蛋蛋"));
    BottomNavigationBarItem chatItem = new BottomNavigationBarItem(
        icon: ImageIcon(AssetImage("images/tabbar/chat.png")),
        title: Text("聊天"));
    BottomNavigationBarItem meItem = new BottomNavigationBarItem(
        icon: ImageIcon(AssetImage("images/tabbar/me.png")), title: Text("我的"));

    _items.add(homeItem);
    _items.add(chatItem);
    _items.add(meItem);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    _init();

    //启动客户端,这里设置ios端的精度小一点
    FlutterAmapLocationPlugin.startup(
      AMapLocationOption(
        iosOption: IosAMapLocationOption(
          locatingWithReGeocode: true,
          desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters,
        ),
      ),
    );
  }




  @override
  void dispose() {
    super.dispose();
    //注意这里关闭
    FlutterAmapLocationPlugin.stopLocation();
  }



  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
            print("flutter onReceiveNotification: $message");
            setState(() {
              debugLable = "flutter onReceiveNotification: $message";
            });
          }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
        setState(() {
          debugLable = "flutter onOpenNotification: $message";
        });
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
        setState(() {
          debugLable = "flutter onReceiveMessage: $message";
        });
      }, onReceiveNotificationAuthorization:
          (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
        setState(() {
          debugLable = "flutter onReceiveNotificationAuthorization: $message";
        });
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (Platform.isIOS) {

    } else {
      jpush.setup(
        appKey: "79778172c79dd53e94bb6ae5", //你自己应用的 AppKey
        channel: "developer-default",
        production: false,
        debug: true,
      );
    }
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
      });
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    setState(() {
      debugLable = platformVersion;
    });





    // jpush.setTags(["lala", "haha"]).then((map) {
    //   var tags = map['tags'];
    //   setState(() {
    //     debugLable = "set tags success: $map $tags";
    //   });
    // }).catchError((error) {
    //   setState(() {
    //     debugLable = "set tags error: $error";
    //   });
    // });


  }

}
