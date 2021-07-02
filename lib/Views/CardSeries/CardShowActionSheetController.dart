
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardShowActionSheetController {


  CardShowActionSheetController(
    @required BuildContext context, {
    @required String title,
    @required String subtitle,
    // Widget or CupertinoActionSheetAction
    @required List<Widget> actions
  }) {



    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text(title), //标题
          message: Text(subtitle, style: TextStyle(color: Colors.grey)), //提示内容
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            //取消按钮
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('返回'),
          ),
        );
      },
    );

  }

}