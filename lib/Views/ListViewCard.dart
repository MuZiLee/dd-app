//
//  文件名：ListViewCard
//  所在包名：Views
//  所在项目名称：dandankj
//
//  开发者： lee 
//  开发时间: 2019-11-14
//  版权所有 © 2019。 保留所有权利
//


import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewCard extends StatefulWidget {

  final List<Widget> children;
  final GestureTapCallback onTap;

  ListViewCard({this.children, this.onTap});

  @override
  _ListViewCardState createState() => _ListViewCardState();
}

class _ListViewCardState extends State<ListViewCard> {
  @override
  Widget build(BuildContext context) {

    if (widget.children != null) {

      widget.children.insert(widget.children.length, SizedBox(
        height: 16,
      ));
    }

    return Container(
      child: Card(
        child: InkWell(
          child: Column(
            children: widget.children,
          ),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}


class ListViewCardCell extends StatelessWidget {

  final Widget leading;
  final String title;
  final String subtitle;
  final IconData icon;

  ListViewCardCell({this.leading, this.title = "", this.subtitle = "", this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.0,
      color: Colors.white,
      child: ListTile(
        leading: this.leading,
        title: Text(this.title, style: TextStyle(fontSize: this.icon == null ? 14 : 16, color: titleColor)),
        subtitle: this.subtitle.length > 1 ? Text(this.subtitle, style: TextStyle(fontSize: 12, color: subtitleColor)) : null,
        trailing: Icon(this.icon, size: 21),
      ),
    );
  }
}
