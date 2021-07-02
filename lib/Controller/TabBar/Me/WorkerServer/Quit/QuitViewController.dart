import 'dart:math';

import 'package:demo2020/Provider/StaffManager.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardViewRatingBar.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesDate.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesEmptyCell.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesSwitch.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesText.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesTextView.dart';
import 'package:demo2020/Views/MyBehavior.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:io';

import 'package:nav_router/nav_router.dart';

class QuitViewController extends StatefulWidget {
  @override
  _QuitViewControllerState createState() => _QuitViewControllerState();
}

class _QuitViewControllerState extends State<QuitViewController> {
  ScrollController controller = ScrollController();

  String remark = "";
  String endTime = "";
  double _value = 4.5;
  String _comment = "好评";

  @override
  Widget build(BuildContext context) {

    if (_value < 1.5) {
      _comment = "差评";
    } else if (_value < 2.5) {
      _comment = "一般";
    } else if (_value < 3.5) {
      _comment = "良好";
    } else if (_value < 4.5) {
      _comment = "优秀";
    } else {
      _comment = "非常优秀";
    }

    return BaseScaffold(
      title: "离职",
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: <Widget>[

              CardViewSeriesText(
                title: "事件类型",
                subtitle: "离职申请",
                enabled: false,
              ),
              CardViewSeriesDate(
                title: "离场日期",
                isNotNull: true,
                placeholder: endTime.length < 1 ? "点击" : endTime,
                onShowTime: (value) => endTime = value,
              ),
              CardViewSeriesTextView(
                title: "原因",
                isNotNull: true,
                placeholder: "",
                valueChanged: (value) {
                  remark = value;
                  setState(() {});
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text("给驻场老师评分"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("${_comment}"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: RatingBar(
                  initialRating: _value, //初始评分 double
                  allowHalfRating: true,//允许0.5评分
                  itemCount: 5,//评分组件个数
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _value = rating;
                    });
                  },
                ),
              ),
              Container(
                child: Center(
                  child: Text("${_value}星"),
                ),
              ),

              
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            textColor: topColor,
            color: selectedIconColor,
            child: Text("提交", style: TextStyle(color: Colors.white)),
            onPressed: remark.length < 1 ? null : () async {
              if (remark.length < 1) {
                ZKCommonUtils.showToast("请写明离职原因");
                return;
              }
              if (endTime.length < 1) {
                ZKCommonUtils.showToast("未选择离场日期");
                return;
              }

              if (await StaffManager.quit(remark: remark, star: _value, endTime: endTime)) {
                ZKCommonUtils.showToast("提交成功");
                pop();
              }
            },
          ),
        )
      ],
    );
  }
}
