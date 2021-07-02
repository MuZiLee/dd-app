
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

abstract class Event {
  bool isExpanded;
  int status;
  String msg;
  Event({this.isExpanded = false, this.status = 0, this.msg = "待处理"});
}

class ImageUri {
  static sources({String url = "images/member/event.png", int eventType = 0, double width = 32.0, double height = 32.0}) {

//    if (eventType == EventType.overtime0) {
//      url = "images/member/overtime0.png";
//    } else if (eventType == EventType.overtime1) {
//      url = "images/member/overtime1.png";
//    } else if (eventType == EventType.overtime2) {
//      url = "images/member/overtime2.png";
//    } else if (eventType == EventType.overtime3) {
//      url = "images/member/overtime3.png";
//    } else if (eventType == EventType.overtime4) {
//      url = "images/member/overtime4.png";
//    } else if (!url.contains("http://")) {
//
//    }
    url = "images/member/event.png";

    if (url.contains("http://")) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(width)),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } else {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        width: width,
        height: width,
      );
    }
  }
}

class CardViewEventNodeView extends StatefulWidget {
  final String title;
  final String subtitle;

  // 传入的model需要继承Event抽象类
  final List<Event> events;

  final Widget Function(int index, bool isExpanded, Color color) headerBuilder;
  final Widget Function(int index, bool isExpanded) buildBody;

  CardViewEventNodeView({
    this.title = "",
    this.subtitle,
    @required this.events,
    @required this.headerBuilder,
    @required this.buildBody,
  });

  @override
  _CardViewEventNodeViewState createState() => _CardViewEventNodeViewState();
}

class _CardViewEventNodeViewState extends State<CardViewEventNodeView> {


  @override
  Widget build(BuildContext context) {
    List<ExpansionPanel> children = [];

    for (int i = 0; i < widget.events.length; i++) {
      Event event = widget.events[i];

      Color color = Colors.white;
      // 0未处理 1处理中 2已完成 3已驳回 4已失效 5代审
      if (event.status == 0) {
        event.msg = "待处理";
        color = Colors.red;
      } else if (event.status == 1) {
        event.msg = "处理中";
        color = Colors.orange;
      } else if (event.status == 2) {
        event.msg = "已通过";
        color = Colors.green;
      } else if (event.status == 3) {
        event.msg = "已驳回";
        color = Colors.grey;
      } else if (event.status == 4) {
        event.msg = "已关闭";
        color = Colors.grey;
      } else if (event.status == 5) {
        event.msg = "已代审";
        color = Colors.blueAccent;
      } else  {
        event.msg = "等待财务部审核";
        color = Colors.pinkAccent;
      }


      children.add(ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return widget.headerBuilder(i, isExpanded, color);
        },
        body: widget.buildBody(i, event.isExpanded),
        isExpanded: event.isExpanded,
      ));
    }

    return SliverStickyHeader(
      sticky: false,
      header: Container(
        color: Colors.lightBlue,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                )
              ],
            ),
            widget.subtitle != null
                ? Row(
                    children: <Widget>[
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                : Container()
          ],
        ),
      ),
      sliver: SliverToBoxAdapter(
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    widget.events[index].isExpanded = !isExpanded;
                  });
              },
              children: children,
            )

          ],
        ),
      ),
    );
  }
}
