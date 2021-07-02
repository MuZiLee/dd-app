

import 'package:one/Views/CardSeries/PickerTool/flutter_location_picker.dart';
import 'package:flutter/material.dart';

class CardViewSeriesCity extends StatefulWidget {


  String title;
  String subtitle;
  String initialProvince;
  String initialCity;
  String initialTown;
  bool isNotNull;
  DateChangedCallback onConfirm;
  CardViewSeriesCity({
    this.title = "title",
    this.subtitle = "subtitle",
    this.isNotNull = false,
    this.onConfirm,
    this.initialProvince = "北京市",
    this.initialCity = "北京市",
    this.initialTown = "东城区",
  }) {
    if (this.subtitle == null) {
      this.subtitle = "";
    }
  }


  @override
  _CardViewSeriesCityState createState() => _CardViewSeriesCityState();
}

class _CardViewSeriesCityState extends State<CardViewSeriesCity> {

  String confirm = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 10,top: 10, bottom: 10),
                    child: Text(widget.title,
                        style: TextStyle(fontSize: 14, color: Colors.black))),
                widget.isNotNull == true ? Text("*", style: TextStyle(color: Colors.red)) : Container(),
                Expanded(
                  child: Container(
                    child: Text(confirm.length > 0 ? confirm : widget.subtitle, textDirection: TextDirection.rtl, style: TextStyle(fontSize: 14, color: confirm.length > 0 ? Colors.black : Colors.black38)),
                  ),
                ),
                Container(
                  width: 32, height: 32,
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.chevron_right, color: Colors.black38),
                )
              ],
            ),
            Divider(height: 1)
          ],
        ),
        onTap: () {

          LocationPicker.showPicker(
            context,
            showTitleActions: true,
            initialProvince: widget.initialProvince,
            initialCity: widget.initialCity,
            initialTown: widget.initialTown,
            onChanged: (p, c, t) {
              print('$p $c $t');
              setState(() {
                widget.initialProvince = p;
                widget.initialCity = c;
                widget.initialTown = t;
              });
            },
            onConfirm: (p, c, t) {
              print('$p $c $t');
              confirm = "$p $c $t";
              if (widget.onConfirm != null) {
                widget.onConfirm(p, c, t);
              }
              setState(() {
                widget.initialProvince = p;
                widget.initialCity = c;
                widget.initialTown = t;
              });
            },
          );

        },
      ),
    );
  }
}
