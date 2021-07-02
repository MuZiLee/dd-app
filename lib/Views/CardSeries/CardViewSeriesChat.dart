
import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:demo2020/Views/CardSeries/CardSeriesUnread.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String card_series_default_avatar = "images/Avatar/avatar.png";

class CardViewSeriesChat extends StatefulWidget {

  String avatar;
  final String title;
  final String subtitle;
  final int    unreadCount;
  final VoidCallback onTap;
  final VoidCallback deleteTap;
  String timestamp;
  final bool   notifications_off; //是否开启闭免打扰
  CardViewSeriesChat({
    this.avatar = "images/Avatar/avatar.png",
    this.title = "",
    this.subtitle = "",
    this.unreadCount = 0,
    this.onTap,
    this.deleteTap,
    this.timestamp,
    this.notifications_off = false,
  }) {

    if (this.timestamp != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(this.timestamp));
      String timeline = TimelineUtil.formatByDateTime(dateTime, locale: 'zh').toString();
      this.timestamp = timeline;
      print(timeline);
    } else {
      this.timestamp = "";
    }



    if (this.avatar == null || this.avatar.length < 10) {
      this.avatar = "images/Avatar/avatar.png";
    }

  }

  @override
  _CardViewSeriesChatState createState() => _CardViewSeriesChatState();
}

class _CardViewSeriesChatState extends State<CardViewSeriesChat> {

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
        color: Colors.white,
        child: InkWell(
          child: Column(
            children: <Widget>[

              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        buildAvatar(),
                        widget.unreadCount > 0 ? Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: CardSeriesUnread(
                            unreadCount: widget.unreadCount,
                          ),
                        ) : Container(),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text(widget.title, style: TextStyle(fontSize: 14, color: Colors.black), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis),
                          Text(widget.subtitle, style: TextStyle(fontSize: 11, color: Colors.black38), maxLines: 2, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis),

                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        widget.timestamp.length > 0 ? Text(widget.timestamp, style: TextStyle(fontSize: 10, color: Colors.black38)) : Container(),
                        widget.notifications_off == true ? Icon(Icons.notifications_off, color: Colors.black12, size: 18) : Container()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          onLongPress: () {

            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return CupertinoActionSheet(
                  title: Text(widget.title),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                        child: Text('删除聊天记录', style: TextStyle(fontSize: 14)),
                        onPressed: () {
                          Navigator.pop(context);
                          if (widget.deleteTap != null) {

                            widget.deleteTap();
                          }
                        }),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                      child: Text('返回', style: TextStyle(fontSize: 14)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                );
              },
            );
          },
          onTap: widget.onTap,
        ),
      );

  }

  Widget buildAvatar() {

    return ClipRRect(
        child: image, borderRadius: BorderRadius.all(Radius.circular(100.0)));
  }

}


