//
//  文件名：LogoWidget
//  所在包名：Con.Widgets
//  所在项目名称：dandankj_cupertino
//
//  开发者： lee 
//  开发时间: 2019-11-03
//  版权所有 © 2019。 保留所有权利
//


import 'package:one/Views/ImageRadius.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class LogoWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ImageRadius(
        url: "images/Logo.png",
        size: Size(window.physicalSize.width * 0.1,
            window.physicalSize.width * 0.1));
  }
}
