//
//  文件名：ViewWidget
//  所在包名：Views
//  所在项目名称：dandankj
//
//  开发者： lee 
//  开发时间: 2019-11-09
//  版权所有 © 2019。 保留所有权利
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewWidget extends StatelessWidget {

  final Color color;
  final Decoration decoration;

  final Widget child;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final Decoration foregroundDecoration;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry margin;
  final Matrix4 transform;

  ViewWidget({
    Key key,
    this.color = Colors.white,
    this.decoration,
    this.child,
    this.alignment,
    this.padding,
    this.foregroundDecoration,
    this.constraints,
    this.margin,
    this.transform
  }) : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(constraints == null || constraints.debugAssertIsValid()),
        assert(color == null || decoration == null,
        'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration: new BoxDecoration(color: color)".'
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: this.child,
      color: this.color,
      decoration: this.decoration,
      alignment: this.alignment,
      padding: this.padding,
      margin: this.margin,
      foregroundDecoration: this.foregroundDecoration,
      constraints: this.constraints,
      transform: this.transform,
    );
  }
}