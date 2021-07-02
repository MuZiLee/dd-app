//
//  文件名：CaptureCodeViewController
//  所在包名：Controller.Member.CaptureCode
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-10-27
//  版权所有 © 2019。 保留所有权利
//

import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:one/Model/User.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


/// 绑定邀请码
class BoundInvitationCodeViewController extends StatefulWidget {
  static const routeName = "/me/CaptureCode";

  @override
  _BoundInvitationCodeViewControllerState createState() =>
      _BoundInvitationCodeViewControllerState();
}

class _BoundInvitationCodeViewControllerState extends State<BoundInvitationCodeViewController> {
  TapGestureRecognizer onTapRecognizer = TapGestureRecognizer();

  /// this [StreamController] will take input of which function should be called

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  _onTap() async {
    Progresshud.show();
    User user = await Account.getInfoByCode(code: currentText);
    Progresshud.dismiss();
    AwesomeDialog(
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      dialogType: DialogType.SUCCES,
      btnCancelColor: Colors.deepOrange,
      btnOkText: "绑定",
      btnOkColor: Colors.green,
      btnCancelText: "返回",
      tittle: user.username,
      desc:   user.phone,
      btnCancelOnPress: () {},
      btnOkOnPress: () async{

        if (Account.user.code > 0) {
          ZKCommonUtils.showToast("你已绑定过，无需再绑定");
          return;
        }
        if (await Account.bindInvitationCode(code: currentText)) {
          ZKCommonUtils.showToast("升级成为会员!");
          setState(() {

          });
        }
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      key: scaffoldKey,
      title: "验证邀请码",
      elevation: 0.0,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Image.asset(
                'images/member/verify.png',
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '验证邀请码',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22 , color: Colors.deepOrange),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "邀请码",
                      children: [
                        TextSpan(
                            text: "6位纯数字",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    length: 6,
                    obsecureText: false,
                    animationType: AnimationType.fade,
                    shape: PinCodeFieldShape.underline,
                    animationDuration: Duration(milliseconds: 300),
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    onChanged: (value) {
                      setState(() {
                        currentText = value;
                      });
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                // error showing widget
                child: Text(
                  hasError ? "*请把所有的格子都填满" : "",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "验证没有响应? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                          text: " 重新发送",
                          recognizer: onTapRecognizer,
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ]),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: FlatButton(
                    onPressed: () {
                      // conditions for validating
                      if (currentText.length != 6) {
                        setState(() {
                          hasError = true;
                        });
                      } else {
                        _onTap();
                      }
                    },
                    child: Center(
                        child: Text(
                          "验证".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.deepOrange.shade300,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.deepOrange.shade200,
                          offset: Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.deepOrange.shade200,
                          offset: Offset(-1, 2),
                          blurRadius: 5)
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
