

import 'package:demo2020/Model/FriendsModel.dart';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardChatTableViewCell.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
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

  _onRefresh() async{
    users = [];

//     IM.getFriendApply().forEach((key, value) {
//
//
// //      users.add(JMUserInfo.fromJson(value));
//     });
    users = await Account.getFriends();
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
            FriendsModel model = users[index];

            return CardChatTableViewCell(
              title: model.user.username,
              subTitle: model.user.phone,
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
              ),
              onTap: () => _onTap(model),
            );
          },
        ) : Error404View(),
      ),
    );
  }

  _onTap(FriendsModel model) async{

    CardShowActionSheetController(
      context,
      title: "好友申请处理",
      subtitle: "请选择你的操作",
      actions: [
        CupertinoActionSheetAction(
            child: Text('拒绝', style: TextStyle(fontSize: 14)),
            onPressed: () {
              _onPressed(false, model: model);
              Navigator.pop(context);
            }
        ),
        CupertinoActionSheetAction(
            child: Text('同意', style: TextStyle(fontSize: 14)),
            onPressed: () {
              _onPressed(true, model: model);
              Navigator.pop(context);
            }
        ),
      ]
    );
  }

  _onPressed(bool event, {FriendsModel model}) async {

    if (event == true) {
      /// 同意
      await IM.acceptInvitation(phone: model.user.phone);
      await Account.acceptInvitation(model: model);
    } else {
      /// 拒绝
      await IM.removeFromFriendList(phone: model.user.phone);
      await Account.declineInvitation(model: model);
    }
    _onRefresh();
  }

}
