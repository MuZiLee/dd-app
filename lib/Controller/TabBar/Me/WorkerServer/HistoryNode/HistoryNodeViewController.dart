
import 'package:one/Model/EventsStaff.dart';
import 'package:one/Provider/StaffManager.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 历史记录
class HistoryNodeViewController extends StatefulWidget {
  static const routeName = "/me/historyNode";

  @override
  _HistoryNodeViewControllerState createState() =>
      _HistoryNodeViewControllerState();
}

class _HistoryNodeViewControllerState extends State<HistoryNodeViewController> {

  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        title: "历史记录",
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
    events = await StaffManager.workflowHistory();
    setState(() {});
  }

  _buildChild(BuildContext context, {int index}) {

    EventsStaff event = events[index];

//    String status = "未审核";
//    String auditor = "暂无";
//    String remark = "暂无";
//    event.logs.map((e) {
//      auditor = e.ruser.username;
//      remark = e.remark;
//      if (e.status == 1) {
//        status = "通过";
//      }
//      if (e.status == 2) {
//        status = "驳回";
//      }
//      if (e.status == 3) {
//        status = "已关闭";
//      }
//    }).toList();

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
            Text(event.create_time, style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.right),
          ],
        ),
      )
    ])];

    /// 请假
    if (event.etype?.title.toString().contains("请假")) {
      tablerow.add(_leave(event));
    }
    /// 报销
    if (event.etype?.title.toString().contains("报销")) {
      tablerow.add(_reimbursement(event));
    }
    /// 离职
    if (event.etype?.title.toString().contains("离职")) {
          tablerow.add(_quit(event));
    }
    /// 预支
    if (event.etype?.title.toString().contains("预支")) {
      tablerow.add(_advancePayments(event));
    }

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


  /// 请假类型
  _leave(EventsStaff event) {
    return TableRow(children: [
      Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("备注：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.remark, style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("审核员：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.logs.length > 0 ? event.logs.last.ruser.username : "未知", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("回复：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.logs.length > 0 ? event.logs.last.remark : "暂无", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("状态：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text((event.logs.length > 0 && event.logs.last.status == 0) ? "待审核" : (event.logs.length > 0 && event.logs.last.status == 1) ? "同意" : (event.logs.length > 0 && event.logs.last.status == 2) ? "驳回" : "待审核", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              )

            ],
          )
      ),
      Container(
          margin: EdgeInsets.only(right: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 10,
              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.end,
//                crossAxisAlignment: CrossAxisAlignment.end,
//                children: <Widget>[
//
//                ],
//              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(event.hour.toString(), style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.right),
                  Text("：小时数", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.right),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(event.start_time.toString(), style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.right),
                  Text("：起始时间", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.right),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(event.end_time.toString(), style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.right),
                  Text("：结束时间", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.right),
                ],
              ),
            ],
          )
      ),
    ]);
  }

  /// 报销类型
  _reimbursement(EventsStaff event) {
    return TableRow(children: [
      Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("备注：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.remark, style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("审核员：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.logs.length > 0 ? event.logs.last.ruser.username : "未知", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("回复：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.logs.length > 0 ? event.logs.last.remark : "暂无", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("状态：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text((event.logs.length > 0 && event.logs.last.status == 0) ? "待审核" : (event.logs.length > 0 && event.logs.last.status == 1) ? "同意" : (event.logs.length > 0 && event.logs.last.status == 2) ? "驳回" : "待审核", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              )

            ],
          )
      ),
      Container(
          margin: EdgeInsets.only(right: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("¥"+event.cost.toString(), style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.right),
                  Text("：报销金额", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.right),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: InkWell(
                      child: ChoiceChip(
                        label: Text("查看凭证", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        selected: true,
                        labelPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                        padding: EdgeInsets.all(0.0),
                      ),
                      onTap: () {
                        // routePush(CardViewPictureBrowse(event.images));
                      },
                    ),
                  )
                ],
              ),
            ],
          )
      ),
    ]);
  }

  /// 离职类型
  _quit(EventsStaff event) {

    return TableRow(children: [
      Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("备注：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.remark, style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("审核员：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.logs.length > 0 ? event.logs.last.ruser.username : "未知", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("回复：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.logs.length > 0 ? event.logs.last.remark : "暂无", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("状态：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text((event.logs.length > 0 && event.logs.last.status == 0) ? "待审核" : (event.logs.length > 0 && event.logs.last.status == 1) ? "同意" : (event.logs.length > 0 && event.logs.last.status == 2) ? "驳回" : "待审核", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              )

            ],
          )
      ),
      Container(
          margin: EdgeInsets.only(right: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(event.end_time.toString(), style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.right),
                  Text("：离场日期", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.right),
                ],
              ),

            ],
          )
      ),
    ]);

  }

  _advancePayments(EventsStaff event) {
    return TableRow(children: [
      Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("审核员：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.logs.length > 0 ? event.logs.last.ruser.username : "未知", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("回复：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text(event.logs.length > 0 ? event.logs.last.remark : "暂无", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("状态：", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.left),
                  Text((event.logs.length > 0 && event.logs.last.status == 0) ? "待审核" : (event.logs.length > 0 && event.logs.last.status == 1) ? "同意" : (event.logs.length > 0 && event.logs.last.status == 2) ? "驳回" : "待审核", style: TextStyle(fontSize: 10, color: Colors.red), textAlign: TextAlign.left),
                ],
              )

            ],
          )
      ),
      Container(
          margin: EdgeInsets.only(right: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("¥"+event.cost.toString(), style: TextStyle(fontSize: 13, color: Colors.red), textAlign: TextAlign.right),
                  Text("：预支金额", style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.right),
                ],
              ),

            ],
          )
      ),
    ]);
  }

//  _columnWidths() {
//    return {
//      //列宽
//      0: FixedColumnWidth(85.0),
//      2: FixedColumnWidth(85.0),
//    };
//  }


}
