import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardHeaderTip extends StatelessWidget {

  String title;

  CardHeaderTip(this.title);

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Container(
          height: 20.0,
          width: 1,
          color: Colors.deepOrangeAccent,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(5),
            child: Text(
              title != null ? title : "",
              style: TextStyle(fontSize: 14.0, color: Color(0xFF939393)),
            ),
          ),
        )
      ],
    );
  }
}
