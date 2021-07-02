//
//  文件名：WorkExperienceViewController
//  所在包名：Controller.Me.MyResume
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-14
//  版权所有 © 2019。 保留所有权利
//


import 'package:one/Controller/TabBar/Me/MyResume/WorkExperience/AddWorkExperienceViewController.dart';
import 'package:one/Model/Resume.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/ResumeManager.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/CardSeries/CardRefresher.dart';
import 'package:one/Views/CardSeries/CardRefresherListView.dart';
import 'package:one/Views/ListViewCard.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';


/// 工作经历管理
class WorkExperienceViewController extends StatefulWidget {
  static const routeName = "/tabbar/me/myresume/WorkExperience";

  WorkExperienceViewController();

  @override
  _WorkExperienceViewControllerState createState() =>
      _WorkExperienceViewControllerState();
}

class _WorkExperienceViewControllerState extends State<WorkExperienceViewController> {


  static List<Work> works = [];

  _onRefresh() async{
    Resume resume = await ResumeManager.get();
    works = resume.work;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "工作经历",
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            color: selectedIconColor,
            child: Icon(Icons.add, size: 21, color: topColor),
            onPressed: () {
              routePush(AddWorkExperienceViewController()).then((value){
                _onRefresh();
              });
            },
          ),
        )
      ],
      child: CardRefresher(
        onRefresh: _onRefresh,
        child: works.length != 0 ? CardRefresherListView(
            itemBuilder: (listCtx, index) {

              Work work = works[index];

              return ListViewCard(
                children: [
                  ListViewCardCell(
                    title: "工作经历 ${index + 1}",
                    icon: Icons.edit,
                  ),
                  ListViewCardCell(
                    title: "公司名称",
                    subtitle: work.company_name,
                  ),
                  ListViewCardCell(
                    title: "公司地址",
                    subtitle: work.company_address,
                  ),
                  ListViewCardCell(
                    title: "公司电话",
                    subtitle: work.company_phone,
                  ),
                  ListViewCardCell(
                    title: "所属职位",
                    subtitle: work.company_job != null ? work.company_job : "",
                  ),
                  ListViewCardCell(
                    title: "工作时长",
                    subtitle: "${work.work_time}年",
                  ),
                  ListViewCardCell(
                    title: "工作内容",
                    subtitle: work.work_content,
                  ),
                ],
                onTap: () {

                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                              child: Text('删除', style: TextStyle(fontSize: 14)),
                              onPressed: () async{
                                pop();
                                Progresshud.show();
                                if (await ResumeManager.delResumeWorkExperience(id: work.id)) {
                                  Progresshud.dismiss();
                                  _onRefresh();
                                }

                              }),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                            child: Text('返回', style: TextStyle(fontSize: 14)),
                            onPressed: () {
                              Navigator.pop(context);
                            }
                        ),
                      );
                    },
                  );
                },
              );

            },
            itemCount: works.length) : Error404View(),
      ),
    );
  }
}
