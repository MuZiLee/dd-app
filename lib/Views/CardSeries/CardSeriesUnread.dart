import 'package:flutter/material.dart';

class CardSeriesUnread extends StatefulWidget {
  final int unreadCount;

  CardSeriesUnread({this.unreadCount = 99});

  @override
  _CardSeriesUnreadState createState() => _CardSeriesUnreadState();
}

class _CardSeriesUnreadState extends State<CardSeriesUnread> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      child: InkWell(
        child: Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Center(
            child: Text(
              "${widget.unreadCount}",
              style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
