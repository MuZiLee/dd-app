
import 'package:flutter/material.dart';

class CardViewSeriesExcelTitleBar extends StatefulWidget {

  List<String> listTitle;
  Color color;
  CardViewSeriesExcelTitleBar({
    @required this.listTitle,
    this.color,
  }) {
    if (this.color == null) {
      color = Colors.black12;
    }
  }

  @override
  _CardViewSeriesExcelTitleBarState createState() => _CardViewSeriesExcelTitleBarState();
}

class _CardViewSeriesExcelTitleBarState extends State<CardViewSeriesExcelTitleBar> {



  @override
  Widget build(BuildContext context) {

    List<Widget> items = [];
    for (int i = 0; i < widget.listTitle.length; i++) {


      Expanded expanded = Expanded(
        child: Center(
          child: Text(widget.listTitle[i]),
        ),
      );

      items.add(expanded);
      if (i != widget.listTitle.length-1 && widget.listTitle.length >= 2) {
        items.add(SizedBox(width: 1, child: Container(color: Colors.black38)));
      }
    }

    return Container(
      height: 48,
      color: widget.color,
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            height: 28,
            child: Row(
              children: items,
            ),
          )
        ],
      ),
    );
  }
}
