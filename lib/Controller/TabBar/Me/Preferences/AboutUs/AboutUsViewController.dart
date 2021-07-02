//
//  文件名：AboutUsViewController
//  所在包名：Controller.Me.Preferences.AboutUs
//  所在项目名称：dandankj
//
//  开发者： lee 
//  开发时间: 2019-11-10
//  版权所有 © 2019。 保留所有权利
//


import 'package:demo2020/Provider/SBVersionsManager.dart';
import 'package:demo2020/Views/LogoWidget.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUsViewController extends StatefulWidget {
  static const routeName = "/me/preferences/AboutUs";

  @override
  _AboutUsViewControllerState createState() => _AboutUsViewControllerState();
}

class _AboutUsViewControllerState extends State<AboutUsViewController> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "关于蛋蛋",
      elevation: 0.1,
      child: buildContainer(context),
    );
  }

  buildContainer(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: topColor,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 20.0,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),

              //LOGO
              LogoWidget(),

              SizedBox(
                height: 64.0,
              ),

//              Text('蛋蛋网络科技有限公司'),


              Expanded(child: Column(
                children: <Widget>[

                  Text("version ：${SBVersionsManager.version?.version}", textAlign: TextAlign.center, style: TextStyle(fontSize: 12,color: subordinateColor)),
                  Text("buildNumber ：${SBVersionsManager.version?.build}", textAlign: TextAlign.center, style: TextStyle(fontSize: 12,color: subordinateColor)),
                  Text("com.dandankj.one", textAlign: TextAlign.center, style: TextStyle(fontSize: 12,color: subordinateColor)),
                  SizedBox(
                    height: 64.0,
                  ),

                ],
              )),

              Text("SANSHENGIT Copyright © 2019. All rights reserved. All rights reserved", textAlign: TextAlign.center, style: TextStyle(fontSize: 9,color: subordinateColor)),
              SizedBox(
                height: 32.0,
              ),

            ],
          ),
        ),
      ),
    );
  }


}
