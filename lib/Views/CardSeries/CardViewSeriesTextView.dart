import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardViewSeriesTextView extends StatefulWidget {
  final String title;
  final String placeholder;
  String text;
  final bool isBorderRadius;
  final bool isNotNull;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged valueChanged;
  final bool enabled;
  Color color = Colors.grey[100];

  CardViewSeriesTextView(
      {this.title = "Title",
      this.text = "",
      this.placeholder = "不少于10字",
      this.valueChanged,
      this.isNotNull = false,
      this.controller,
      this.focusNode,
      this.enabled = true,
      this.color,
      this.isBorderRadius = false}) {
    if (this.text == null) {
      this.text = "";
    }
  }

  @override
  _CardViewSeriesTextViewState createState() => _CardViewSeriesTextViewState();
}

class _CardViewSeriesTextViewState extends State<CardViewSeriesTextView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(widget.title,
                      style: TextStyle(fontSize: 14, color: Colors.black, decoration: TextDecoration.none)),
                ),
                widget.isNotNull == true
                    ? Text("*", style: TextStyle(color: Colors.red, decoration: TextDecoration.none))
                    : Container(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "${widget.text.length}/250字",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 10, color: Colors.black38, decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 10),
              child: CupertinoTextField(
                enabled: widget.enabled,
                controller: widget.controller,
                autofocus: widget.enabled,
                focusNode: widget.focusNode,
                placeholder: widget.placeholder,
                placeholderStyle: TextStyle(fontSize: 13),
                maxLength: 250,
                maxLines: 250,
                clearButtonMode: OverlayVisibilityMode.editing,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(5)),
                style: TextStyle(
                    fontSize: 14,
                    color:
                        widget.text.length > 0 ? Colors.black : Colors.black38),
                onChanged: (value) {
                  if (value.length >= 250) {
                    return;
                  }

                  setState(() {
                    widget.text = value;
                  });

                  if (widget.valueChanged != null) {
                    widget.valueChanged(value);
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(height: 1)
        ],
      ),
    );
  }
}
