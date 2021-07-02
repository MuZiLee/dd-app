
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
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';

/**
 * 我的初级合伙人
 */
class MyPrimaryViewController extends StatefulWidget {
  static const routeName = "/me/myprimary";

  @override
  _MyPrimaryViewControllerState createState() => _MyPrimaryViewControllerState();
}

class _MyPrimaryViewControllerState extends State<MyPrimaryViewController> {

  static List myProimary = [];
  _onRefresh() async {
    myProimary = await PartnerManager.getMyJuniorPartnerlist();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "我的初级合伙人",
      child: CupertinoScrollbar(
        child: CardRefresher(
          onRefresh: _onRefresh,
          child:myProimary.length == 0 ? Error404View() : CardRefresherSliverList(
              childCount: myProimary.length,
              builder: (_, index) {
                User _user = myProimary[index];
//                          print(_user.avatar);
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
