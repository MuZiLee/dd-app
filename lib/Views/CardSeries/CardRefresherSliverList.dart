
import 'package:flutter/material.dart';

class CardRefresherSliverList extends StatefulWidget {

  final int childCount;
  final IndexedWidgetBuilder builder;
  CardRefresherSliverList({this.childCount, this.builder});

  @override
  _CardRefresherSliverListState createState() => _CardRefresherSliverListState();
}

class _CardRefresherSliverListState extends State<CardRefresherSliverList> {

  final ScrollController controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: <Widget>[
        SliverList(
          delegate: new SliverChildBuilderDelegate(widget.builder, childCount: widget.childCount),
        )

      ],
    );
  }
}
