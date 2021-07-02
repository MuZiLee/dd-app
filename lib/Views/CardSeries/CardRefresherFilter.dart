//
//  文件名：JoScreenBar
//  所在包名：Utils.FilterItems
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-01
//  版权所有 © 2019。 保留所有权利
//

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';

class CardRefresherFilter extends StatefulWidget {

  // 下拉的头部项
  final List<GZXDropDownHeaderItem> items;
  // [[SortCondition,...],[SortCondition,...],[SortCondition,...]]
  final List<List<SortCondition>> conditions;
  final ValueChanged<SortCondition> onTap;
  CardRefresherFilter({
    this.items,
    this.conditions,
    this.onTap
  });

  @override
  _CardRefresherFilterState createState() => _CardRefresherFilterState();
}

class _CardRefresherFilterState extends State<CardRefresherFilter> {

  GlobalKey _stackKey = GlobalKey();
  GZXDropdownMenuController _dropdownMenuController = GZXDropdownMenuController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Container(
//      height: 38,
      color: Colors.grey[200],
      child: Stack(
        key: _stackKey,
        children: <Widget>[
          GZXDropDownHeader(
            // 下拉的头部项，目前每一项，只能自定义显示的文字、图标、图标大小修改
            items: widget.items,
            // GZXDropDownHeader对应第一父级Stack的key
            stackKey: _stackKey,
            // controller用于控制menu的显示或隐藏
            controller: _dropdownMenuController,
            // 当点击头部项的事件，在这里可以进行页面跳转或openEndDrawer
            onItemTap: (index) {
              print(index);

              _dropdownMenuController.show(index);

              List conds = widget.conditions[index];
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_){
                return Column(
                  children: <Widget>[

                    Container(height: MediaQuery.of(context).size.height * 0.5,),
                    Expanded(
                      child: Column(
                        children: <Widget>[

                          Container(
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[

                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: RaisedButton(
                                    child: Text("返回", style: TextStyle(color: Colors.blue),),
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: RaisedButton(
                                    child: Text("确认", style: TextStyle(color: Colors.white),),
                                    color: Colors.blue,
                                    onPressed: () {

                                      if (widget.onTap != null) {

                                        widget.onTap(conds[currentIndex]);
                                        Navigator.pop(context);
                                      }

                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Expanded(
                            child: CupertinoPicker(
                                backgroundColor: Colors.white,
                                itemExtent: 48,
                                children: conds,
                                onSelectedItemChanged: (_indx){
                                  _dropdownMenuController.hide();
                                  currentIndex = _indx;
                                  setState(() {

                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                );

              });
//              showModalBottomSheet(
//                context: context,
//                useRootNavigator: false,
//                builder: (BuildContext context){
//                return Column(
//                  children: <Widget>[
//
//                    Container(
//                      height: 49,
//                      color: Colors.redAccent,
//                    ),
//                    Expanded(
//                      child: CupertinoPicker(
//                          backgroundColor: Colors.white,
//                          itemExtent: 48,
//                          children: conds,
//                          onSelectedItemChanged: (indx){
//                            _dropdownMenuController.hide();
//                            setState(() {
//
//                            });
//                          }),
//                    )
//                  ],
//                );
//              }).then((onValue){
//                _dropdownMenuController.hide();
//              });

            },
            // 头部的高度
            height: 40,
            // 头部边框宽度
            borderWidth: 0,
            // 下拉时图标颜色
            iconDropDownColor: Colors.red,
          ),
        ],
      ),

    );
  }

}

class SortCondition extends StatelessWidget {

  SortCondition({this.title, this.id, this.isSelected});

  int  id;
  String title;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Text(this.title);
  }
}
