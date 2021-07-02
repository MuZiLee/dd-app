//
//  文件名：AddAddressViewController
//  所在包名：Controller.Me.Personal
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-14
//  版权所有 © 2019。 保留所有权利
//


import 'package:one/Provider/AddresManager.dart';
import 'package:one/Views/CardSeries/CardViewSeriesCity.dart';
import 'package:one/Views/CardSeries/CardViewSeriesSwitch.dart';
import 'package:one/Views/CardSeries/CardViewSeriesText.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';


/// 添加地址
class AddAddressViewController extends StatefulWidget {
  static const routeName = "/me/personal/AddAddress";

  @override
  _AddAddressViewControllerState createState() =>
      _AddAddressViewControllerState();
}

class _AddAddressViewControllerState extends State<AddAddressViewController> {


  String name;
  String phone;
  String province;
  String city;
  String district;
  String addres;
  var isDefault = false;

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "添加地址",
      elevation: 0.0,
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: RaisedButton(
            color: Colors.deepOrangeAccent,
            child: Text('保存', style: TextStyle(color: Colors.white)),
            onPressed: () {
              addr_add(context);
            },
          ),
        )
      ],
      child: Column(
        children: <Widget>[

          CardViewSeriesText(
            title: "收货人",
            isNotNull: true,
            placeholder: "点击输入",
            onChanged: (value) => name = value,
          ),
          CardViewSeriesText(
            title: "联系电话",
            placeholder: "点击输入",
            isNotNull: true,
            keyboardType: TextInputType.number,
            onChanged: (value) => phone = value,
          ),
          CardViewSeriesCity(
            title: "城市选择",
            subtitle: "点击选择",
            isNotNull: true,
            onConfirm: (String p, String c, String t) {
              province = p;
              city = c;
              district = t;
            }
          ),
          CardViewSeriesText(
            title: "详细地址",
            placeholder: "点击输入",
            isNotNull: true,
            onChanged: (value){
              addres = value;
            },
          ),
          CardViewSeriesSwitch(
            title: "是否设置为默认",
            falseText: "否",
            trueText: "默认",
            onChanged: (value) => isDefault = value,
          )
        ],
      ),
    );
  }

  addr_add(BuildContext context) async{

    if (name == null) {
      ZKCommonUtils.showToast("收货人不能为空");
      return;
    }
    if (phone == null || phone.length < 11) {
      ZKCommonUtils.showToast("手机号不能为空");
      return;
    }
    if (addres == null) {
        ZKCommonUtils.showToast("请填写详细地址");
      return;
    }


    var arguments = {
      "province": province,
      "city": city,
      "district": district,
      "addres": addres,
      "name": name,
      "phone": phone,
      "isDefault": isDefault,
    };

    bool succel = await AddresManager.addAddres(arguments);

    if (succel) {
      ZKCommonUtils.showToast("保存成功");
      pop();
    }


  }
}
