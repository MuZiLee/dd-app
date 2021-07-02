
import 'package:one/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:one/Model/EventsStaff.dart';
import 'package:one/Model/User.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/EventsManager.dart';
import 'package:one/Provider/FactoryManager.dart';
import 'package:one/Provider/IM.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/Bases/BaseScaffold.dart';
import 'package:one/Views/CardSeries/CardRefresherListView.dart';
import 'package:one/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:one/Views/CardSeries/CardViewSeriesBottomSheet.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 请假审核
 */
class FactoryLeaveAuditViewController extends StatefulWidget {

  String title;
  Teacher teacher;
  FactoryLeaveAuditViewController({this.title, this.teacher});

  @override
  _FactoryLeaveAuditViewControllerState createState() => _FactoryLeaveAuditViewControllerState();
}

class _FactoryLeaveAuditViewControllerState extends State<FactoryLeaveAuditViewController> {

  static List events = [];
  RefreshController _refreshController;

  _onRefresh() async {
    events = await FactoryManager.getStafflist(fid: widget.teacher.id, etid: EventsManager.leave_application);
    _refreshController.refreshFailed();
    setState(() {});
  }

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "请假审核",
      child: LayoutBuilder(
        builder: (i, c) {
          return SmartRefresher(
              enablePullDown: true,
              controller: _refreshController,
              header: MaterialClassicHeader(),
              onRefresh: _onRefresh,
              child: events.length == 0 ? Error404View(text: "0个请假申请",) : ListView.builder(
                itemBuilder: (_, index) {
                  EventsStaff event = events[index];


                  bool isVisibleAudit = true;  //默认未到驻场审核
                  event.logs.map((Log e) {
                    if (e.role.id == Account.ministry_of_personnel) {
                      isVisibleAudit = false;
                    }
                  }).toList();

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
                                    height: 48, width: 48,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: ExactAssetImage("images/Avatar/avatar.png")),
                                      color: Colors.deepOrange,
                                    ),
                                    child: Image.network(event.user.avatar, fit: BoxFit.cover),
                                  ),
                                  onTap: () async{
                                    /// 进入会话
                                    if (IM.isLogin == false) {
                                      ZKCommonUtils.showToast("正在链接,请稍候再试");
                                      return;
                                    }
                                    await IM.enterConversation(phone: event.user.phone);
                                    routePush(ConversationViewController(event.user.phone));
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
                                    margin: EdgeInsets.only(top:10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(event.user?.username.toString()),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10.0),
                                            child: Text(event.create_time.toString(), textAlign: TextAlign.right, style: TextStyle(fontSize: 10, color: Colors.grey)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  //报名信息
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        // 事件名 + 职位名 + 工厂名
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 5.0),
                                              Text("[${event.etype.title}]", style: TextStyle(fontSize: 13, color: Colors.grey)),
                                              Text("小时数:${event.hour.toString()}", style: TextStyle(fontSize: 13, color: Colors.grey), maxLines: 2),
                                              Text("起始时间:${event.start_time}\n结束时间:${event.end_time}", style: TextStyle(fontSize: 13, color: Colors.grey), maxLines: 2),
                                              Text(event.factory?.factory_name.toString(), style: TextStyle(fontSize: 12, color: Colors.grey), maxLines: 2),
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
                                              child: !isVisibleAudit ? Container() : InkWell(
                                                child: ChoiceChip(
                                                    label: Text(isVisibleAudit ? "审核" : "待审核", style: TextStyle(fontSize: 12)),
                                                    selected: isVisibleAudit,
                                                    labelPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                                                    padding: EdgeInsets.all(0.0),
                                                    pressElevation: 0.0
                                                ),
                                                onTap: () {
                                                  _touchShowReview(context, event.id);
                                                },
                                              ),
                                            ),

                                            Container(
                                              margin: EdgeInsets.only(right:10.0),
                                              child: InkWell(
                                                child: ChoiceChip(label: Text("记录", style: TextStyle(fontSize: 12)), selected: true),
                                                onTap: () => _touchShowLogs(context, logs: event.logs),
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
                itemCount: events.length,
              ));
        },
      ),
    );
  }


  _touchShowLogs(BuildContext context, {List logs}) async{
    print("_touchShowLogs");

    if (logs == null) {
      logs = [];
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (c) {
        return DraggableScrollableSheet(
          initialChildSize: 1.0,
          maxChildSize: 1.0,
          minChildSize: 0.5,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              child: StatefulBuilder(
                builder: (BuildContext context2, setter) {

                  return CardRefresherListView(
                    itemCount: logs.length,
                    itemBuilder: (_, index) {
                      Log log = logs[index];

                      return Column(
                        children: <Widget>[
                          InkWell(
                              child: ListTile(
                                leading: Icon(log.status == 1 ? Icons.check_circle : Icons.info, color: log.status == 1 ? Colors.blue : Colors.red,),
                                title: Text(log.ruser.username +":"+ log.role.title, style: TextStyle(fontSize: 14)),
                                subtitle: Text(log.remark, maxLines: 2, style: TextStyle(fontSize: 13)),
                                trailing: Text(log.create_time, style: TextStyle(fontSize: 12)),
                              )
                          ),
                          Divider(height: 1),
                        ],
                      );

                    },
                  );
                },
              ),
            );
          },
        );
      },
    );

  }

  _touchShowReview(BuildContext context, int eid) {
    print("_touchShowReview");

    CardShowActionSheetController(
        context,
        title: "审核操作",
        subtitle: "请选择操作方式",
        actions: [
          //操作按钮集合
          CupertinoActionSheetAction(
              child: Text('同意', style: TextStyle(fontSize: 14)),
              onPressed: () => _audit(eid, status: 1)

          ),
          CupertinoActionSheetAction(
            child: Text('驳回', style: TextStyle(fontSize: 14)),
            onPressed: () => _audit(eid, status: 2),
          ),
        ]
    );
  }

  _audit(int eid, {int status = 1}) async {
    Navigator.of(context).pop();
    CardViewSeriesBottomSheet(
        context,
        title: "提交审核",
        prompt: status == 1 ? "通过" : "驳回",
        placeholder: "备注",
        onCorrect: (value) async{
          if (value == null) {
            ZKCommonUtils.showToast("备注不能为空");
            return;
          }
          Progresshud.show();
          await FactoryManager.staffAudit(eid: eid, remark: value, status: status);
          Progresshud.dismiss();
          Navigator.of(context).pop();
          _onRefresh();
        }
    );
  }

}
