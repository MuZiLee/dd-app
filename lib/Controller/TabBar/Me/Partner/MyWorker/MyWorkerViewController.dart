
import 'package:demo2020/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Provider/PartnerManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardChatTableViewCell.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherSliverList.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:nav_router/nav_router.dart';

/**
 * 我的工人
 */
class MyWorkerViewController extends StatefulWidget {
  @override
  _MyWorkerViewControllerState createState() => _MyWorkerViewControllerState();
}

class _MyWorkerViewControllerState extends State<MyWorkerViewController> {

  static List mystafflist = [];
  _onRefresh() async {

    mystafflist = await PartnerManager.getMyStafflist();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "我的工人",
      child: CupertinoScrollbar(
        child: CardRefresher(
          onRefresh: _onRefresh,
          child:mystafflist.length == 0 ? Error404View() : CardRefresherSliverList(
              childCount: mystafflist.length,
              builder: (_, index) {
                User _user = mystafflist[index];

                return CardChatTableViewCell(
                  avatar: _user.avatar,
                  title: _user.username != null ? _user.username : "",
                  subTitle: _user.phone,
                  onTap: () async{
                    /// 进入会话
                    if (IM.isLogin == false) {
                      ZKCommonUtils.showToast("正在链接,请稍候再试");
                      return;
                    }
                    routePush(ConversationViewController(_user.phone));
                  },
                );
              }
          ),
        ),
      ),
    );
  }

}
