
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardViewSeriesNumber extends StatefulWidget {
  final String title;
  String subtitle;
  final String placeholder;
  final Widget leading;
  Widget trailing;
  final int maxLength;
  final ValueChanged onChanged;
  final ValueChanged<String> onSubmitted;
  final bool visible;
  final bool isNotNull;
  final bool enabled;
  final bool autofocus;
  final bool obscureText; //是否密码 默认: false
  final bool readOnly; //是否为只读模式 默认: false
  final TextInputType keyboardType;

  CardViewSeriesNumber(
      {this.title = "Label",
      this.subtitle = "",
      this.maxLength,
      this.obscureText = false,
      this.placeholder = "placeholder",
      this.leading,
      this.trailing,
      this.onChanged,
      this.enabled = true,
      this.autofocus = false,
      this.onSubmitted,
      this.visible = true,
      this.isNotNull = false,
      this.readOnly = false,
      this.keyboardType = TextInputType.number}) {
    if (this.subtitle == null) {
      this.subtitle = "";
    }
  }

  @override
  _CardViewSeriesNumberState createState() => _CardViewSeriesNumberState();
}

class _CardViewSeriesNumberState extends State<CardViewSeriesNumber> {
  @override
  Widget build(BuildContext context) {
    if (widget.visible == false) {
      return Container();
    }
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 48.0,
            child: Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(widget.title,
                        style: TextStyle(fontSize: 14, color: Colors.black))),
                widget.isNotNull == true
                    ? Text("*", style: TextStyle(color: Colors.red))
                    : Container(),
                Expanded(
                  child: Container(
                    child: CupertinoTextField(
                      placeholder: widget.subtitle?.length > 0
                          ? widget.subtitle
                          : widget.placeholder,
                      placeholderStyle: TextStyle(),
                      keyboardType: widget.keyboardType,
                      readOnly: widget.readOnly,
                      obscureText: widget.obscureText,
                      maxLength: widget.maxLength,
                      enabled: widget.enabled,
                      autofocus: widget.autofocus,
                      textAlign: TextAlign.end,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white),
                      style: TextStyle(
                          fontSize: 15,
                          color: widget.subtitle?.length > 0
                              ? Colors.black
                              : Colors.black38),
                      onChanged: widget.onChanged,
                      onSubmitted: widget.onSubmitted,
                    ),
                  ),
                ),
                Container(
                  width: widget.trailing != null ? 32 : 10,
                  height: widget.trailing != null ? 32 : 10,
                  padding: EdgeInsets.only(right: 10),
                  child: widget.trailing,
                )
              ],
            ),
          ),
          Divider(height: 1)
        ],
      ),
    );
  }
}
