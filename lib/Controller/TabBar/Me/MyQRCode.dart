

import 'package:awesome_button/awesome_button.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Views/ViewWidget.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 我的邀请码
 */
class MyQRCode extends StatefulWidget {
  @override
  _MyQRCodeState createState() => _MyQRCodeState();
}

class _MyQRCodeState extends State<MyQRCode> {

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      elevation: 0.0,
      color: Colors.deepOrange,
      child: buildContainer(context),
    );
  }

  buildContainer(BuildContext context) {
    return ViewWidget(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              color: Colors.deepOrange,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Center(
                child: Image.asset(
                  "images/member/qrcode/qrcodelogo.png",
//                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 315 + (315 * 0.1),
              height: 399 + (399 * 0.1),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('您的专属邀请码',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w900)),
                          SizedBox(height: 32.0),
                          Container(
                            height: 58,
                            margin: EdgeInsets.all(20.0),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: Center(
                                child: Text(
                                  Account.user.code.toString(),
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.deepOrange),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20.0),
                            child: Text(
                                '*您所招聘的员工必需绑定您的专属邀请码，可注册时绑定或注册完成后进入"普通服务"中进行绑定。\n\n*关于提成的规则请向系统客服了解 \n\n*客服联系电话：0769-86297370 \n\n*业务联系：13416801001/张先生',
                                style:
                                TextStyle(fontSize: 13.0, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildContainer2(BuildContext context) {
    return Container(
//      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand, //未定位widget占满Stack整个空间
        children: <Widget>[
          Positioned(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "images/member/qrcode/qrcodebg.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height / 2 -
                MediaQuery.of(context).size.width / 2,
            child: Text(
              "你的专属邀请码",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
    );
  }


}
