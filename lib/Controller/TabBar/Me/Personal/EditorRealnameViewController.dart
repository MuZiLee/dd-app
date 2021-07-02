//
//  文件名：EditorRealnameViewController
//  所在包名：Controller.Me.Personal
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-14
//  版权所有 © 2019。 保留所有权利
//


import 'package:one/Provider/Account.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

/// 更改名字
class EditorRealnameViewController extends StatefulWidget {
  static const routeName = "/me/personal/EditorRealname";

  @override
  _EditorRealnameViewControllerState createState() =>
      _EditorRealnameViewControllerState();
}

class _EditorRealnameViewControllerState
    extends State<EditorRealnameViewController> {

  String username = "";
  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "更改名字",
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              style: TextStyle(color: Colors.black, fontSize: 14.0),
              keyboardType: TextInputType.multiline,
              autofocus: true,
              cursorColor: Colors.deepOrange,
              autocorrect: true,
              decoration: InputDecoration(
                labelText: "名字不得少于2个字",
                counterText: "请填写您的真实姓名",
              ),
              onChanged: (value) {
                username = value;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            color: Colors.deepOrange,
            child: Text('保存', style: TextStyle(color: Colors.white)),
            onPressed: () async{
              if (username.length < 2) {
                ZKCommonUtils.showToast("名字不得少于2个字");
                return;
              }
               if (await Account.setUserName(username)) {
                 pop();
               }
            },
          ),
        )
      ],
    );
  }
}
