
import 'package:demo2020/Views/CardSeries/CardTextView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardViewSeriesDescription extends StatefulWidget {

  final String title;
  final String text;
  final bool   isNotNull;
  final Widget childBottom;
  CardViewSeriesDescription({this.title = "Title", this.isNotNull = false, this.text = "text", this.childBottom});

  @override
  _CardViewSeriesDescriptionState createState() => _CardViewSeriesDescriptionState();
}

class _CardViewSeriesDescriptionState extends State<CardViewSeriesDescription> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text(widget.title, style: TextStyle(fontSize: 14)),
              widget.isNotNull == true ? Text("*", style: TextStyle(color: Colors.red)) : Container(),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: CardTextView(
                  text: widget.text,
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ),
              widget.childBottom != null ? widget.childBottom : Container(),
            ],
          ),
        ),
        Divider(height: 1),
      ],
    );
  }
}
