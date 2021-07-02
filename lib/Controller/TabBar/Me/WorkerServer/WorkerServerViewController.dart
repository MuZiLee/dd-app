
import 'package:demo2020/CellItem.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/material.dart';

class WorkerServerViewController extends StatefulWidget {
  @override
  _WorkerServerViewControllerState createState() => _WorkerServerViewControllerState();
}

class _WorkerServerViewControllerState extends State<WorkerServerViewController> {
  @override
  Widget build(BuildContext context) {

    List<Widget> children = [Container(
      margin: const EdgeInsets.only(top: 20.0),
      color: Colors.white,
      child: CellItem(
        title: '请假',
        imagePath: 'images/member/event.png',
      ),
    ),

      Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: CellItem(
          title: '报销',
          imagePath: 'images/member/event.png',
        ),
      ),

      Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: CellItem(
          title: '离职',
          imagePath: 'images/member/event.png',
        ),
      )];

    if (Account.user.staff.sigingInformation.cooperation_mode != "代理招聘") {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: CellItem(
          title: '我的工资条',
          imagePath: 'images/member/event.png',
        ),
      ));
    }

    return BaseScaffold(
      title: "工作流",
      child: ListView(
        children: children,
      ),
    );
  }
}
