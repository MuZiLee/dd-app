
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardViewSeriesSwitch extends StatefulWidget {

  final String title;
  final String subtitle;
  final String falseText;
  final String trueText;
  bool value;
  final bool enabled;
  final bool isNotNull;
  final ValueChanged<bool> onChanged;
  CardViewSeriesSwitch({
    this.title = "title",
    this.subtitle = "subtitle",
    this.falseText = "falseText",
    this.trueText = "trueText",
    this.value = false,
    this.enabled = true,
    this.isNotNull = false,
    this.onChanged}) {
    if (this.value == null) {
      this.value = false;
    }
  }


  @override
  _CardViewSeriesSwitchState createState() => _CardViewSeriesSwitchState();
}

class _CardViewSeriesSwitchState extends State<CardViewSeriesSwitch> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10,top: 10, bottom: 10),
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                widget.isNotNull == true ? Text("*", style: TextStyle(color: Colors.red)) : Container(),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.falseText,
                          style: TextStyle(fontSize: 14, color: widget.value == false ? Colors.black : Colors.black38),
                        ),
                        SizedBox(width: 20),
                        CupertinoSwitch(value: widget.value, onChanged: (value) {
                          setState(() {
                            widget.value = value;
                            widget.onChanged(value);

                          });
                        }),
                        SizedBox(width: 20),
                        Text(
                          widget.trueText,
                          style: TextStyle(fontSize: 14, color: widget.value == true ? Colors.black : Colors.black38),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 1)
          ],
        ),
      ),
    );
  }

}
