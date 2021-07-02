import 'package:demo2020/Model/JobModel.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/EventsManager.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesCity.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesHeader.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesNumber.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesText.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesTextView.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/Views/card_settings/widgets/card_settings_panel.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/material.dart';

/// 申请
class ApplyRolesViewController extends StatefulWidget {
  static const routeName = "/me/applyRoles";

  String appleByUsable = "";

  ApplyRolesViewController({this.appleByUsable});

  @override
  _ApplyRolesViewControllerState createState() =>
      _ApplyRolesViewControllerState();
}

class _ApplyRolesViewControllerState extends State<ApplyRolesViewController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.appleByUsable,
      child: buildCardSettings(),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            child: Text("申请"),
            color: selectedIconColor,
            textColor: topColor,
            onPressed: buildSublimeButtonAction,
          ),
        ),
      ],
    );
  }

  Factory selectFactory;

  String province = "省";
  String city = "市";
  String county = "区/县/镇";
  String remark = "无";

  String address = "";
  String enterpriseName = "";
  String sos_name = "";
  String sos_phone = "";

  buildCardSettings() {
    List<Widget> children = [];

    children.add(CardViewSeriesHeader(
      title: "*请填写信息真实",
    ));
    children.add(CardViewSeriesText(
      title: "申请类型",
      subtitle: widget.appleByUsable.substring(2, widget.appleByUsable.length),
      enabled: false,
    ));

    // 申请战略联盟
    if (widget.appleByUsable == "战略联盟申请") {
      children.add(CardViewSeriesText(
        title: "公司名称",
        placeholder: "请输入公司全称",
        isNotNull: true,
        onChanged: (value) => enterpriseName = value,
      ));
    }

    children.add(CardViewSeriesText(
        title: "申请人",
        placeholder: "申请人姓名",
        enabled: false,
        subtitle: Account.user.username));

    children.add(CardViewSeriesNumber(
      title: "手机号",
      enabled: false,
      placeholder: "11位手机号码",
      maxLength: 11,
      subtitle: Account.user.phone,
    ));

    children.add(CardViewSeriesCity(
        title: "地区",
        isNotNull: true,
        subtitle: "${province} ${city} ${county}",
        initialProvince: province,
        initialCity: city,
        initialTown: county,
        onConfirm: (p, c, t) {
          province = p;
          city = c;
          county = t;
        }));

    if (widget.appleByUsable == "战略联盟申请") {
      children.add(CardViewSeriesText(
        title: "详细地址",
        isNotNull: true,
        placeholder: "街道/门牌号",
        onChanged: (value) => address = value,
      ));
      children.add(CardViewSeriesText(
        title: "紧急联系人",
        isNotNull: true,
        placeholder: "请输入紧急联系人",
        onChanged: (value) => sos_name = value,
      ));
      children.add(CardViewSeriesText(
        title: "紧急联系人电话",
        isNotNull: true,
        placeholder: "+86",
        onChanged: (value) => sos_phone = value,
      ));
    }

    children.add(CardViewSeriesTextView(
        title: "申请原因",
        isNotNull: true,
        valueChanged: (value) {
          print(value);
          remark = value;
        }));

    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  buildSublimeButtonAction() async {
    var eid = EventsManager.junior_partner_application;
    var rid = Account.user.owned.last;

    if (widget.appleByUsable == "初级合伙人申请") {
      eid = EventsManager.junior_partner_application;
    } else if (widget.appleByUsable == "高级合伙人申请") {
      eid = EventsManager.senior_partner_application;
      if (!Account.user.owned.contains(Account.junior_partner)) {
        ZKCommonUtils.showToast("请等初级合伙人审核通过");
        return;
      }
    } else if (widget.appleByUsable == "战略联盟申请") {
      eid = EventsManager.strategic_alliance_application;
      if (!Account.user.owned.contains(Account.senior_partner)) {
        ZKCommonUtils.showToast("请等高级合伙人审核通过,如果已经通过,请重新登录");
        return;
      }
    } else if (widget.appleByUsable == "业务员申请") {
      eid = EventsManager.salesman_application;
    }

    await EventsManager.addRolesApple(
        etid: eid,
        rid: rid,
        remark: remark,
        province: province,
        city: city,
        county: county,
        address: address,
        enterpriseName: enterpriseName,
        sos_name: sos_name,
        sos_phone: sos_phone);

//    EventManager.addApplyEvent(tid: eventType, remark: remark, province: province, city:city, county:county, enterpriseName: enterpriseName);

    /// 初级合伙人
    /// {type: 1, jid: 0, fid: 0, rid: 0, title: 初级合伙人, remark: 你的身材好, images: null, total: 0.0, extend: {province: 内蒙古, city: 乌海市, county: 乌达区}}

    /// 高级合伙人
    /// {type: 2, jid: 0, fid: 0, rid: 0, title: 高级合伙人, remark: 嗯ヽ(○^㉨^)ﾉ♪, images: null, total: 0.0, extend: {province: 陕西, city: 宝鸡市, county: 陈仓区}}

    /// 战略
    /// {type: 3, jid: 0, fid: 0, rid: 0, title: 战略联盟, remark: 我这个是不是真的就是, images: null, total: 0.0, extend: {enterprise: 公司名称, province: 四川, city: 泸州市, county: 泸县, address: 详细地址}}

    /// 驻场老师
    /// {type: 4, jid: 0, fid: 31, rid: 0, title: 驻场老师, remark: 申请原因, images: null, total: 0.0, extend: {factory: {id: 31, number: 20200122034800AM0958, factory_name: 东莞晋杨电子有限公司, province: 广东省, city: 东莞市, district: 东莞市, addres: 常平镇岗梓加油站对面, location: 113.967027,22.983452, cooperation_type: 1, nature: 租赁, sile: 私营企业, assets: 20000000, registered_capital: 30000000, km: 10000, male_female_ratio: 无, staff_count: 800, average_age: 18-45, job_channel: 自招, stable_age: 18-45, word_tense_month: 200, required_age: 18-45, word_time: 11小时, month_rest_day_count: 4天, job_way: 白班坐班，少部分夜班, isInsurance: 是, isUniform: 否, dietary_pattern: 工作餐, night_differential: 5元/晚, hospice: 厂内住宿, hospice_count: 8人, wc: 是, time_allocation: 入职第一天, allocation_content: 岗位培训, national_restrictions: 四大民族已满, credentials: 身份证, uid: 119, uname: 索菲亚, uphone: 1382885

    /// 工厂HR
    /// {type: 5, jid: 0, fid: 31, rid: 0, title: 工厂HR, remark: 申请原因, images: null, total: 0.0, extend: {factory: {id: 31, number: 20200122034800AM0958, factory_name: 东莞晋杨电子有限公司, province: 广东省, city: 东莞市, district: 东莞市, addres: 常平镇岗梓加油站对面, location: 113.967027,22.983452, cooperation_type: 1, nature: 租赁, sile: 私营企业, assets: 20000000, registered_capital: 30000000, km: 10000, male_female_ratio: 无, staff_count: 800, average_age: 18-45, job_channel: 自招, stable_age: 18-45, word_tense_month: 200, required_age: 18-45, word_time: 11小时, month_rest_day_count: 4天, job_way: 白班坐班，少部分夜班, isInsurance: 是, isUniform: 否, dietary_pattern: 工作餐, night_differential: 5元/晚, hospice: 厂内住宿, hospice_count: 8人, wc: 是, time_allocation: 入职第一天, allocation_content: 岗位培训, national_restrictions: 四大民族已满, credentials: 身份证, uid: 119, uname: 索菲亚, uphone: 13828855724

    /// 业务员
    /// {type: 8, jid: 0, fid: 0, rid: 0, title: 业务员, remark: 申请原因, images: null, total: 0.0, extend: {province: 广西, city: 南宁市, county: 兴宁区}}
  }
}
