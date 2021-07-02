
import 'package:flutter/material.dart';

class CardViewSeriesExcelHeader extends StatefulWidget {

  Color color;
  CardViewSeriesExcelHeader({
    this.color,
  }) {
    if (this.color == null) {
      color = Colors.black12;
    }
  }

  @override
  _CardViewSeriesExcelHeaderState createState() => _CardViewSeriesExcelHeaderState();
}

class _CardViewSeriesExcelHeaderState extends State<CardViewSeriesExcelHeader> {




  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      color: widget.color,
    );
  }
}
