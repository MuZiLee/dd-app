
import 'package:demo2020/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:demo2020/Model/EventsStaff.dart';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Provider/PartnerManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardChatTableViewCell.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 我的准工人
 */
class MyProspectiveWorkerViewController extends StatefulWidget {
  @override
  _MyProspectiveWorkerViewControllerState createState() => _MyProspectiveWorkerViewControllerState();
}

class _MyProspectiveWorkerViewControllerState extends State<MyProspectiveWorkerViewController> {

  RefreshController _refreshController = RefreshController(initialRefresh: true);

  List wusers = [];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "我的准工人",
      child: CardRefresher(
        refreshController: _refreshController,
        onRefresh: () async{
          wusers = await PartnerManager.getMyPWorkerlist();
          _refreshController.refreshFailed();
            setState(() {

            });
        },
        child: wusers.length == 0 ? Error404View() : CardRefresherListView(
          itemCount: wusers.length,
          itemBuilder: (_, index) {

            SBUser wuser = wusers[index];

            return CardChatTableViewCell(
              avatar: wuser.avatar,
              title: wuser.username != null ? wuser.username : "",
              subTitle: wuser.phone,
              onTap: () async{
                /// 进入会话
                if (IM.isLogin == false) {
                  ZKCommonUtils.showToast("正在链接,请稍候再试");
                  return;
                }
                routePush(ConversationViewController(wuser.phone));
              },
            );

          },
        ),
      ),
    );
  }
}
