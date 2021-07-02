
import 'package:demo2020/Model/ApplyHistoryModel.dart';
import 'package:demo2020/Model/EventModel.dart';
import 'package:demo2020/Model/EventsStaff.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/EventsManager.dart';
import 'package:demo2020/Provider/StaffManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardViewPictureBrowse.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 历史记录
class ApplyHistoryViewController extends StatefulWidget {
  static const routeName = "/me/historyNode";

  ApplyHistoryViewController();
  @override
  _ApplyHistoryViewControllerState createState() =>
      _ApplyHistoryViewControllerState();
}

class _ApplyHistoryViewControllerState extends State<ApplyHistoryViewController> {

  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        title: "事件记录",
        child: CardRefresher(
          refreshController: refreshController,
          onRefresh: _onRefresh,
          child: events.length == 0 ? Error404View() : ListView.builder(itemBuilder: (_, index) {
            return _buildChild(_, index: index);
          },itemCount: events.length),
        )
    );
  }

  static List events = [];

  /**
   * TODO： 工作流 历史记录
   */
  _onRefresh() async {
    events = await EventsManager.getJobEvents(uid: Account.user.id);

    setState(() {});
  }

  _buildChild(BuildContext context, {int index}) {

    ApplyHistoryModel event = events[index];

    List<TableRow> tablerow = [TableRow(children: [
      Container(
        margin: EdgeInsets.only(left: 10.0, top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.etype?.title.toString(), style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
            Text("", style: TextStyle(fontSize: 13), textAlign: TextAlign.left),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(right: 10.0, top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(" ", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.right),
            // Text(event.create_time, style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.right),
          ],
        ),
      )
    ])];

    /// 初级合伙人申请
    tablerow.add(_advancePayments(event));


    return Container(
      child: Column(
        children: [
          Table(
            border: TableBorder.all(
              color: Colors.grey,
              width: 0.5,
              style: BorderStyle.none,
            ),
            children: tablerow,
          ),
          Divider(height: 1.0)
        ],
      ),
    );
  }


  _advancePayments(ApplyHistoryModel event) {
    return TableRow(children: [
      Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("最后审核员：", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("回复：", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("状态：", style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.left),
                ],
              )

            ],
          )
      ),
      Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(event.logs.length > 0 ? event.logs.last.user.username : "未知", style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.right),
                width: MediaQuery.of(context).size.width / 2 - 40,
              ),
              Container(
                child: Text(event.logs.length > 0 ? event.logs.last.remark : "暂无", style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.right),
                width: MediaQuery.of(context).size.width / 2 - 40,
              ),
              Container(
                child: Text((event.logs.length > 0 && event.logs.last.status == 0) ? "待审核" : (event.logs.length > 0 && event.logs.last.status == 1) ? "同意" : (event.logs.length > 0 && event.logs.last.status == 2) ? "驳回" : "待审核", style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.right),
                width: MediaQuery.of(context).size.width / 2 - 40,
              ),

            ],
          )
      ),
    ]);
  }


}
