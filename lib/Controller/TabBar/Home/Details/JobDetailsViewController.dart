//
//  文件名：JobDetailsViewController
//  所在包名：Controller.Home.JobDetails
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-10
//  版权所有 © 2019。 保留所有权利
//

import 'package:one/Controller/TabBar/Chat/ConversationViewController.dart';
import 'package:one/Controller/TabBar/Me/BoundInvitationCode/BoundInvitationCodeViewController.dart';
import 'package:one/Model/JobModel.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/FactoryManager.dart';
import 'package:one/Provider/FavoritesManager.dart';
import 'package:one/Provider/IM.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/config.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:sharesdk_plugin/sharesdk_defines.dart';
import 'package:sharesdk_plugin/sharesdk_interface.dart';
import 'package:sharesdk_plugin/sharesdk_map.dart';
import 'package:webview_flutter/webview_flutter.dart';

class JobDetailsViewController extends StatefulWidget {
  static const routeName = "/home/JobDetails";

  JobModel job;
  JobDetailsViewController({this.job});

  @override
  _JobDetailsViewControllerState createState() => _JobDetailsViewControllerState();
}

class _JobDetailsViewControllerState extends State<JobDetailsViewController> {

  bool isVisible = true;

  bool isFavoritJob = true;

  @override
  Widget build(BuildContext context) {


    //http://192.168.1.101/share/detailJob.html?id=25  ///职位详情
    //http://192.168.1.101/share/?id=25   ///分享的职位

    var url = Config.BASE_URL + "/share/detailJob.html?id=${widget.job.id}";
//    var url = "http://192.168.1.200/share/detailJob.html?id=${model.id}";

    return BaseScaffold(
      title: widget.job.job_name,
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: RaisedButton.icon(
            color: isFavoritJob == true ? Colors.deepOrangeAccent : Colors.white,
            icon: Icon(isFavoritJob == true ? Icons.star_border : Icons.star,
                color: isFavoritJob == true ? Colors.white : Colors.deepOrangeAccent, size: 21),
            label: Text(isFavoritJob == true ? "收藏" : "已收藏",
                style: TextStyle(fontSize: 14,color: isFavoritJob == true ? Colors.white : Colors.deepOrangeAccent)),
            onPressed: () {
              /// 收藏
              if (isFavoritJob == true) {
                //未收藏
                addFavorites();
              } else {
                //已收藏
                deleteFavorit();
              }
            },
          ),
        ),
        SizedBox(width: 20.0),
      ],
      child: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true,
        userAgent: "User-Agent:Android",
        onPageFinished: (String url) {
          print('页面完成加载: $url');
          eventExist();
          selectFavorites();
        },
      ),
      floatingActionButton: isVisible == false ? null : floatingActionButton(context),
      bottomNavigationBar: Container(
        height: 51,
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Container(
                  height: 51.0,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.share, size: 21.0, color: topColor),
                      Text("分享", style: TextStyle(fontSize: 14.0, color: topColor)),
                      Text("(5蛋币)", style: TextStyle(fontSize: 12.0, color: Colors.white))
                    ],
                  ),
                ),
                onTap: () {
                  shareToWechat(context);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 51.0,
                color: Colors.deepOrangeAccent,
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.chat,
                          color: Colors.white, size: 21.0),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text("咨询经纪人",
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.white))
                    ],
                  ),
                  onTap: () async{
                    if (Account.user.partner == null) {
                      ZKCommonUtils.showToast("请先验证邀请码");
                      routePush(BoundInvitationCodeViewController());
                      return;
                    }

                    setConversationExtras(Account.user.partner.user.phone);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 报名事件
  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      child: Text('报名', style: TextStyle(color: Colors.white)),
      onPressed: () {
        if (Account.user.partner == null) {
          ZKCommonUtils.showToast("请输入邀请码");
          routePush(BoundInvitationCodeViewController());
          return;
        } else {
          jobApply();
        }
      },
    );
  }

  /// 会话
  setConversationExtras(String phone) async {

    // 进入会话
    if (IM.isLogin == false) {
      ZKCommonUtils.showToast("正在链接,请稍候再试");
      return;
    }
    routePush(ConversationViewController(phone)).then((value){
      Navigator.pop(context);
    });
  }

  void shareToWechat(BuildContext context) {
    if (widget.job == null) {
      return;
    }

    showModalBottomSheet(context: context, builder: (BuildContext context){

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[

              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                color: Colors.white,
                child: FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("images/home/wechatfriend.png", width:38, height: 38),
                      Text("微信好友", style: TextStyle(fontSize: 12))
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    /// 微信好友
                    shareWechatAlert(0);
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                color: Colors.white,
                child: FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("images/home/wechatCircle.png", width: 38, height: 38),
                      Text("微信朋友圈", style: TextStyle(fontSize: 12))
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    /// 微信朋友圈
                    shareWechatAlert(1);
                  },
                ),
              ),

            ],
          )
        ],
      );

    });

  }

  /// 分享
  void shareWechatAlert(int type) {

    SSDKMap params = SSDKMap();

    var url = "http://47.105.72.106/share/?id=${widget.job.id}";

    if (Account.user.username == null) {
      ZKCommonUtils.showToast("请先完善个人信息");
      return;
    }

    var title = "${widget.job.factory.factory_name} 火力全开地招人啦~! 快去看看吧~！机不可失啊~!";
    var text = "地址:${widget.job.factory.addres}\n来自${Account.user.username}的分享";
    List images = [widget.job.factory.logo];
    var imageUrl = widget.job.factory.logo;

    params.setWechat(
        text: text,
        title: title,
        url: url,
        thumbImage: null,
        images: images,
        musicFileURL: null,
        extInfo: null,
        imageUrl: imageUrl,
        imageData: "/storage/emulated/0/Mob/cn.sharesdk.demo/cache/images/aa.jpg",
        fileData: null,
        emoticonData: null,
        fileExtension: null,
        sourceFileData: null,
        contentType: SSDKContentTypes.webpage,
        subPlatform: ShareSDKPlatforms.weChatFavorites);

    params.setGeneral(
        title: title,
        text: text,
        images: images,
        imageUrlAndroid: null,
        imagePathAndroid: null,
        url: url,
        titleUrlAndroid: null,
        musicUrlAndroid: null,
        videoUrlAndroid: null,
        filePath: null,
        contentType: SSDKContentTypes.webpage);


    if (type == 0) {
      SharesdkPlugin.share(ShareSDKPlatforms.wechatSession, params, (SSDKResponseState, Map userData, Map contentEntity, SSDKError){

      });
    }

    if (type == 1) {
      SharesdkPlugin.share(ShareSDKPlatforms.wechatTimeline, params, (SSDKResponseState, Map userData, Map contentEntity, SSDKError onError){


      });

    }


  }

  /// 添加收藏
  addFavorites() async{

     await FavoritesManager.add(type: 2, title: widget.job.job_name, subtitle: widget.job.factory.factory_name, cid: widget.job.id, image: widget.job.factory.logo);
     await selectFavorites();
  }

  /// 查询是否收藏过
  selectFavorites() async{

    isFavoritJob = await FavoritesManager.isFavorites(type: 2, cid: widget.job.id);
    setState(() {

    });
  }

  /// 删除收藏
  deleteFavorit() async{

    await FavoritesManager.del(type: 2, cid: widget.job.id);
    await selectFavorites();
  }

  /// 查询职位是否已报名
  eventExist() async{
    isVisible = await FactoryManager.isApply(jid: widget.job.id);
    setState((){});
  }


  /// 职位报名
  jobApply() async{

    var status = await FactoryManager.apply(jid: widget.job.id, fid: widget.job.factory.id);
     if (status == true) {
       eventExist();
     }
  }



}
