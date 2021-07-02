import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CardViewSeriesDate extends StatefulWidget {
  final Widget leading;
  final String title;
  final bool isNotNull;
  String placeholder;
  DateTime maxTime;
  DateTime minTime;
  bool showTime;
  final ValueChanged<DateTime> valueChanged;
  final ValueChanged<DateTime> onConfirm;
  final ValueChanged<String> onShowTime;

  CardViewSeriesDate(
      {this.leading,
      this.title = "Title",
      this.maxTime,
      this.minTime,
      this.isNotNull = false,
      this.showTime = false,
      this.placeholder,
      this.valueChanged,
      this.onShowTime,
      this.onConfirm}) {
    if (maxTime == null) {
      this.maxTime = DateTime(2088, 1, 1, 00, 00);
    }
    if (this.minTime == null) {
      this.minTime = DateTime.now();
    }
  }

  @override
  _CardViewSeriesDateState createState() => _CardViewSeriesDateState();
}

class _CardViewSeriesDateState extends State<CardViewSeriesDate> {
  @override
  Widget build(BuildContext context) {
    if (widget.placeholder == null) {
      DateTime dateTime = DateTime.now();
      if (widget.showTime) {
        widget.placeholder = "${dateTime.year.toString()}/${dateTime.month.toString().padLeft(2,'0')}/${dateTime.day.toString().padLeft(2,'0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
      } else {
        widget.placeholder = "${dateTime.year}/${dateTime.month}/${dateTime.day}";
      }
    }

    return InkWell(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (widget.leading != null) widget.leading,
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                            child: Text(widget.title,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black))),
                        widget.isNotNull == true
                            ? Text("*", style: TextStyle(color: Colors.red))
                            : Container(),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(widget.placeholder,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  textAlign: TextAlign.end)),
                        ),
                        Icon(
                          Icons.access_alarm,
                          size: 21,
                          color: Colors.deepOrangeAccent,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1)
          ],
        ),
        onTap: () {
          if (widget.showTime) {
            DatePicker.showDateTimePicker(
              context,
              locale: LocaleType.zh,
              showTitleActions: true,
              minTime: widget.minTime,
              maxTime: widget.maxTime,
              onConfirm: (DateTime dateTime) {
                if (widget.valueChanged != null) {
                  widget.valueChanged(dateTime);
                }
                String placeholder = "${dateTime.year.toString()}/${dateTime.month.toString().padLeft(2,'0')}/${dateTime.day.toString().padLeft(2,'0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                if (widget.onShowTime != null) {
                  widget.onShowTime(placeholder);
                }
                setState(() {
                  widget.placeholder = placeholder;
                });
                if (widget.onConfirm != null) {
                  widget.onConfirm(dateTime);
                }
              },
              onChanged: (DateTime dateTime) {
                if (widget.valueChanged != null) {
                  widget.valueChanged(dateTime);
                }
                String placeholder = "${dateTime.year.toString()}/${dateTime.month.toString().padLeft(2,'0')}/${dateTime.day.toString().padLeft(2,'0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                if (widget.onShowTime != null) {
                  widget.onShowTime(placeholder);
                }
                setState(() {
                  widget.placeholder = placeholder;
                });
              },
            );

            return;
          }

          DatePicker.showDatePicker(
            context,
            locale: LocaleType.zh,
            showTitleActions: true,
            currentTime: DateTime.now(),
            maxTime: widget.maxTime,
            minTime: widget.minTime,
            onConfirm: (DateTime dateTime) {
              if (widget.valueChanged != null) {
                widget.valueChanged(dateTime);
              }
              String placeholder = "${dateTime.year.toString()}/${dateTime.month.toString().padLeft(2,'0')}/${dateTime.day.toString().padLeft(2,'0')}";
              if (widget.onShowTime != null) {
                widget.onShowTime(placeholder);
              }
              setState(() {
                widget.placeholder = placeholder;
              });
            },
            onChanged: (DateTime dateTime) {
              if (widget.valueChanged != null) {
                widget.valueChanged(dateTime);
              }

              String placeholder = "${dateTime.year.toString()}/${dateTime.month.toString().padLeft(2,'0')}/${dateTime.day.toString().padLeft(2,'0')}";
              if (widget.onShowTime != null) {
                widget.onShowTime(placeholder);
              }
              setState(() {
                widget.placeholder = placeholder;
              });
            },
          );
        });
  }
}
