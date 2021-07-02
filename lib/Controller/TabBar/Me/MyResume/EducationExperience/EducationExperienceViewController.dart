//
//  文件名：EducationExperienceViewController
//  所在包名：Controller.Me.MyResume
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-13
//  版权所有 © 2019。 保留所有权利
//


import 'package:one/Controller/TabBar/Me/MyResume/EducationExperience/AddEducationExperienceViewController.dart';
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

/// 教育经历
class EducationExperienceViewController extends StatefulWidget {


  EducationExperienceViewController();

  @override
  _EducationExperienceViewControllerState createState() =>
      _EducationExperienceViewControllerState();
}

class _EducationExperienceViewControllerState extends State<EducationExperienceViewController> {

  static List<Educational> educationlList = [];

  _onRefresh() async{
    Resume resume = await ResumeManager.get();
    educationlList = resume.educational;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {


    return BaseScaffold(
        title: "教育经历",
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              color: selectedIconColor,
              child: Icon(Icons.add, size: 21, color: topColor),
              onPressed: () {

                routePush(AddEducationExperienceViewController()).then((value){
                  _onRefresh();
                });

              },
            ),
          )
        ],
      child: CardRefresher(
        onRefresh: _onRefresh,
        child: educationlList.length != 0 ? CardRefresherListView(
            itemBuilder: (listCtx, index) {

              Educational educational = educationlList[index];

              return ListViewCard(
                children: [
                  ListViewCardCell(
                    title: "教育经历 ${index + 1}",
                    icon: Icons.edit,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Text("毕业学校:"),
                        Text(educational?.school != null ? educational?.school : ""),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Text("学历:"),
                        Text(educational?.education != null ? educational?.education : ""),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Text("毕业时间:"),
                        Text(educational?.graduation_time == 0 ? educational?.graduation_time : ""),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Text("专业:"),
                        Text(educational?.major != null ? educational?.major : ""),
                      ],
                    ),
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
                                if (await ResumeManager.delResumeEducationalExperience(id: educational.id)) {
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
            itemCount: educationlList.length) : Error404View(),
      ),
    );
  }


}
