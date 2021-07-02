import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardViewSeriesHeader extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onPressed;
  final TextAlign textAlign;
  final double height;

  CardViewSeriesHeader({
    this.title = "Label",
    this.textAlign = TextAlign.left,
    this.color,
    this.onPressed,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: this.height,
          padding: EdgeInsets.all(10),
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AutoSizeText(
                  this.title,
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.none,
                    color: this.color != null ? this.color : Colors.black38),
                  maxLines: 1,
                  minFontSize: 10,
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1)
      ],
    );
  }
}
