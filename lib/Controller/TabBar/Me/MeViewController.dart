
import 'package:demo2020/Controller/TabBar/Me/BoundInvitationCode/BoundInvitationCodeViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/MyQRCode.dart';
import 'package:demo2020/Controller/TabBar/Me/Personal/PersonalInfoViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Preferences/PreferencesViewController.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Views/CardSeries/CardHeaderTip.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/TouchCallback.dart';
import 'package:demo2020/CellItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MeViewController extends StatefulWidget {
  @override
  _MeViewControllerState createState() => _MeViewControllerState();
}

class _MeViewControllerState extends State<MeViewController> {

  RefreshController refreshController = RefreshController(initialRefresh: true);
  bool visibleInvitationCode = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        color: Colors.white,
        child: TouchCallBack(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 12.0, right: 15.0),
                child: SizedBox(
                  width: 68, height: 68,
                  child: SBImage(
                    url: Account.user.avatar,
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Account.user?.username,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFF353535),
                      ),
                    ),
                    Text(
                      Account.user?.phone,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFFa9a9a9),
                      ),
                    ),
                  ],
                ),
              ),
              Account.user.owned.contains(Account.junior_partner) ? InkWell(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(left: 12.0, right: 20.0),
                  child: SizedBox(
                    width: 32,height: 32,
                    child: Image.asset("images/member/binding.png"),
                  ),
                ),
                onTap: () {
                  if (Account.user.code != 0){
                    routePush(MyQRCode());
                    return;
                  }
                  routePush(BoundInvitationCodeViewController());
                },
              ) : Container(),
            ],
          ),
          onPressed: () {
            routePush(PersonalInfoViewController()).then((value) {
              setState(() {

              });
            });
          },
        ),
      ),


    ];


    /// 钱包
    children.add(Container(
      margin: const EdgeInsets.only(top: 20.0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          CellItem(imagePath: 'images/member/wallet.png', title: '钱包'),
        ],
      ),
    ));


    /**
     * 基础服务
     */
    var c = [
      CardHeaderTip("基础服务"),
      CellItem(imagePath: 'images/member/collect.png', title: '收藏'),
      CellItem(imagePath: 'images/member/resume.png', title: '简历'),
    ];
    if (!Account.user.owned.contains(Account.member)) {
      c.add(CellItem(imagePath: 'images/member/binding.png', title: '绑定邀请码'));
    }
    children.add(Container(
      margin: const EdgeInsets.only(top: 20.0),
      color: Colors.white,
      child: Column(
        children: c,
      ),
    ));

    print("当前角色:${Account.user.owned.toString()}");

    /**
     * 会员服务
     */
    if (Account.user.owned.contains(Account.member)) {
      var c = [
        CardHeaderTip("会员服务"),
        CellItem(imagePath:'images/profile_pressed.png',title: '我的经纪人', subtitle: Account.user.partner.user.username),
      ];

      int owned = 0;
      Account.user.owned.map((element) {

        if (element == Account.junior_partner) {
          owned = owned +1;
        }
        if (element == Account.senior_partner) {
          owned = owned +1;
        }
        if (element == Account.strategic_alliance) {
          owned = owned +1;
        }
        if (element == Account.salesman) {
          owned = owned +1;
        }
      }).toList();
      c.add(CellItem(imagePath:'images/icon_search.png',title: '事件处理'));

      if (owned != 4) {
        c.add(CellItem(imagePath:'images/icon_public.png',title: '合伙人申请'));
      }
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: c,
        ),
      ));
    }

    /**
     * 工人
     */
    if (Account.user?.owned.contains(Account.worker) && Account.user?.staff != null) {

      List<Widget> childes = [];

      children.add(CardHeaderTip("员工服务"));
      if (Account.user?.staff.sigingInformation.cooperation_mode != "代理招聘") {
        childes.add(CellItem(imagePath:'images/member/reimbursement.png',title: '工资预算', subtitle: "通过打卡记录预算"));
      }
    childes.add(CellItem(imagePath:'images/member/workflow.png',title: '历史记录', subtitle: "工作流记录"));
    childes.add(CellItem(imagePath:'images/member/word.png',title: '工作流', subtitle: Account.user?.staff?.factory?.factory_name != null ? Account.user?.staff?.factory?.factory_name : "",));


    children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: childes,
        ),
      ));
    }

    /**
     * 合伙人
     */
    if (Account.user.owned.contains(Account.junior_partner)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CardHeaderTip("合伙人"),
            CellItem(imagePath: 'images/member/binding.png', title: '我的邀请码', subtitle: Account.user.code != 0 ? Account.user.code.toString() : "",),
            CellItem(imagePath:'images/icon_look.png',title: '合伙人服务'),
          ],
        ),
      ));
    }

    /**
     * 驻场老师
     */
    if (Account.user.owned.contains(Account.resident_teacher)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CardHeaderTip("驻场老师"),
            CellItem(imagePath:'images/member/teacher.png',title: '工厂管理', subtitle: Account.user.teachers.length.toString()+"家工厂",),
            CellItem(imagePath:'images/icon_me_collect.png',title: '驻场老师提成'),

          ],
        ),
      ));
    }

    /**
     * 工厂HR
     */
    if (Account.user.owned.contains(Account.factory_hr)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CardHeaderTip("工厂HR"),
            CellItem(imagePath:'images/member/factory.png',title: '工厂HR服务', subtitle: Account.user.teachers.length.toString()+"家工厂",),
          ],
        ),
      ));
    }

    /**
     * 业务员
     */
    if (Account.user.owned.contains(Account.salesman)) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CardHeaderTip("业务员"),
            CellItem(imagePath:'images/icon_link.png',title: '业务员服务'),
          ],
        ),
      ));
    }

    List<Widget> actions = [
      Container(
        width: 60.0,
        child: TouchCallBack(
            child: Container(
                margin: EdgeInsets.all(15.0),
                child: Image.asset(
                  "images/member/preferences.png",
                  width: 18,
                  height: 18,
                )),
            onPressed: () {
              routePush(PreferencesViewController());
            }),
      )
    ];

    return BaseScaffold(
      title: "我的",
      actions: actions,
      child: CardRefresher(
        refreshController: refreshController,
        header: MaterialClassicHeader(),
        onRefresh: () async{
          refreshController.refreshFailed();
          await Account.getUserInfo();
          setState(() {

          });
        },
        child: CardRefresherListView(
          itemBuilder: (_, index) {
            return children[index];
          },
          itemCount: children.length,
        ),
      ),
    );
  }




}
