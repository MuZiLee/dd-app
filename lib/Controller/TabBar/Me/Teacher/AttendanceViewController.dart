
import 'package:common_utils/common_utils.dart';
import 'package:demo2020/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:demo2020/Model/EventsStaff.dart';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/FactoryManager.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesBottomSheet.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AttendanceViewController extends StatefulWidget {

  String title;
  Teacher teacher;
  AttendanceViewController({this.title, this.teacher});

  @override
  _AttendanceViewControllerState createState() => _AttendanceViewControllerState();
}

class _AttendanceViewControllerState extends State<AttendanceViewController> {

  RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "考勤",
      child: CardRefresher(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        child: attendancelist.length < 1 ? Error404View() : CardRefresherListView(
          itemCount: attendancelist.length,
          itemBuilder: (_, index) {

            EventsStaff event = attendancelist[index];

            String timestamp = "";
            if (event.create_time != null) {
              DateTime dateTime = DateTime.parse(event.create_time);
              timestamp = TimelineUtil.formatByDateTime(dateTime, locale: 'zh').toString();
            }

            bool isVisibleAudit = false;  //默认未到驻场审核
            if (event.logs?.length > 0) {
              Log lastLog = event.logs.last;
              if (lastLog.role.id == Account.resident_teacher) {
                isVisibleAudit = false;
              } else {
                isVisibleAudit = true;
              }
            } else {
              isVisibleAudit = true;
            }

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
                                        Text("${event.hour}小时", style: TextStyle(fontSize: 13, color: Colors.grey)),
                                        Text(event.job?.job_name.toString(), style: TextStyle(fontSize: 13, color: Colors.grey)),
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
                                              label: Text("审核", style: TextStyle(fontSize: 12, color: Colors.blueAccent )),
                                              selected: isVisibleAudit,
                                              labelPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                                              padding: EdgeInsets.all(0.0),
                                              pressElevation: 0.0
                                          ),
                                          onTap: () {
                                            if (isVisibleAudit) {
                                              _touchShowReview(context, event.id);
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 10.0),
                                        child: !isVisibleAudit ? Container() : InkWell(
                                          child: ChoiceChip(
                                              selectedColor: Colors.deepOrange,
                                              label: Text("删除", style: TextStyle(fontSize: 12, color: Colors.white )),
                                              selected: true,
                                              labelPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                                              padding: EdgeInsets.all(0.0),
                                              pressElevation: 0.0
                                          ),
                                          onTap: () {
                                            if (isVisibleAudit) {
                                            _touchShowReview(context, event.id, isDelete: true);
                                            }
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
        ),
      ),
    );
  }

  List attendancelist = [];
  _onRefresh() async {
    Future.delayed(Duration(seconds: 3), (){
      _refreshController.refreshFailed();
    });

    attendancelist = await FactoryManager.getAttendancelist(fid: widget.teacher.id);
    setState(() {

    });
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

                  if (logs.length < 1) {
                    return Error404View();
                  }

                  return CardRefresherListView(
                    itemCount: logs.length,
                    itemBuilder: (_, index) {
                      Log log = logs[index];

                      var username = "";
                      if (log.ruser != null) {
                        username = log.ruser.username;
                      }

                      return Column(
                        children: <Widget>[
                          InkWell(
                              child: ListTile(
                                leading: Icon(log.status == 1 ? Icons.check_circle : Icons.info, color: log.status == 1 ? Colors.blue : Colors.red,),
                                title: Text("审核员:"+ log.role.title, style: TextStyle(fontSize: 14)),
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

  _touchShowReview(BuildContext context, int eid, {bool isDelete = false}) {
    print("_touchShowReview");

    List<CupertinoActionSheetAction> actions = [];

    if (isDelete == false) {
      actions = [
        //操作按钮集合
        CupertinoActionSheetAction(
            child: Text('确认', style: TextStyle(fontSize: 14)),
            onPressed: () {
              _audit(eid, status: 1);
            }
        ),
        CupertinoActionSheetAction(
          child: Text('驳回', style: TextStyle(fontSize: 14)),
          onPressed: () {
            _audit(eid, status: 2);
          },
        ),
      ];
    } else {
      actions = [
        CupertinoActionSheetAction(
            child: Text("删除", style: TextStyle(fontSize: 14)),
            onPressed: () {
              _delete(eid);
            }
        ),
      ];
    }

    CardShowActionSheetController(
        context,
        title: "审核操作",
        subtitle: "请选择操作方式",
        actions: actions
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
          await FactoryManager.setAttendance(eid: eid, remark: value, status: status);
          Progresshud.dismiss();
          Navigator.of(context).pop();
          _onRefresh();
        }
    );
  }

  _delete(int eid) async {
    Progresshud.show();
    await FactoryManager.delAttendance(eid: eid);
    Progresshud.dismiss();
    Navigator.of(context).pop();
    _onRefresh();
  }

}
