
import 'package:common_utils/common_utils.dart';
import 'package:demo2020/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:demo2020/Controller/TabBar/Chat/FriendsViewController.dart';
import 'package:demo2020/Controller/TabBar/Chat/SearchUserViewController.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardChatTableViewCell.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatViewController extends StatefulWidget {
  @override
  _ChatViewControllerState createState() => _ChatViewControllerState();
}

class _ChatViewControllerState extends State<ChatViewController> {

  RefreshController refreshController = RefreshController(initialRefresh: true);
  static List conversations = [];
  double actionExtentRatio = 0.25;
  int indexPath;

  _onRefresh() async {
    if (IM.isLogin == true) {
      conversations = await IM.getConversations();
    }
    refreshController.refreshFailed();
    if (conversations.length > 0) {
      if (this != null) {
        setState(() {

        });
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (IM.isLogin == true) {
      await IM.eventAddReceiveMessageListener((JMTextMessage messge) async{
        conversations = await IM.getConversations();
        setState(() {

        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "??????",
      elevation: 0.0,
      actions: <Widget>[
        Container(
          width: 49,
          child: FlatButton(
            child: Icon(Icons.people),
            onPressed: () {
              /// ????????????

              routePush(FriendsViewController()).then((value) async{
                await _onRefresh();
              });
            },
          ),
        ),
        Container(
          width: 49,
          child: FlatButton(
            child: Icon(Icons.add),
            onPressed: () {
              /// ????????????
              routePush(SearchUserViewController());
            },
          ),
        ),
      ],
      child: CupertinoScrollbar(
        child: CardRefresher(
          onRefresh: _onRefresh,
          refreshController: refreshController,
          child: conversations.length > 0 ? CardRefresherListView(
            itemCount: conversations.length,
            itemBuilder: (_, index) {
              JMConversationInfo conversationInfo = conversations[index];
              JMUserInfo userInfo = conversationInfo.target;
              JMTextMessage message = conversationInfo.latestMessage;

              String timestamp = "";
              if (message != null) {
                DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(message.createTime-1000);
                timestamp = TimelineUtil.formatByDateTime(dateTime, locale: 'zh').toString();
              }

              return Slidable(
                actionPane: SlidableScrollActionPane(),
                actionExtentRatio: 0.25,
                closeOnScroll: false,
                secondaryActions: [
                  IconSlideAction(
                    caption: '??????',
                    color: Colors.deepOrangeAccent,
                    icon: Icons.delete,
                    closeOnTap: true,
                    onTap: () async{

                      await IM.deleteConversation(phone: userInfo.username);
                      setState(() {
                        actionExtentRatio = 0.0;
                        indexPath = index;
                        conversations.removeAt(index);
                      });
                    },
                  ),
                ],
                child: CardChatTableViewCell(
                  avatar: conversationInfo.extras["avatar"],
                  title: conversationInfo.extras["username"],
                  subTitle: message == null ? "" : message.text,
                  trailing: Container(
                    height: 48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(timestamp, style: TextStyle(fontSize: 8, color: Colors.grey))
                      ],
                    ),
                  ),
                  onTap: () async {
                    /// ????????????
                    if (IM.isLogin == false) {
                      ZKCommonUtils.showToast("????????????,???????????????");
                      return;
                    }
                    await IM.enterConversation(phone: userInfo.username);
                    routePush(ConversationViewController(userInfo.username)).then((value){
                      _onRefresh();
                    });


                  },
                ),
              );

            },
          ) : Error404View(text: IM.isLogin == false ? "????????????..." : "????????????"),
        ),
      ),
    );
  }

}
