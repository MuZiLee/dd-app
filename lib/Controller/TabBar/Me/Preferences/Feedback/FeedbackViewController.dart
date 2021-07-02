//
//  文件名：FeedbackViewController
//  所在包名：Controller.Member.Feedback
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-10-27
//  版权所有 © 2019。 保留所有权利
//

import 'package:demo2020/Provider/SBRequest/SBRequest.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesHeader.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesText.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesTextView.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/material.dart';

class FeedbackViewController extends StatefulWidget {
  static const routeName = "/me/Feedback";

  @override
  _FeedbackViewControllerState createState() => _FeedbackViewControllerState();
}

class _FeedbackViewControllerState extends State<FeedbackViewController> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: '意见反馈',
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            textColor: topColor,
            color: selectedIconColor,
            child: Text("提交", style: TextStyle(color: Colors.white)),
            onPressed: content.length < 10 ? null : () {

              buildThemeButton(context);
            },
          ),
        )
      ],
      child: buildCardSettings(),
    );
  }

  String content = "";
  String title = "";

  buildCardSettings() {
    return Column(
      children: <Widget>[
        CardViewSeriesHeader(
          title: "*如果您有什么宝贵的意见可以在这里向我反馈!",
        ),
        CardViewSeriesText(
          title: "标题",
          subtitle: "输入标题",
          onChanged: (value) {
            title = value;
          },
        ),
        CardViewSeriesTextView(
          title: "意见内容",
          isNotNull: true,
          placeholder: "内容不少于10个字",
          valueChanged: (value) {
            setState(() {
              content = value;
            });
          },
        ),
      ],
    );
  }



  buildThemeButton(BuildContext context) async{
    if (title.length < 2) {
      ZKCommonUtils.showToast("请写标题");
      return;
    }
    if (content.length < 10) {
      ZKCommonUtils.showToast("内容不少于10个字");
      return;
    }


    var url = "feedbackes/create";
    var arguments = {
      "content": content,
      "title": title,
    };

    print(arguments);

    SBResponse response = await SBRequest.post(url, arguments: arguments);
    if (response?.code == 200) {
      ZKCommonUtils.showToast("感谢您的意见，我们会尽快为您解决~！");
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    }
  }
}
