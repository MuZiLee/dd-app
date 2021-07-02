

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardViewSeriesExcelRow extends StatefulWidget {

  List<String> listTitle;
  Color color;
  double fontSize;
  CardViewSeriesExcelRow({
    @required this.listTitle,
    this.color,
    this.fontSize = 13.0,
  }) {
    if (this.color == null) {
      color = Colors.black.withAlpha(5);
    }
  }

  @override
  _CardViewSeriesExcelRowState createState() => _CardViewSeriesExcelRowState();
}

class _CardViewSeriesExcelRowState extends State<CardViewSeriesExcelRow> {


  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (int i = 0; i < widget.listTitle.length; i++) {


      Expanded expanded = Expanded(
        child: Container(
          child: Center(
            child: AutoSizeText(widget.listTitle[i], textAlign: TextAlign.center,),
          ),
        ),
      );

      items.add(expanded);
      if (i != widget.listTitle.length-1 && widget.listTitle.length >= 2) {
        items.add(Container(padding: EdgeInsets.only(top: 5, bottom: 5),child: SizedBox(width: 0.5, child: Container(color: Colors.black38))));
      }
    }

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 32.0,
            color: widget.color,
            child: Row(
              children: items,
            ),
          ),
          Divider(height: 1)
        ],
      ),
    );
  }

}
