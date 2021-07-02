

import 'package:one/Provider/IM.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/CardSeries/CardChatTableViewCell.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/CardSeries/CardRefresherListView.dart';
import 'package:one/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:provider/provider.dart';

class FriendApplyListViewController extends StatefulWidget {
  static String routeName = "/chat/friendApplyList";

  @override
  _FriendApplyListViewControllerState createState() => _FriendApplyListViewControllerState();
}

class _FriendApplyListViewControllerState extends State<FriendApplyListViewController> {

  List users = [];

  _onRefresh() {
    users = [];

    IM.getFriendApply().forEach((key, value) {


//      users.add(JMUserInfo.fromJson(value));
    });
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "好友申请",
      elevation: 0.0,
      child: CardRefresher(
        onRefresh: _onRefresh,
        child: users.length > 0 ? CardRefresherListView(
          itemCount: users.length,
          itemBuilder: (_, index) {
            JMUserInfo userInfo = users[index];

            return CardChatTableViewCell(
              title: userInfo.nickname,
              subTitle: userInfo.username,
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
              ),
              onTap: () => _onTap(userInfo),
            );
          },
        ) : Error404View(),
      ),
    );
  }

  _onTap(JMUserInfo userInfo) async{

    CardShowActionSheetController(
      context,
      title: "好友申请处理",
      subtitle: "请选择你的操作",
      actions: [
        CupertinoActionSheetAction(
            child: Text('拒绝', style: TextStyle(fontSize: 14)),
            onPressed: () {
              _onPressed(false, userInfo: userInfo);
              Navigator.pop(context);
            }
        ),
        CupertinoActionSheetAction(
            child: Text('同意', style: TextStyle(fontSize: 14)),
            onPressed: () {
              _onPressed(true, userInfo: userInfo);
              Navigator.pop(context);
            }
        ),
      ]
    );
  }

  _onPressed(bool event, {JMUserInfo userInfo}) async {

    if (event == true) {
      /// 同意
      await IM.acceptInvitation(phone: userInfo.username);
    } else {
      /// 拒绝
      await IM.declineInvitation(phone: userInfo.username);
    }
    _onRefresh();
  }

}
