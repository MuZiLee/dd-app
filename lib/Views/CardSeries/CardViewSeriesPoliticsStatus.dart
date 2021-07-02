import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_data_picker/flutter_cupertino_data_picker.dart';

class CardViewSeriesPoliticsStatus extends StatefulWidget {

  final String title;
  String subtitle;
  String initialProvince;
  String initialCity;
  String initialTown;
  final bool isNotNull;
  final ValueChanged onConfirm;

  CardViewSeriesPoliticsStatus(
      {this.title = "title",
        this.subtitle = "subtitle",
        this.isNotNull = false,
        this.onConfirm
      });

  @override
  _CardViewSeriesPoliticsStatusState createState() => _CardViewSeriesPoliticsStatusState();
}

class _CardViewSeriesPoliticsStatusState extends State<CardViewSeriesPoliticsStatus> {

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
          onConfirm: widget.onConfirm,
        );
      },
    );
  }

  List itemExtent = [
    "无党派人士",
    "中共预备党员",
    "共青团员",
    "共产党员",
    "民革党员",
    "民盟盟员",
    "民建会员",
    "民进会员",
    "农工党党员",
    "致公党党员",
    "九三学社社员",
    "台盟盟员",
    "人大代表",
    "人大代表",
    "其他",
  ];
}
