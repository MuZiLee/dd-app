
import 'package:one/Model/User.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/SBRequest/SBRequest.dart';
import 'package:one/utils/sp_util/sp_util.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platform/platform.dart';

class IM extends ChangeNotifier {
  static bool isLogin = false;
  JMSingle single;

  static String appkey = "f78b35c18acfa39733e6492d";

  static JMUserInfo jmUserInfo;
  static JPush jpush = new JPush();

  static MethodChannel channel = MethodChannel('jmessage_flutter');
  static JmessageFlutter jmessage =
      new JmessageFlutter.private(channel, const LocalPlatform());

  /// 监听-登录状态事件
  static bool isLogout = false;

  static init() async {
////    jpush.setup(appKey: appkey, production: false, channel: "jmessage_flutter");
//    jpush.setup(appKey: appkey, production: false, channel: "jmessage_flutter");
//    // 平台消息可能失败，因此我们使用 try/catch PlatformException.
//    jpush.getRegistrationID().then((rid) async{
//      print("【jpush】 getRegistrationID: $rid");
//      await updateRegistrationID();
//    });
    initPlatformState();

    jmessage..setDebugMode(enable: true);
    jmessage.init(
        isOpenMessageRoaming: true,
        appkey: appkey,
        isProduction: false,
        channel: "jmessage_flutter");
    jmessage.applyPushAuthority(
        new JMNotificationSettingsIOS(sound: true, alert: true, badge: true));

    jmessage.addLoginStateChangedListener((JMLoginStateChangedType type) async {
      if (type == JMLoginStateChangedType.user_logout) {
        if (!isLogout) {
          ZKCommonUtils.showToast("你的账号在别处登录");
          isLogout = true;
          await Account.logout();
        }
        print("------------ 强迫退出登录 ------------");
      }
    });

    print("【初始化jmessage完成】");

    SharedPreferences shared = await SharedPreferences.getInstance();
    String phone = shared.get("phone");
    await loginIM(phone: phone);

    /// 好友请求事件
    eventAddContactNotifyListener();
  }

  static loginIM({String phone}) async {
    isLogin = false;
    // 登录IM
    await channel.invokeMethod('login',
        {'username': phone, 'password': "123456789"}).then((value) async {
      print("IM登录成功");
      isLogin = true;
      Account.user.jmUserInfo = await jmessage.getMyInfo();
      print("IM用户数据:${Account.user.jmUserInfo.toJson()}");
    }).catchError((onError) async {
      print(onError.toString());
      if (onError?.code?.toString().contains("801003")) {
        await jmessage.userRegister(
            username: phone, password: "123456789", nickname: phone);
      } else if (onError.toString().contains("801003")) {
        await jmessage.userRegister(
            username: phone, password: "123456789", nickname: phone);
      }

      await loginIM(phone: phone);
    });
  }

  /**
   * 退出IM登录
   */
  static logout() async {
    await channel.invokeMethod('logout').then((value) async {
      print("IM退出登陆");
      isLogin = false;
      jmessage = null;
    }).catchError((onError) async {
      print("IM重试退出登陆");
      await logout();
    });
  }

  static updateRegistrationID() async {
    var url = "account/registrationID";

    String registrationID = await jpush.getRegistrationID();
    var arguments = {
      "registrationID": registrationID,
    };
    print(arguments);

    await SBRequest.post(url, arguments: arguments);
  }

  /// IM
  /// IM
  /// IM
  static JMTextMessage textMessage;

  static setTextMessageUnill() {
    textMessage = null;
  }

  static eventAddReceiveMessageListener(
      ValueChanged<JMTextMessage> textMessage) {
    print("监听消息");
    // 监听-消息事件
    // message 和 retractedMessage 可能是
    // JMTextMessage
    // JMVoiceMessage
    // JMImageMessage
    // JMFileMessage
    // JMEventMessage
    // JMCustomMessage;
    jmessage.addReceiveMessageListener((dynamic message) {
      //播放音效

      if (message.runtimeType.toString() == "JMTextMessage") {
        print("【JMTextMessage消息】");
        textMessage(message);
      } else if (message.runtimeType.toString() == "JMEventMessage") {
        print("【JMEventMessage消息】");
      } else if (message.runtimeType.toString() == "JMCustomMessage") {
        print("【JMCustomMessage消息】");
      }
    });
  }

