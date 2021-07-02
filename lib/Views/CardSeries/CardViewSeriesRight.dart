import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardViewSeriesRight extends StatefulWidget {

  final String title;
  final String subtitle;
  final Color subtitleColor;
  final Widget leading;
  Widget trailing;
  bool autofocus;
  final GestureTapCallback onTap;
  final bool isNotNull; // 是否必填 默认为 false
  final bool visible;
  bool isTaping;

  CardViewSeriesRight(
      {this.title = "Label",
        this.isNotNull = false,
        this.subtitle = "",
        this.subtitleColor,
        this.leading,
        this.trailing,
        this.autofocus = false,
        this.onTap,
        this.isTaping = false,
        this.visible = true}) {

    if (this.trailing == null) {
      this.trailing = Icon(Icons.chevron_right);
    }

  }

  @override
  _CardViewSeriesRightState createState() => _CardViewSeriesRightState();
}

class _CardViewSeriesRightState extends State<CardViewSeriesRight> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isTaping = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.visible == false) {
      return Container();
    } else {
      if (widget.autofocus == true && widget.onTap != null) {
        widget.autofocus = false;
        widget.onTap();
      }
    }

    return InkWell(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 48.0,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: Text(widget.subtitle, style: TextStyle(fontSize: 14, color: widget.subtitleColor != null ? widget.subtitleColor : Colors.black), textAlign: TextAlign.right),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: widget.trailing != null ? 32 : 10,
                  height: widget.trailing != null ? 32 : 10,
                  padding: EdgeInsets.only(right: 10),
                  child: Center(child: widget.trailing),
                )
              ],
            ),
          ),
          Divider(height: 1)
        ],
      ),
    );
  }
}
