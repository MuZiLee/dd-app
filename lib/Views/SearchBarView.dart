//
//  文件名：SearchBarView
//  所在包名：Views
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-10
//  版权所有 © 2019。 保留所有权利
//

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarView extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final String histText;
  final Color color;
  final FocusNode focusNode;

  SearchBarView({this.onChanged, this.focusNode, this.onEditingComplete, this.histText = "搜索一下", this.color = Colors.white});

  @override
  _SearchBarViewState createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            child: Container(
//              height: 48,
              color: Colors.black12,
              child: TextField(
                focusNode: widget.focusNode,
                style:  TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: widget.histText,
                  hintStyle: TextStyle(fontSize: 14),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, size: 21),
                ),
                onChanged: widget.onChanged,
                onEditingComplete: widget.onEditingComplete,
              ),
            ),
          ),


        ],
      ),
    );
  }
}
