//
//  文件名：ImageRadius
//  所在包名：utils.Image
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-10-24
//  版权所有 © 2019。 保留所有权利
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageRadius extends StatelessWidget {
  final String url;
  final Size size;
  final double radius;

  ImageRadius({Key key, this.url, this.size, this.radius = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size.width,
      height: this.size.height,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(this.radius)),
      ),
      child: url.contains("http") ? Image.network(url, fit: BoxFit.cover): Image.asset(this.url, fit: BoxFit.cover),
    );
  }
}
