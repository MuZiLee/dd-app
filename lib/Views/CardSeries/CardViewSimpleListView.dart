
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:flutter/material.dart';

class CardViewSimpleListView extends StatefulWidget {

  final VoidCallback onRefresh;
  final String title;
  final List data;
  CardViewSimpleListView({
    this.onRefresh,
    this.title,
    this.data
  });

  @override
  _CardViewSimpleListViewState createState() => _CardViewSimpleListViewState();
}

class _CardViewSimpleListViewState extends State<CardViewSimpleListView> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.title != null ? widget.title : "",
      child: CardRefresher(
        onRefresh: widget.onRefresh,
        child: ListView.builder(
          itemExtent: 59.0,
          itemCount: widget.data.length,
          itemBuilder: (_, index) {
            return Column(
              children: <Widget>[
                Container(
                  height: 58.0,
                child: ListTile(
                  title: Text(widget.data[index].title),
                  onTap: () {
                    Navigator.of(context).pop(widget.data[index]);
                  },
                ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
