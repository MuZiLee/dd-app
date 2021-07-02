import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:demo2020/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Teacher/FactoryEmployeesViewController.dart';
import 'package:demo2020/Model/EventTeacherAudit.dart';
import 'package:demo2020/Model/FactoryInfo.dart';
import 'package:demo2020/Model/FactoryStaff.dart';
import 'package:demo2020/Model/JobModel.dart';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/FactoryManager.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesBottomSheet.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 工资条
 */
class FactoryCalculationWagesViewController extends StatefulWidget {
  String title;
  Teacher teacher;

  FactoryCalculationWagesViewController({this.title, this.teacher});

  @override
  _FactoryCalculationWagesViewControllerState createState() =>
      _FactoryCalculationWagesViewControllerState();
}

class _FactoryCalculationWagesViewControllerState extends State<FactoryCalculationWagesViewController> {

  ScrollController controller = ScrollController();

//  _onRefresh() async {
//    _refreshController.refreshFailed();
//    staffs = await FactoryManager.getStaffInfolist(fid: widget.teacher.id);
//    setState(() {});
//  }


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "工资条",
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            _build_Hourly_work(),
            _equal_pay_for_equal_work(),
            _agency_recruitment(),
            SizedBox(height: 64.0),
          ],
        ),
      ),
    );
  }

  /**
   * 小时工 工资条
   */
  _build_Hourly_work() {
    if (widget.teacher.sigingInformation.cooperation_mode.contains("小时工")) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Text("小时工工资条", style: TextStyle(fontSize: 14)),
            ),
          ),
          new Container(
            child: Table(
                columnWidths: _columnWidths(),
                //表格边框样式
                border: _border(),
                children: [
                  TableRow(children: [
                    Text('合作方式',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("小时工",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text('员工单价',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                  ]),
                  TableRow(children: [
                    Text('管理费',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                        textAlign: TextAlign.center),
                    Text('税费',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                        textAlign: TextAlign.center),
                  ]),
                  TableRow(children: [
                    Text('保险费',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                        textAlign: TextAlign.center),
                    Text('补助',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text(""),
                  ]),
                  TableRow(children: [
                    Text('借款',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                        textAlign: TextAlign.center),
                    Text('其他扣款',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text(""),
                  ]),
                  TableRow(children: [
                    Text('保险',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                        textAlign: TextAlign.center),
                    Text('',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text(""),
                  ]),
                ]),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text("使用", style: TextStyle(fontSize: 14)),
                  onPressed: () {
                    routePush(FactoryEmployeesViewController(widget.teacher));
                  },
                )
              ],
            ),
          ),
          Divider(height: 1.0)
        ],
      );
    } else {
      return Container();
    }

  }

  /**
   * 同工同酬 工资条
   */
  _equal_pay_for_equal_work() {
    if (widget.teacher.sigingInformation.cooperation_mode.contains("同工同酬")) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 32.0),
            child: Center(
              child: Text("同工同薪工资条", style: TextStyle(fontSize: 14)),
            ),
          ),
          new Container(
            child: Table(columnWidths: _columnWidths(), border: _border(), children: [
              TableRow(children: [
                Text("合作方式",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("同工同酬",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("入职日期",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
              ]),
              TableRow(children: [
                Text("姓名",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("职位",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center),
              ]),
              TableRow(children: [
                Text("基本薪资",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("底薪工资",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center),
              ]),
              TableRow(children: [
                Text("当月标准天数",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("实际出勤天数",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
              TableRow(children: [
                Text("平时加班工时",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("平时加班工资",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
              TableRow(children: [
                Text("周末加班工时",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("周末加班工资",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
              TableRow(children: [
                Text("节假日加班工时",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("节假日加班工资",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
              TableRow(children: [
                Text("其他加项",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("加项工资小计",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
              TableRow(children: [
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("应发工资",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
              TableRow(children: [
                Text("伙食费",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("税金",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
              TableRow(children: [
                Text("社保费",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("公积金",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
              TableRow(children: [
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("其他扣款",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
              TableRow(children: [
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("扣费小计",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
              TableRow(children: [
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text("实发工资",
                    style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                Text(""),
              ]),
            ]),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text("使用"),
                  onPressed: () {
                    routePush(FactoryEmployeesViewController(widget.teacher));
                  },
                )
              ],
            ),
          ),
          Divider(height: 1.0),
        ],
      );
    } else {
      return Container();
    }
  }

  /**
   * 代理招聘 工资条
   */
  _agency_recruitment() {
    if (widget.teacher.sigingInformation.cooperation_mode.contains("代理招聘")) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 32.0),
            child: Center(
              child: Text("代理招聘工资条", style: TextStyle(fontSize: 14)),
            ),
          ),
          new Container(
            child: Table(
                columnWidths: _columnWidths(),
                //表格边框样式
                border: _border(),
                children: [
                  TableRow(children: [
                    Text("合作方式",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("代理招聘",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("入职时间",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                  ]),
                  TableRow(children: [
                    Text('姓名',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("职位",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                  ]),
                  TableRow(children: [
                    Text('管理费',
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    Text("",
                        style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                  ]),
                ]),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text("使用"),
                  onPressed: () {
                    routePush(FactoryEmployeesViewController(widget.teacher));
                  },
                )
              ],
            ),
          ),
          Divider(height: 1.0),
        ],
      );
    } else {
      return Container();
    }
  }

  _border() {
    //表格边框样式
    return TableBorder.all(
      color: Colors.grey,
      width: 0.5,
      style: BorderStyle.solid,
    );
  }

  _columnWidths() {
    return {
      //列宽
      0: FixedColumnWidth(85.0),
      2: FixedColumnWidth(85.0),
    };
  }

  _lists() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, index) {
          FactoryStaff staff;// = staffs[index];

          bool isVisibleAudit = true;

          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: ClipOval(
                        child: InkWell(
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: ExactAssetImage(
                                      "images/Avatar/avatar.png")),
                              color: Colors.deepOrange,
                            ),
                            child: SBImage(
                                url: staff.user.avatar, fit: BoxFit.cover),
                          ),
                          onTap: () async {
                            /// 进入会话
                            if (IM.isLogin == false) {
                              ZKCommonUtils.showToast("正在链接,请稍候再试");
                              return;
                            }
                            await IM.enterConversation(phone: staff.user.phone);
                            routePush(ConversationViewController(staff.user.phone));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          // 用户名+时间
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(staff.user.username),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10.0),
//                                            child: Text(staff.job.create_time, textAlign: TextAlign.c, style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //用户信息
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                // 事件名 + 职位名 + 工厂名
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 5.0),
                                      Text("入职时间:" + staff.create_time,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Text(staff.job.job_name,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      Text(staff.factory.factory_name,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
//                                              Text("event.factory?.factory_name.toString()", style: TextStyle(fontSize: 12, color: Colors.grey), maxLines: 2),
                                    ],
                                  ),
                                ),
                                // 执行按钮
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: InkWell(
                                        child: ChoiceChip(
                                            label: Text(
                                                isVisibleAudit ? "添加" : "已添加",
                                                style: TextStyle(fontSize: 12)),
                                            selected: true,
                                            labelPadding: EdgeInsets.only(
                                                left: 12.0, right: 12.0),
                                            padding: EdgeInsets.all(0.0),
                                            pressElevation: 0.0),
                                        onTap: () {
//                                                  if (isVisibleAudit) {
//                                                    _touchShowReview(context, event.id);
//                                                  } else {
//                                                    ZKCommonUtils.showToast("请等待其他人员审核");
//                                                  }
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      child: InkWell(
                                        child: ChoiceChip(
                                            label: Text("记录",
                                                style: TextStyle(fontSize: 12)),
                                            selected: true),
                                        onTap: () {},
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 1.0)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: 1.0)
              ],
            ),
          );
        },
//        itemCount: staffs.length,
      ),
    );
  }
}