  /// 监听-好友事件
  static eventAddContactNotifyListener() {
    jmessage.addContactNotifyListener((JMContactNotifyEvent event) async {
      if (event.type == JMContactNotifyType.invite_received) {
        ZKCommonUtils.showToast(event.reason);
        SharedPreferences shared = await SharedPreferences.getInstance();
        if (shared.get(event.fromUserName) == null) {
          JMUserInfo info = await jmessage.getUserInfo(
              username: event.fromUserName, appKey: appkey);

          //          shared.setString(event.fromUserName, jsonEncode(info.toJson()));

          /*1秒后出发本地推送*/
          sendLocalNotification(title: "【好友申请】", subtitle: "来自:${info.username}的好友申请", content: "您好，我们可以添加好友吗?");
        }
      }
    });
  }

  /// 获取好友申请
  static getFriendApply() {
    return SpUtil.getObject("addContactNotifyListener");
  }

  /// 获取所有会话记录
  static getConversations() async {
    List conversations = await jmessage.getConversations().catchError((error) {});
    for (JMConversationInfo _conversationInfo in conversations) {
      if (_conversationInfo.target.username == "10000") {
        conversations.remove(_conversationInfo);
      } else {
        User _user = await Account.getInfoByPhone(phone: _conversationInfo.target.username);
        _conversationInfo.extras = _user.toJson();
      }

    }
    return conversations;
  }

  /// 进入会话
  static JMConversationInfo conversationInfo;

  static Future<void> enterConversation({phone}) async {
    JMSingle kMockUser =
        JMSingle.fromJson({"username": phone, "appKey": appkey});

    conversationInfo = await getConversation(phone: phone);
    User _user = await Account.getInfoByPhone(phone: phone);
    conversationInfo.extras = _user.toJson();
    await jmessage.enterConversation(target: kMockUser);
    print("进入会话：${phone}");
    return;
  }

  /// 获取会话
  static Future<JMConversationInfo> getConversation({phone}) async {
    JMSingle kMockUser =
        JMSingle.fromJson({"username": phone, "appKey": appkey});
    return await jmessage
        .getConversation(target: kMockUser)
        .catchError((error) async {
      if (error.code == "2") {
        /// 如果获取不到会话就创建一个
        return await jmessage.createConversation(target: kMockUser);
      }
      return null;
    });
  }

  /// 退出会话
  static Future<void> exitConversation({phone}) async {
    JMSingle kMockUser =
        JMSingle.fromJson({"username": phone, "appKey": appkey});
    await jmessage.exitConversation(target: kMockUser);
    print("退出会话：${phone}");
    return;
  }

  /// 删除会话
  static Future<void> deleteConversation({phone}) async {
    JMSingle kMockUser =
        JMSingle.fromJson({"username": phone, "appKey": appkey});
    await jmessage.deleteConversation(target: kMockUser);
    return;
  }

  /// 获取历史会话消息
  static User tempuser;

  static getHistoryMessages({String phone, int from, int limit}) async {
    // isDescend: 是否降序（消息时间戳从大到小排序），默认为 false。 ​
    JMSingle kMockUser = JMSingle.fromJson({
      "username": phone,
      "appKey": appkey,
    });

    List<dynamic> messages = await jmessage
        .getHistoryMessages(
            type: kMockUser, from: from, limit: limit, isDescend: true)
        .catchError((error) {
      return [];
    });
    print(messages);
    List<JMTextMessage> res = [];
    for (JMTextMessage messageMap in messages) {
      if (messageMap.from.username != Account.user.phone) {
        JMUserInfo from = messageMap.from;
        if (tempuser == null || tempuser.phone != from.username) {
          tempuser = await Account.getInfoByPhone(phone: from.username);
          messageMap.from.extras = tempuser.toJson();
        }
        messageMap.from.extras = tempuser.toJson();
      }
      print(messageMap.toJson());
      res.add(messageMap);
    }

    return res;
  }

  /// 获取IM好友列表
  static Future<List<JMUserInfo>> getFriends() async {
    List<JMUserInfo> friends = await jmessage.getFriends();
    for (JMUserInfo userInfo in friends) {
      User _user = await Account.getInfoByPhone(phone: userInfo.username);
      userInfo.extras = _user.toJson();
    }
    return friends;
  }

  /// 关键字搜索用户
  static Future<List<User>> searchKeyword(keyword,
      {int page = 1, int limit = 15}) async {
    var url = "account/searchKeyword";
    var arguments = {"keyword": keyword, "page": page, "limit": limit};
    SBResponse response = await SBRequest.post(url, arguments: arguments);
    List<User> users = [];
    for (Map obj in response.data) {
      User _user = User.fromJson(obj);
      if (_user.phone != Account.user.phone) {
        users.add(_user);
      }
    }
    return users;
  }

