

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardViewSeriesEmptyCell extends StatefulWidget {

  final String title;
  final Widget leading;
  final Widget subview  = Container();
  final ValueChanged onChanged;
  final VoidCallback onTap; // 只有当enabled=false时才生效
  final bool isNotNull; // 是否必填 默认为 false
  final bool enabled; // 是可以编辑
  final bool visible;


  CardViewSeriesEmptyCell(
      {this.title = "Label",
        this.isNotNull = false,
        subview,
        this.leading,
        this.onChanged,
        this.onTap,
        this.enabled = true,
        this.visible = true,
      }) {

  }

  @override
  _CardViewSeriesEmptyCellState createState() => _CardViewSeriesEmptyCellState();
}

class _CardViewSeriesEmptyCellState extends State<CardViewSeriesEmptyCell> {




  @override
  Widget build(BuildContext context) {
    if (widget.visible == false) {
      return Container();
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(widget.title,
                        style: TextStyle(fontSize: 14, color: Colors.black))),
                widget.isNotNull == true
                    ? Text("*", style: TextStyle(color: Colors.red))
                    : Container(),
                Expanded(
                  child: Container(
                    height: 88,
                    color: Colors.grey,
                    child: widget.subview,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1)
        ],
      ),
    );
  }
}
