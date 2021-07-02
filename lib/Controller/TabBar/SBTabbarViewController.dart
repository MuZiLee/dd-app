import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:one/Controller/Login/LoginViewController.dart';
import 'package:one/Controller/TabBar/Chat/ChatViewController.dart';
import 'package:one/Controller/TabBar/Home/HomeViewController.dart';
import 'package:one/Controller/TabBar/Me/MeViewController.dart';
import 'package:one/Model/VersionModel.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/IM.dart';
import 'package:one/Provider/Location.dart';
import 'package:one/Provider/SBVersionsManager.dart';
import 'package:one/TouchCallback.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amap_location_plugin/flutter_amap_location_plugin.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:nav_router/nav_router.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SBTabbarViewController extends StatefulWidget {

  int currentIndex;
  SBTabbarViewController({this.currentIndex = 0});

  @override
  _SBTabbarViewControllerState createState() => _SBTabbarViewControllerState();
}

class _SBTabbarViewControllerState extends State<SBTabbarViewController> {
  List _viewControllers = [];
  List<BottomNavigationBarItem> _items = [];






  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // TODO: 处理 IM登录
    await IM.init();

    VersionModel versionModel = await SBVersionsManager.update();
    PackageInfo info = await PackageInfo.fromPlatform();
    print("最新版本Build号:${versionModel.build}");
    print("当前版本Build号:${int.parse(info.buildNumber)}");
    if (versionModel.build > int.parse(info.buildNumber)) {
      AwesomeDialog(
        context: context,
        dismissOnTouchOutside: false,
        animType: AnimType.BOTTOMSLIDE,
        dialogType: DialogType.SUCCES,
        btnOkText: "更新",
        btnOkColor: Colors.green,
        tittle: "${versionModel.title}:${versionModel.version}",
        desc: "${versionModel?.build}\n${versionModel?.subtitle}",
        useRootNavigator: true,
        btnOkOnPress: () async{
          if (await canLaunch(versionModel.url)) {
            await launch(versionModel.url);
          }
          return false;
        },
      ).show();

    }
  }

  @override
  Widget build(BuildContext context) {

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
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    //注意这里关闭
    FlutterAmapLocationPlugin.shutdown();
  }


}
