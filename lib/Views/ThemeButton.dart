//
//  文件名：ThemeButton
//  所在包名：Views
//  所在项目名称：dandankj
//
//  开发者： lee 
//  开发时间: 2019-11-08
//  版权所有 © 2019。 保留所有权利
//

import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  final EdgeInsetsGeometry margin;

  ThemeButton (
      this.title,
      {@required this.onPressed, this.margin, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      constraints: new BoxConstraints.expand(
          width: MediaQuery.of(context).size.width - 20.0, height: 48.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        color: Colors.deepOrange,
      ),
      child: FlatButton(
        child: Text(
          this.title,
          style: TextStyle(fontSize: 13.0, color: Colors.white),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
