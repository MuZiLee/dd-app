import 'dart:io';

import 'package:demo2020/views/404/Error404View.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// BaseColors
///
Color titleColor = Color(0xFF000000);
Color subtitleColor = Color(0xFF5E5E5E);
Color subordinateColor = Color(0xFF929292);
Color baseColor = Color(0xFFF0F0F0);
Color topColor = Color(0xFFFFFFFF);

Color selectedIconColor = Colors.deepOrange;
Color unselectedIconColor = Color(0xFF000C18);
Color unselectedTabbarItemColor = Color(0xFFB5B5B5);

/// 不显示眼的灰色
Color inconspicuousColor = Color(0xFFD6D6D6);

Color unselectedColor = Color(0xFF000C18);

class BaseScaffold extends StatefulWidget {
  final String title;
  final double elevation;
  Widget child;
  final Widget leading;
  final List<Widget> actions;
  Color color;
  bool centerTitle;
  Widget bottomNavigationBar;
  Widget floatingActionButton;
  final SystemUiOverlayStyle systemUiOverlayStyle;

  BaseScaffold({
    Key key,
    this.title = "",
    this.elevation = 1.0,
    this.child,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.color = Colors.white,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.systemUiOverlayStyle = SystemUiOverlayStyle.dark,
  });

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {


  @override
  Widget build(BuildContext context) {
    if (widget.child == null) {
      widget.child = Error404View();
    }

    return Scaffold(
      key: widget.key,

      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 17)),
        elevation: widget.elevation,
        centerTitle: widget.centerTitle,
        brightness: Brightness.light,
        actions: widget.actions,
        leading: widget.leading,
        backgroundColor: widget.color,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.black),
          subtitle: TextStyle(color: Colors.black38),
        ),
      ),
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: widget.child,
    );
  }

}

///
/// BaseTabBarScaffold
///
class BaseTabBarScaffold extends Scaffold {
  final int currentIndex;
  final onTap;
  final List<BottomNavigationBarItem> items;
  final Widget visibleChild;

  @override
  // TODO: implement bottomNavigationBar
  Widget get bottomNavigationBar => BottomNavigationBar(
        elevation: 8.0,
        items: this.items,
        onTap: this.onTap,
        currentIndex: this.currentIndex,
//        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        fixedColor: Colors.deepOrange,
        showUnselectedLabels: false,
        iconSize: 21,
      );

  @override
  // TODO: implement backgroundColor
  Color get backgroundColor => Color(0xFFF0F0F0);

  @override
  // TODO: implement body
  Widget get body => this.visibleChild;

  BaseTabBarScaffold(
      {this.currentIndex, this.items, this.onTap, this.visibleChild})
      : super(body: visibleChild);
}
