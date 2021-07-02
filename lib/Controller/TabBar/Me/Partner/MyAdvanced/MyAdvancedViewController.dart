
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
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

/**
 * 我的高级合伙人
 */
class MyAdvancedViewController extends StatefulWidget {
  static const routeName = "/me/myAdvanced";

  @override
  _MyAdvancedViewControllerState createState() => _MyAdvancedViewControllerState();
}

class _MyAdvancedViewControllerState extends State<MyAdvancedViewController> {

  static List myProimary = [];
  _onRefresh() async {
    myProimary = await PartnerManager.getMySeniorPartner();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "我的高级合伙人",
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
