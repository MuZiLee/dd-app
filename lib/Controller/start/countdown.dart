import 'dart:async';
import 'dart:math';
import 'package:one/Controller/Login/LoginViewController.dart';
import 'package:one/Controller/TabBar/SBTabbarViewController.dart';
import 'package:one/Controller/WebBrowser/WebBrowserViewController.dart';
import 'package:one/Model/AdModel.dart';
import 'package:one/Provider/API.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Views/SBImage.dart';
import 'package:one/config.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';

class CountdownViewController extends StatefulWidget {
  static String routeName = "/";

  @override
  _CountdownViewControllerState createState() =>
      _CountdownViewControllerState();
}

class _CountdownViewControllerState extends State<CountdownViewController> {
  SBImage image;
  AdModel startAd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: const Alignment(1.0, -1.0), // 右上角对齐
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: image,
          ),
          image.url.contains(Config.LounchImage) ? Container() : Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 42.0, 10.0, 0.0),
            child: new FlatButton(
              onPressed: () {
                routePush(WebBrowserViewController(
                  title: startAd.title,
                  url: startAd.url,
                ));
              },
              color: Colors.black.withOpacity(0.3),
              child: new Text(
                "查看详情",
                style: new TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ),
          ),
          Padding(
            padding: new EdgeInsets.fromLTRB(
                0.0, MediaQuery.of(context).size.height - 88.0, 10.0, 0.0),
            child: new FlatButton(
              onPressed: () async {
                /// 登录
                _timer.cancel();
                Progresshud.show();
                if (!await Account.isExisting()) {
                  pushAndRemoveUntil(LoginViewController());
                } else {

                  /// TODO: 返回到根路由
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(builder: (context)=> new SBTabbarViewController()),
                          (route)=>route==null
                  );
                }
                Progresshud.dismiss();
              },
              color: Colors.black.withOpacity(0.3),
              child: new Text(
                (startAd.time == 0) ? "跳过" : "跳过 ${startAd.time}",
                style: new TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    List ads = await API.getAdList(type: 0);
    if (ads?.length > 0) {
      startAd = ads[Random().nextInt(ads.length > 0 ? ads.length : ads.length)];
      image = SBImage(url: startAd.image);
    }
    setState(() {});
  }



  @override
  void initState() {
    super.initState();
    startAd = AdModel(time: 10);
    image = SBImage(url: Config.BASE_URL+"/resources/launch.png", placeholder: Image.asset("images/Launch.png", fit: BoxFit.cover));
    startTime();
  }

  Timer _timer;

  startTime() async {
    //设置启动图生效时间
    // 空等1秒之后再计时
    var _duration = new Duration(seconds: 2);
    _timer = new Timer.periodic(_duration, (v) {
      startAd?.time--;
      if (startAd.time == 0) {
        _timer.cancel();
      }
      setState(() {});
    });
  }
}
