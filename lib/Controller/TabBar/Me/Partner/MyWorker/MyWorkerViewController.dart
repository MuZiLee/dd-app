
import 'package:one/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:one/Model/User.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/IM.dart';
import 'package:one/Provider/PartnerManager.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/CardSeries/CardChatTableViewCell.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/CardSeries/CardRefresherSliverList.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
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
