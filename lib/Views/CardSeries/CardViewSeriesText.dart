import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CardViewSeriesText extends StatefulWidget {

  final String title;
  String subtitle;
  final String placeholder;
  final Widget leading;
  final Widget trailing;
  final ValueChanged onChanged;
  final VoidCallback onTap; // 只有当enabled=false时才生效
  final bool isNotNull; // 是否必填 默认为 false
  final bool enabled; // 是可以编辑
  final bool visible;
  final TextInputType keyboardType;

  CardViewSeriesText(
      {this.title = "Label",
        this.isNotNull = false,
        this.subtitle = "",
        this.placeholder = "placeholder",
        this.leading,
        this.trailing,
        this.onChanged,
        this.onTap,
        this.enabled = true,
        this.visible = true,
        this.keyboardType = TextInputType.multiline
      }) {
    if (this.subtitle == null) {
      this.subtitle = "";
    }
  }

  @override
  _CardViewSeriesTextState createState() => _CardViewSeriesTextState();
}

class _CardViewSeriesTextState extends State<CardViewSeriesText> {




  @override
  Widget build(BuildContext context) {
    if (widget.visible == false) {
      return Container();
    }
    return Container(
      child: InkWell(
        onTap: widget.enabled == false ? widget.onTap : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              color: Colors.white,
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
                      height: 48.0,
                      child: CupertinoTextField(
                        placeholder: widget.subtitle?.length > 0
                            ? widget.subtitle
                            : widget.placeholder,
                        placeholderStyle: TextStyle(),
                        textAlign: TextAlign.end,
                        enabled: widget.enabled,
                        keyboardType: widget.keyboardType,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.white
                        ),
                        style: TextStyle(
                            fontSize: 14,
                            color: widget.subtitle?.length > 0
                                ? Colors.black
                                : Colors.grey),
                        onChanged: (value){
                          setState(() {
                            widget.subtitle = value;
                          });
                          if (widget.onChanged != null) {
                            widget.onChanged(value);
                          }
                        },
                        onTap: () {

                          if (widget.onTap != null && widget.enabled == true){
                            widget.onTap();
                          }
                        },
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
      ),
    );
  }
}
