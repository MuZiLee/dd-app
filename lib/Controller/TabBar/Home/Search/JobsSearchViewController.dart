//
//  文件名：JobsSearchViewController
//  所在包名：Controller.Home.Search
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-09
//  版权所有 © 2019。 保留所有权利
//

import 'package:demo2020/Controller/TabBar/Home/Details/JobDetailsViewController.dart';
import 'package:demo2020/Controller/TabBar/Home/JobItem.dart';
import 'package:demo2020/Model/JobModel.dart';
import 'package:demo2020/Provider/FactoryManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/SearchBarView.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nav_router/nav_router.dart';

/// 职位搜索
class JobsSearchViewController extends StatefulWidget {
  static const routeName = "/home/JobsSearch";

  @override
  _JobsSearchViewControllerState createState() =>
      _JobsSearchViewControllerState();
}

class _JobsSearchViewControllerState extends State<JobsSearchViewController> {


  String searchName = "";

  List jobs = [];
  _onRefresh() async{
    jobs = await FactoryManager.jobSearch(searchName);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {


    return BaseScaffold(
      title: "搜索职位",
      elevation: 0.1,
      child: CardRefresher(
        onRefresh: () {
          _onRefresh();
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: SearchBarView(
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (searchName.length < 1) {
                    return;
                  }
                },
                onChanged: (value) {
                  searchName = value;
                  _onRefresh();
                },
              ),
            ),

            Expanded(
                child: jobs.length != 0 ? CardRefresherListView(
                  itemCount: jobs.length,
                  itemBuilder: (_, index) {

                    JobModel model = jobs[index];
                    return JobItem(job: model);
                  },
                ) : Error404View()
            ),

          ],
        ),
      ),
    );
  }





}
