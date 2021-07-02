
import 'package:demo2020/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:demo2020/Controller/TabBar/Chat/FriendApplyListViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/MyResume/MyResumeViewControlle.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardChatTableViewCell.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherSliverList.dart';
import 'package:demo2020/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';


/**
 * 我的好友
 */
class FriendsViewController extends StatefulWidget {
  static const routeName = "/caht/friends";

  @override
  _FriendsViewControllerState createState() => _FriendsViewControllerState();
}

class _FriendsViewControllerState extends State<FriendsViewController> {

  List<JMUserInfo> users = [];

  // 下拉刷新action
  void _onRefresh() async {
    /// TODU:
    /// 获取最新会话列表
    users = await IM.getFriends();
    setState(() {});

  }


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "我的好友",
      elevation: 0.0,
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 15),
          child: IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              routePush(FriendApplyListViewController()).then((value){
                _onRefresh();
              });

            },
          ),
        )
      ],
      child: CardRefresher(
        onRefresh: _onRefresh,
        child: users.length > 0 ? CardRefresherSliverList(
          childCount: users.length,
          builder: (_, index) {
            JMUserInfo userInfo = users[index];
            return CardChatTableViewCell(
              avatar: userInfo.extras["avatar"],
              title: userInfo.extras["username"],
              subTitle: userInfo.username,
              trailing: FlatButton(child: Icon(Icons.more_vert)),
              onTap: () {

                CardShowActionSheetController(
                  context,
                  title: "会话方式",
                  subtitle: "请选择你的操作",
                  actions: [
                    CupertinoActionSheetAction(
                      child: Text('删除好友', style: TextStyle(fontSize: 14)),
                      onPressed: () async{
                        Progresshud.show();
                        await IM.removeFromFriendList(phone: userInfo.username);
                        await _onRefresh();
                        Progresshud.dismiss();
                        Navigator.pop(context);
                    }),
                    CupertinoActionSheetAction(
                      child: Text('查看简历', style: TextStyle(fontSize: 14)),
                      onPressed: () {
                        Navigator.pop(context);
                        routePush(MyResumeViewControlle(false, username: userInfo.extras["username"]+"的", phone: userInfo.username,));
                      }
                    ),
                    CupertinoActionSheetAction(
                        child: Text('聊天', style: TextStyle(fontSize: 14)),
                        onPressed: () async{
                          /// 进入会话
                          if (IM.isLogin == false) {
                            ZKCommonUtils.showToast("正在链接,请稍候再试");
                            return;
                          }
                          await IM.enterConversation(phone: userInfo.username);
                          Navigator.pop(context);

                          routePush(ConversationViewController(userInfo.username));
                        }
                    ),
                  ]
                );



              },
            );
          },
        ) : Error404View(),
      )
    );
  }
}
