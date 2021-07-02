
import 'dart:io';

import 'package:flutter/cupertino.dart';

/// 去除滑动布局的蓝色回弹效果
/// ScrollConfiguration(
///   behavior: MyBehavior(),
///   child: ListView(),
/// );
class MyBehavior  extends ScrollBehavior{
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    if(Platform.isAndroid||Platform.isFuchsia){
      return child;
    }else{
      return super.buildViewportChrome(context,child,axisDirection);
    }
  }
}