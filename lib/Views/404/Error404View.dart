//
//  文件名：Error404View
//  所在包名：Controller.404
//  所在项目名称：dandankj_cupertino
//
//  开发者： lee
//  开发时间: 2019-11-03
//  版权所有 © 2019。 保留所有权利
//

import 'dart:ui';
import 'package:one/Views/SBImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class Error404View extends StatefulWidget {
  final String text;
  double width;
  double height;
  String url;
  Error404View({this.text = "空空如也", this.url = "images/nodata.png", this.width, this.height});

  @override
  _Error404ViewState createState() => _Error404ViewState();
}

class _Error404ViewState extends State<Error404View> {

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(bottom: window.physicalSize.width * 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(widget.text,
                style: prefix0.TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500)),
            widget.url.contains("http://") ? SBImage(url: widget.url): Image.asset(widget.url,
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
            )
          ],
        ),
      ),
    );
  }
}
