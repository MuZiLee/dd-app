import 'dart:async';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/IM.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/Views/keyboard/BlankToolBarTool.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:provider/provider.dart';

/// 聊天界面
class ConversationViewController extends StatefulWidget {
  static String routeName = "/chat/conversation";

  String phone;
  ConversationViewController(this.phone);

  @override
  _ConversationViewControllerState createState() => _ConversationViewControllerState();
}

class _ConversationViewControllerState extends State<ConversationViewController> {

  JMConversationInfo conversationInfo;
  /// 用户账号

  // 信息列表
  List<JMTextMessage> messages = [];
  int from = 0;
  User userInfo;



  /// 上拉刷新
  Future<void> _onRefresh() async {

    messages = await IM.getHistoryMessages(phone: widget.phone, from: 0, limit: 15);
    if (userInfo == null) {
      userInfo = await Account.getInfoByPhone(phone: widget.phone);
    }
    from = messages.length;
    _easyRefreshController.finishRefresh();
    IM.setTextMessageUnill();
    setState(() {
    });
  }

  /// 下拉加载更多
  Future<void> _onLoad() async {
    List<JMTextMessage> msgs = await IM.getHistoryMessages(phone: widget.phone, from: from, limit: 15);
    _easyRefreshController.finishLoad();

    if (msgs.length > 0) {
      messages.addAll(msgs);
      from = from + msgs.length;
      setState(() {

      });
    } else {
      ZKCommonUtils.showToast("没有更多消息");
    }
  }

