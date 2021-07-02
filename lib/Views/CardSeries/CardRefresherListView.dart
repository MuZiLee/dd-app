
import 'package:one/Views/MyBehavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardRefresherListView extends StatefulWidget {

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool isScrollbar;
  CardRefresherListView({
    this.itemBuilder,
    this.itemCount,
    this.isScrollbar = true
  });

  @override
  _CardRefresherListViewState createState() => _CardRefresherListViewState();
}

class _CardRefresherListViewState extends State<CardRefresherListView> {

  final ScrollController controller = new ScrollController();

  @override
  Widget build(BuildContext context) {

    if (widget.isScrollbar) {
      return CupertinoScrollbar(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
              controller: controller,
              padding: EdgeInsets.all(0),
              itemBuilder: widget.itemBuilder,
              itemCount: widget.itemCount
          ),
        ),
      );
    } else {
      return ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
            controller: controller,
            padding: EdgeInsets.all(0),
            itemBuilder: widget.itemBuilder,
            itemCount: widget.itemCount
        ),
      );
    }
  }
}
