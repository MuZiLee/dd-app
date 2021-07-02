
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

const String card_series_default_avatar = "images/Avatar/avatar.png";


enum CardOrientation {
  Left,
  Right
}

class CardViewSeriesMessage extends StatefulWidget {

  String timestamp;
  String avatar;
  final String text;
  final bool onLoad;
  final bool loadError;
  final CardOrientation orientation; //消息方向
  CardViewSeriesMessage({
    this.timestamp,
    this.avatar = "images/Avatar/avatar.png",
    this.text,
    this.onLoad = false,
    this.loadError = false,
    this.orientation = CardOrientation.Left
  }) {

    if (this.avatar == null || this.avatar.length < 10) {
      this.avatar = "images/Avatar/avatar.png";
    }

    //设置时间
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)-1000);
    timestamp = TimelineUtil.formatByDateTime(dateTime, locale: 'zh').toString();
  }

  @override
  _CardViewSeriesMessageState createState() => _CardViewSeriesMessageState();
}

class _CardViewSeriesMessageState extends State<CardViewSeriesMessage> {

  Widget image;

  @override
  Widget build(BuildContext context) {

    if (widget.avatar.contains("http")) {
      image = Image.network(widget.avatar, width: 48, height: 48, fit: BoxFit.cover);
    } else if (widget.avatar.contains(card_series_default_avatar)) {
      image = Image.asset(widget.avatar, width: 48, height: 48, fit: BoxFit.cover);
    } else {
      image = Image.file(File(widget.avatar), width: 48, height: 48, fit: BoxFit.cover);
    }

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          /// 时间
          setupTime(),
          /// 消息
          judgeOrientation(),
        ],
      ),
    );
  }

  /// 判断消息方向
  Widget judgeOrientation() {
    if (widget.orientation == CardOrientation.Left) {
      return setupLeftText();
    } else {
      return setupRightText();
    }
  }

  /// 设置时间
  Widget setupTime() {
    return Container(
      padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
      child: Center(
        child: Text(widget.timestamp, style: TextStyle(fontSize: 12.0, color: Colors.black26)),
      ),
    );
  }


  Widget setupLeftText() {

    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: image,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//              Container(
//                margin: EdgeInsets.only(left: 12),
//                child: Text("用户名"),
//              ),
              setupText(),
            ],
          ),
          /// 是否在加载中
          Offstage(
            offstage: !widget.onLoad,
            child: Container(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color(0xfff5a623),
                ),
              ),
              width: 32.0,
              height: 32.0,
              padding: EdgeInsets.all(10.0),
            ),
          ),
          /// 是否加载失败
          Offstage(
            offstage: !widget.loadError,
            child: GestureDetector(
              onTap: () {

              },
              child: Icon(Icons.error, size: 21, color: Colors.red),
            ),
          ),


        ],
      ),
    );
  }



  Widget setupRightText() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          /// 是否加载失败
          Offstage(
            offstage: !widget.loadError,
            child: GestureDetector(
              onTap: () {

              },
              child: Icon(Icons.error, size: 21, color: Colors.red),
            ),
          ),
          /// 是否加载中
          Offstage(
            offstage: !widget.onLoad,
            child: Container(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color(0xfff5a623),
                ),
              ),
              width: 32.0,
              height: 32.0,
              padding: EdgeInsets.all(10.0),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
//              Container(
//                margin: EdgeInsets.only(right: 12),
//                child: Text("用户名"),
//              ),
              setupText(),
            ],
          ),
          Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: image,
              )
            ],
          ),
        ],
      ),
    );
  }


  Widget setupText() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.60,
      ),
      decoration: BoxDecoration(
        color: widget.orientation == CardOrientation.Left ? leftBubbleColor : rightBubbleColor,
        borderRadius: BorderRadius.circular(5.0),
        gradient: widget.orientation == CardOrientation.Right ? rightBubbleGradient : null
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0,
        ),
      ),
    );
  }


  LinearGradient rightBubbleGradient = LinearGradient(
    colors: [
      Color(0xFFFFC600),
      Color(0xFFFFA800),
    ],
  );

  ///
  Color leftBubbleColor = Colors.white;

  ///
  Color rightBubbleColor = const Color(0xFFFFA800);

}
