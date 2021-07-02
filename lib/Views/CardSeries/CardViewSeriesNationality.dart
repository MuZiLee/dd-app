import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';

class CardViewSeriesNationality extends StatefulWidget {
  final String title;
  String subtitle;
  String initialProvince;
  String initialCity;
  String initialTown;
  final bool isNotNull;
  final ValueChanged onConfirm;

  CardViewSeriesNationality(
      {this.title = "title",
      this.subtitle = "subtitle",
      this.isNotNull = false,
      this.onConfirm
      }) {
    if (this.subtitle == null) {
      this.subtitle = "";
    }
  }

  @override
  _CardViewSeriesNationalityState createState() =>
      _CardViewSeriesNationalityState();
}

class _CardViewSeriesNationalityState extends State<CardViewSeriesNationality> {
  String confirm = "";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
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
                  child: Text(confirm.length > 0 ? confirm : widget.subtitle,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 14,
                          color: confirm.length > 0
                              ? Colors.black
                              : Colors.black38)),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.chevron_right, color: Colors.black38),
              )
            ],
          ),
          Divider(height: 1)
        ],
      ),
      onTap: () {
        DataPicker.showDatePicker(
          context,
          datas: itemExtent,
          onChanged: (value) {
            setState(() {
              widget.subtitle = value;
              confirm = value;
            });
          },
          onConfirm: (title) {
            widget.subtitle = title;
            confirm = title;
            widget.onConfirm(title);
            setState(() {

            });
          },
        );
      },
    );
  }

  List itemExtent = [
    "汉族",
    "壮族",
    "满族",
    "回族",
    "苗族",
    "维吾尔族",
    "土家族",
    "彝族",
    "蒙古族",
    "藏族",
    "布依族",
    "侗族",
    "瑶族",
    "朝鲜族",
    "白族",
    "其他",
  ];
}