  /// 好友申请
  static addFriend({String phone}) async {
    await jmessage
        .sendInvitationRequest(username: phone, appKey: appkey, reason: "申请好友")
        .then((action) async {
      ZKCommonUtils.showToast("申请已发送");
    }).catchError((error) {
      if (error.code == "805002") {
        ZKCommonUtils.showToast("已经是好友");
      } else if (error.code == "871317") {
        ZKCommonUtils.showToast("不能添加自己为好友");
      } else {
        ZKCommonUtils.showToast("申请发送失败");
      }
    });
  }

  /// 同意好友申请
  static Future<void> acceptInvitation({phone}) async {
    return await jmessage
        .acceptInvitation(username: phone, appKey: appkey)
        .then((value) async {
      Map _users = SpUtil.getObject("addContactNotifyListener");
      _users.remove(phone);
      await SpUtil.putObject("addContactNotifyListener", _users);
      return;
    }).catchError((error) async {
      return;
    });
  }

  /// 拒绝申请好友
  static Future<void> declineInvitation({phone}) async {
//    return await jmessage.declineInvitation(username: phone, appKey: appkey, reason: "拒绝申请好友").then((value) async{
//      Map _users = SpUtil.getObject("addContactNotifyListener");
//      _users.remove(phone);
//      await SpUtil.putObject("addContactNotifyListener", _users);
//      return;
//    }).catchError((error) async{
//      return;
//    });
    Map _users = SpUtil.getObject("addContactNotifyListener");
    _users.remove(phone);
    await SpUtil.putObject("addContactNotifyListener", _users);
    return;
  }

  /// 删除好友
  static Future<void> removeFromFriendList({phone}) async {
    await jmessage
        .removeFromFriendList(username: phone, appKey: appkey)
        .catchError((error) {
      return;
    });

    return;
  }

  /// 发送文本消息
  static Future<JMTextMessage> sendTextMessage(
      {String phone, String text}) async {
    JMSingle kMockUser = JMSingle.fromJson({
      "username": phone,
      "appKey": appkey,
    });
    JMMessageSendOptions sendOption = JMMessageSendOptions.fromJson({
      /// 接收方是否针对此次消息发送展示通知栏通知。
      /// @defaultvalue
      "isShowNotification": true,

      ///  是否让后台在对方不在线时保存这条离线消息，等到对方上线后再推送给对方。
      ///  @defaultvalue
      "isRetainOffline": true,
      "isCustomNotificationEnabled": false,

      /// 设置此条消息在接收方通知栏所展示通知的标题。
      "notificationTitle": Account.user.username,

      /// 设置此条消息在接收方通知栏所展示通知的内容。
      "notificationText": text,

      /// 设置这条消息的发送是否需要对方发送已读回执，false，默认值
      "needReadReceipt": false
    });
    JMTextMessage message = await jmessage.sendTextMessage(
        type: kMockUser,
        text: text,
        sendOption: sendOption,
        extras: Account.user.toJson());
    return message;
  }

// Platform messages are asynchronous, so we initialize in an async method.
  static Future<void> initPlatformState() async {
    String platformVersion;

    try {
      jpush.addEventHandler(onReceiveNotification: (Map<String, dynamic> message) async {
        print("接收到前台通知: $message");
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("点击通知: $message");
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("接收到后台通知: $message");
      }, onReceiveNotificationAuthorization: (Map<String, dynamic> message) async {
        // 通知授权
        print("flutter onReceiveNotificationAuthorization: $message");
      });
    } on PlatformException {
      platformVersion = '获取平台版本失败.';
    }

    jpush.setup(
      appKey: appkey,
      channel: "jmessage_flutter",
      production: false,
      debug: true,
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) async {
      print("flutter get registration id : $rid");
      await updateRegistrationID();
    });
  }

  /**
   * 发送本地通过
   */
  static sendLocalNotification(
      {String title = "", String subtitle = "", String content = ""}) async {
    var fireDate = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch + 3000);
    var localNotification = LocalNotification(
        id: 234,
        title: title,
        buildId: 1,
        content: content,
        fireTime: fireDate,
        subtitle: subtitle,
        badge: 5,
        extra: {"fa": "0"});
    jpush.sendLocalNotification(localNotification).then((res) {});
  }
}
