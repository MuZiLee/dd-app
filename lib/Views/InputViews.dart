//
//  文件名：InputViews
//  所在包名：Views
//  所在项目名称：dandankj
//
//  开发者： lee 
//  开发时间: 2019-11-08
//  版权所有 © 2019。 保留所有权利
//

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';


class PhoneInput extends StatefulWidget {

  PhoneInput({this.onChanged, this.title = "请输入手机号码"});
  final ValueChanged<String> onChanged;
  final String title;

  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {


  bool isVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 48.0,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.transparent,
                  maxLengthEnforced: false,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.phone, size: 21),
                    hintText: widget.title,
                    isDense: true
                  ),
                  onChanged: widget.onChanged ?? widget.onChanged,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}



class PasswordInput extends StatefulWidget {
  PasswordInput({this.onChanged, this.title = "请输入密码"});
  final ValueChanged<String> onChanged;
  final String title;

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {

  bool isVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 48.0,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  obscureText: isVisibility,
                  cursorColor: Colors.transparent,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    prefixIcon: Icon(CupertinoIcons.padlock_solid, size: 21),
                    hintText: widget.title,
                    isDense: true,
                    suffixIcon: FlatButton(
                      child: Icon(isVisibility ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          isVisibility = !isVisibility;
                        });
                      },
                    ),
                  ),
                  onChanged: widget.onChanged ?? widget.onChanged,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

}

class AuthCodeInput extends StatefulWidget {

  final ValueChanged<String> onChanged;
  final VoidCallback onPressed;
  bool obscureText;
  final String title;
  AuthCodeInput({this.onChanged, this.onPressed, this.obscureText = false, this.title = "请输入验证码"});


  @override
  _AuthCodeInputState createState() => _AuthCodeInputState();
}

class _AuthCodeInputState extends State<AuthCodeInput> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 48.0,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  obscureText: widget.obscureText,
                  cursorColor: Colors.transparent,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.code, size: 21.0),
                    hintText: widget.title,
                    isDense: true,
                    suffixIcon: Card(
                      child: Container(
                        height: 40.0,
                        child: FlatButton(
                          onPressed: isActivate == true ? () {
                            if (widget.onPressed != null) {
                              widget.onPressed();
                            }
                            reGetCountdown();
                          } : null,
                          child: Text(_codeCountdownStr,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: isActivate == true ? Colors.black : Colors.black54,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  onChanged: widget.onChanged ?? widget.onChanged,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Timer _countdownTimer;
  String _codeCountdownStr = '验证码';
  int _countdownNum = 120;
  bool isActivate = true;

  void reGetCountdown() {
    setState(() {
      if (_countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}';
      _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}';
            isActivate = false;
          } else {
            _codeCountdownStr = '验证码';
            isActivate = true;
            _countdownNum = 59;
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

}