  // 输入框
  TextEditingController _textEditingController = TextEditingController();
  // 滚动控制器
  ScrollController _scrollController = ScrollController();
  EasyRefreshController _easyRefreshController = EasyRefreshController();
  BlankToolBarModel blankToolBarModel = BlankToolBarModel();


  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _scrollController.dispose();
  }



  // 发送消息
  void _sendMsg(String msg) async{
    JMTextMessage message = await IM.sendTextMessage(phone: widget.phone, text: msg);
    setState(() {
      messages.insert(0, message);
    });
    _scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.linear);
  }


  @override
  Widget build(BuildContext context) {

    conversationInfo = IM.conversationInfo;
    JMTextMessage textMessage = IM.textMessage;
    if (textMessage != null) {
      print("【JMTextMessage消息】");
      IM.setTextMessageUnill();
//      messages.insert(0, textMessage);
      _onRefresh();
    }


    return BlankToolBarTool.blankToolBarWidget(context,
        model: blankToolBarModel,
        body: BaseScaffold(
            title: userInfo?.username != null ? userInfo?.username : "",
            color: Colors.grey[200],
            elevation: 0.0,
//            actions: <Widget>[
//              IconButton(
//                icon: Icon(Icons.more_horiz),
//                onPressed: () {
//
//
//                },
//              ),
//            ],
//            child: Consumer<AccountProvider>(builder: (ctx, AccountProvider account, val) {
//              if (account.textMessage != null) {
//                print("【JMTextMessage消息】");
//                JMTextMessage msg = account.textMessage;
//                account.textMessage = null;
//                setState(() {
//                  messages.insert(0, msg);
//                });
//              }

              child: _buildColumn()
//            })
        ),
    );
  }

  _buildColumn() {
    return Column(
      children: <Widget>[
        Divider(
          height: 0.5,
        ),
        Expanded(
          flex: 1,
          child: CupertinoScrollbar(
            child: _layoutBuilder(),
          ),
        ),
        SafeArea(
          child: Container(
            color: Colors.grey[100],
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 5.0,
                      right: 5.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(
                        4.0,
                      )),
                    ),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: null,
                      onChanged: (value) {
                        setState(() {

                        });
                      },
                      onSubmitted: (value) {
                        if (_textEditingController.text.isNotEmpty) {
                          _sendMsg(_textEditingController.text);
                          _textEditingController.text = '';
                        }
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_textEditingController.text.isNotEmpty) {
                      _sendMsg(_textEditingController.text);
                      _textEditingController.text = '';
                    }
                  },
                  child: Container(
                    height: 30.0,
                    width: 60.0,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: 15.0,
                    ),
                    decoration: BoxDecoration(
                      color: _textEditingController.text.isEmpty
                          ? Colors.grey
                          : Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(
                        4.0,
                      )),
                    ),
                    child: Text(
                      "发送",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  LayoutBuilder _layoutBuilder() {
    return LayoutBuilder(
          builder: (context, constraints) {
            // 判断列表内容是否大于展示区域
            bool overflow = false;
            double heightTmp = 0.0;
            for (JMTextMessage entity in messages) {
              heightTmp += _calculateMsgHeight(context, constraints, entity);
              if (heightTmp > constraints.maxHeight) {
                overflow = true;
              }
            }
            return EasyRefresh.custom(
              scrollController: _scrollController,
              reverse: true,
              onRefresh: _onRefresh,
              onLoad: _onLoad,
              controller: _easyRefreshController,
              enableControlFinishRefresh: true,
              enableControlFinishLoad: true,
              footer: CustomFooter(
                  enableInfiniteLoad: false,
                  extent: 40.0,
                  triggerDistance: 50.0,
                  footerBuilder: (context,
                      loadState,
                      pulledExtent,
                      loadTriggerPullDistance,
                      loadIndicatorExtent,
                      axisDirection,
                      float,
                      completeDuration,
                      enableInfiniteLoad,
                      success,
                      noMore) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            width: 30.0,
                            height: 30.0,
                            child: SpinKitCircle(
                              color: Colors.green,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
              header: CustomHeader(
                  enableInfiniteRefresh: false,
                  extent: 40.0,
                  triggerDistance: 50.0,
                  headerBuilder: (context,
                      loadState,
                      pulledExtent,
                      loadTriggerPullDistance,
                      loadIndicatorExtent,
                      axisDirection,
                      float,
                      completeDuration,
                      enableInfiniteLoad,
                      success,
                      noMore) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            width: 30.0,
                            height: 30.0,
                            child: SpinKitCircle(
                              color: Colors.green,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              ),
              firstRefresh: true,
              slivers: <Widget>[
                if (overflow)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return _buildMsg(messages[index]);
                      },
                      childCount: messages.length,
                    ),
                  ),
                if (!overflow)
                  SliverToBoxAdapter(
                    child: Container(
                      height: constraints.maxHeight,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          for (JMTextMessage entity in messages.reversed)
                            _buildMsg(entity),
                        ],
                      ),
                    ),
                  ),
              ],

            );
          },
        );
  }

  /// 构建消息视图
  Widget _buildMsg(JMTextMessage entity) {
    if (entity == null || entity.isSend == null) {
      return Container();
    }
    if (entity.isSend) {
      return Container(
        margin: EdgeInsets.all(
          10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "我",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 5.0,
                  ),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(
                      4.0,
                    )),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: 200.0,
                  ),
                  child: Text(
                    entity.text ?? '',
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                )
              ],
            ),
            Card(
              margin: EdgeInsets.only(
                left: 10.0,
              ),
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              elevation: 0.0,
              child: Container(
                height: 40.0,
                width: 40.0,
                child: SBImage(
                  url: Account.user?.avatar
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(
          10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(
                right: 10.0,
              ),
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              elevation: 0.0,
              child: Container(
                height: 40.0,
                width: 40.0,
                child: SBImage(
                  url: entity.from.extras["avatar"],

                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entity.from.extras.length > 0 ? entity.from.extras["username"] : "",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 5.0,
                  ),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(
                      4.0,
                    )),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: 200.0,
                  ),
                  child: Text(
                    entity.text ?? '',
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }
  }

  /// 计算内容的高度
  double _calculateMsgHeight(BuildContext context, BoxConstraints constraints, JMTextMessage entity) {
    return 45.0 +
        _calculateTextHeight(
          context,
          constraints,
          text: '我',
          textStyle: TextStyle(
            fontSize: 13.0,
          ),
        ) +
        _calculateTextHeight(
          context,
          constraints.copyWith(
            maxWidth: 200.0,
          ),
          text: entity.text ?? '',
          textStyle: TextStyle(
            fontSize: 16.0,
          ),
        );
  }

  /// 计算Text的高度
  double _calculateTextHeight(
      BuildContext context,
      BoxConstraints constraints, {
        String text = '',
        @required TextStyle textStyle,
        List<InlineSpan> children = const [],
      }) {
    final span = TextSpan(text: text, style: textStyle, children: children);

    final richTextWidget = Text.rich(span).build(context) as RichText;
    final renderObject = richTextWidget.createRenderObject(context);
    renderObject.layout(constraints);
    return renderObject.computeMinIntrinsicHeight(constraints.maxWidth);
  }

  @override
  void deactivate() async{
    // TODO: implement deactivate
    await IM.exitConversation(phone: widget.phone);
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    IM.eventAddReceiveMessageListener((JMTextMessage message) async{
      setState(() {

      });
    });
  }
}

