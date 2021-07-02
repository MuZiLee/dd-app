//
//  文件名：WordTimeViewController
//  所在包名：Controller.Home.WordCard
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-09
//  版权所有 © 2019。 保留所有权利
//

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_format/date_format.dart';
import 'package:one/Controller/TabBar/Me/WorkerServer/SalaryBudget/SalaryBudgetViewController.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/StaffManager.dart';
import 'package:one/Views/CardSeries/CardViewSeriesBottomSheet.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/Views/keyboard/BlankToolBarTool.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';

/// 工时录入

class WordTimeViewController extends StatefulWidget {
  static const routeName = "/home/WordTime";

  @override
  _WordTimeViewControllerState createState() => _WordTimeViewControllerState();
}

class _WordTimeViewControllerState extends State<WordTimeViewController> {
  TextEditingController nameController = TextEditingController();

  // Step1: 响应空白处的焦点的Node
  BlankToolBarModel blankToolBarModel = BlankToolBarModel();

  @override
  void initState() {
    // Step2.1: 焦点变化时的响应
    blankToolBarModel.outSideCallback = focusNodeChange;
    super.initState();
  }

  // Step2.2: 焦点变化时的响应操作
  void focusNodeChange() {
    setState(() {});
  }

  @override
  void dispose() {
    // Step3: 在销毁页面时取消监听
    blankToolBarModel.removeFocusListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode =
        blankToolBarModel.getFocusNodeByController(nameController);

    return BaseScaffold(
        title: "工时录入",
        elevation: 0.0,
        child: BlankToolBarTool.blankToolBarWidget(
          context,
          model: blankToolBarModel,
          body: SingleChildScrollView(
            child: buildContainer(focusNode, context),
          ),
        ));
  }

  /// 时间
  double hours = 0.0;

  Container buildContainer(FocusNode focusNode, BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 32),
          WordTimeView(),
          Container(
            padding: EdgeInsets.all(20),
            child: CupertinoTextField(
              placeholder: "今天上班多少小时?",
              focusNode: focusNode,
              controller: nameController,
              keyboardType: TextInputType.number,
              clearButtonMode: OverlayVisibilityMode.editing,
              maxLength: 4,
              placeholderStyle: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
              cursorColor: Colors.redAccent,
              textCapitalization: TextCapitalization.sentences,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Colors.redAccent,
                    style: BorderStyle.solid,
                    width: 5,
                  )),
              onChanged: (value) => hours = double.parse(value),
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.3)),
              child: Container(
                color: Colors.deepOrange,
                padding: EdgeInsets.all(30.0),
                child: InkWell(
                  child: Icon(Icons.weekend,
                      size: MediaQuery.of(context).size.width * 0.3,
                      color: topColor),
                  onTap: () async {
                    blankToolBarModel.closeKeyboard(context);

                    if (Account.user.staff == null ||
                        !Account.user.owned.contains(Account.worker)) {
                      ZKCommonUtils.showToast("亲,您还没入职呢?");
                      return;
                    }

                    if (hours < 1) {
                      ZKCommonUtils.showToast("亲,工时不能小于1小时哦~!");
                      return;
                    }

                    Progresshud.show();
                    if (await StaffManager.punch_the_clock(hour: hours)) {
                      Progresshud.dismiss();
                      hours = 0.0;
                      setState(() {});

                      AwesomeDialog(
                              context: context,
                              animType: AnimType.BOTTOMSLIDE,
                              dialogType: DialogType.SUCCES,
                              btnOkText: "去看看",
                              btnOkColor: Colors.blueAccent,
                              btnCancelText: "返回",
                              btnCancelColor: Colors.grey,
                              tittle: "录入完成",
                              desc: "亲,您要去查看一下工资的预算情况吗?",
                              btnOkOnPress: () {
                                routePush(SalaryBudgetViewController()).then((value) => pop());
                              },
                              btnCancelOnPress: () {})
                          .show();
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

class WordTimeView extends StatefulWidget {
  @override
  _WordTimeViewState createState() => _WordTimeViewState();
}

class _WordTimeViewState extends State<WordTimeView> {
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer timer;
  String _dateTime = "";

  void handleTick() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }

    DateTime dateTime = DateTime.now().toLocal();

    String value = formatDate(dateTime, [HH, ":", nn, ":", ss, am]);
    print("${value} -- ${dateTime.microsecondsSinceEpoch}");

    _dateTime = "星期 ${toZH(dateTime.weekday)}\n${value}";
    print(_dateTime);

    return Container(
      child: Text(_dateTime, textAlign: TextAlign.center),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    if (timer.isActive) {
      timer.cancel();
      timer = null;
    }
    super.deactivate();
  }
}

String toZH(int count) {
  if (count == 1) {
    return "一";
  }
  if (count == 2) {
    return "二";
  }
  if (count == 3) {
    return "三";
  }
  if (count == 4) {
    return "四";
  }
  if (count == 5) {
    return "五";
  }
  if (count == 6) {
    return "六";
  }
  if (count == 7) {
    return "日";
  }
}
