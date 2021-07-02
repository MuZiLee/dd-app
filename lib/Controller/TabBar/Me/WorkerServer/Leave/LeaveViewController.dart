import 'package:demo2020/Provider/StaffManager.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesDate.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesNumber.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesText.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesTextView.dart';
import 'package:demo2020/Views/MyBehavior.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

class LeaveViewController extends StatefulWidget {
  @override
  _LeaveViewControllerState createState() => _LeaveViewControllerState();
}

class _LeaveViewControllerState extends State<LeaveViewController> {
  ScrollController controller = new ScrollController();

  String startTime = "";
  String endTime = "";
  String hour = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "请假",
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            textColor: topColor,
            color: selectedIconColor,
            child: Text("提交", style: TextStyle(color: Colors.white)),
            onPressed: content.length < 1
                ? null
                : () async {
                    if (startTime.length < 1 || endTime.length < 1) {
                      ZKCommonUtils.showToast("请检查时间是否正确");
                      return;
                    }
                    if (hour == "") {
                      ZKCommonUtils.showToast("请假小时数");
                      return;
                    }

                    if (await StaffManager.leave(
                        remark: content,
                        hour: hour,
                        start_time: startTime,
                        end_time: endTime)) {
                      ZKCommonUtils.showToast("请假已提交");
                      pop();
                    }
                  },
          ),
        )
      ],
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: <Widget>[
              CardViewSeriesText(
                title: "事件类型",
                subtitle: "请假",
                enabled: false,
              ),
              CardViewSeriesDate(
                title: "起始时间",
                showTime: true,
                isNotNull: true,
                placeholder: startTime,
                onShowTime: (value) => startTime = value,
              ),
              CardViewSeriesDate(
                title: "结束时间",
                showTime: true,
                isNotNull: true,
                placeholder: endTime,
                onShowTime: (value) => endTime = value,
              ),

              CardViewSeriesNumber(
                title: "请假小时数",
                isNotNull: true,
                placeholder: "小时数",
                subtitle: hour,
                onChanged: (value) => hour = value,
              ),
              CardViewSeriesTextView(
                title: "事由",
                isNotNull: true,
                placeholder: "",
                valueChanged: (value) {
                  content = value;
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
