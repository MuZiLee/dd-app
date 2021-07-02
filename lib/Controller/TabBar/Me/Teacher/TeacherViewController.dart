import 'package:demo2020/CellItem.dart';
import 'package:demo2020/Controller/TabBar/Me/Partner/EnterpriseCommission/TeacherEnterpriseCommissionViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Teacher/AttendanceViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Teacher/FactoryCalculationWagesViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Teacher/FactoryLeaveAuditViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Teacher/FactoryQuitViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Teacher/FactoryInJobViewController.dart';
import 'package:demo2020/Controller/TabBar/Me/Teacher/FactoryReimbursementAuditViewController.dart';
import 'package:demo2020/Model/JobModel.dart';
import 'package:demo2020/Model/User.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/EventsManager.dart';
import 'package:demo2020/Views/CardSeries/CardHeaderTip.dart';
import 'package:demo2020/Views/CardSeries/CardShowActionSheetController.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

class TeacherViewController extends StatefulWidget {
  @override
  _TeacherViewControllerState createState() => _TeacherViewControllerState();
}

class _TeacherViewControllerState extends State<TeacherViewController> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    Account.user.teachers.map((Teacher teacher) {
      children.add(Container(
        margin: const EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CardHeaderTip(""),
            CellItem(
              imagePath: teacher.logo,
              title: teacher.factory_name,
              width: 32.0,
              height: 32.0,
              onPressed: () {

                CardShowActionSheetController(
                    context,
                    title: teacher.factory_name,
                    subtitle: "请选择操作方式",
                    actions: [

                      //操作按钮集合
                      CupertinoActionSheetAction(
                          child: Text('入职审核', style: TextStyle(fontSize: 14)),
                          onPressed: () {
                            routePush(FactoryInJobViewController(title: teacher.factory_name, teacher: teacher,)).then((value) => pop());
                          }

                      ),
                      CupertinoActionSheetAction(
                          child: Text('考勤', style: TextStyle(fontSize: 14)),
                          onPressed: () {
                            routePush(AttendanceViewController(title: teacher.factory_name, teacher: teacher,)).then((value) => pop());
                          }

                      ),
                      CupertinoActionSheetAction(
                        child: Text('请假审核', style: TextStyle(fontSize: 14)),
                        onPressed: () {
                          routePush(FactoryLeaveAuditViewController(title: teacher.factory_name, teacher: teacher,)).then((value) => pop());
                        }
                      ),
                      CupertinoActionSheetAction(
                          child: Text('报销审核', style: TextStyle(fontSize: 14)),
                          onPressed: () {
                            routePush(FactoryReimbursementAuditViewController(title: teacher.factory_name, teacher: teacher,)).then((value) => pop());
                          }
                      ),
                      CupertinoActionSheetAction(
                          child: Text('离职审核', style: TextStyle(fontSize: 14)),
                          onPressed: () {
                            routePush(FactoryQuitViewController(title: teacher.factory_name, teacher: teacher,)).then((value) => pop());
                          }
                      ),
                      CupertinoActionSheetAction(
                          child: Text('工资条', style: TextStyle(fontSize: 14)),
                          onPressed: () {
                            routePush(FactoryCalculationWagesViewController(title: teacher.factory_name, teacher: teacher,)).then((value) => pop());
                          }
                      ),

                    ]
                );


              },
            )
          ],
        ),
      ));
    }).toList();

    return BaseScaffold(
      title: "工厂管理",
      child: ListView(
        children: children,
      ),
    );
  }



}
