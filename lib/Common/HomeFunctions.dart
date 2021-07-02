
import 'package:one/Views/CardSeries/CardRefresherFilter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeFunctions {

//  final bool isUpdate;
//  List<AdBannerModel> bannerList = [];
//  List<SortCondition> jobTypes = [];
//  List jobAdList = [];
//  HomeFunctions(this.context, {this.isUpdate = true}) {
//
//    bannerList = Provider.of<AdvertisingProvider>(context).bannAdList;
//    jobAdList = Provider.of<AdvertisingProvider>(context).jobAdList;
//    List _jobTypes = Provider.of<JobProvider>(context).jobTypeList;
//    jobTypes = [];
//    for (JobType jobType in _jobTypes) {
//      jobTypes.add(SortCondition(title: jobType.title, id: jobType.id, isSelected: false));
//    }
//
//    jobs =  Provider.of<JobProvider>(context).jobs;
//    /// 插入职位广告
//    int tmp = 0;
//    for (int i = 1; i<=jobs.length; i++) {
//      // 当i>0为偶数时
//      print(jobs.length.toString() + ":" + i.toString()  + "  "+ jobAdList.length.toString() + ":" +  tmp.toString());
//      if (jobAdList.length > tmp && i.isEven == true) {
//        jobs.insert(i, jobAdList[tmp]);
//        tmp ++;
//      }
//    }
//
//  }


  static List<Map<String, String>> items = [
//    {"title": "热门职位", "url": "images/home/hot.png"},
//    {"title": "技工职位", "url": "images/home/workers.png"},
//    {"title": "普通职位", "url": "images/home/job.png"},
    {"title": "涨知识", "url": "images/home/increaseknowledge.png"},
    {"title": "商城购物", "url": "images/home/shopping.png"},
    {"title": "天天金蛋", "url": "images/home/goldenEggs.png"},
    {"title": "公告", "url": "images/home/announcement.png"},
    {"title": "工时录入", "url": "images/home/timer.png"},
  ];

  static List<SortCondition> filters = [
    SortCondition(title: "正序", id: 0, isSelected: false),
    SortCondition(title: "倒序", id: 1, isSelected: false),
  ];


  List jobs = [];



//  List getJobs(BuildContext context) async{
//
//    jobs = await Provider.of<JobProvider>(context).getJobList(id: 1);
//    List jobAdList = Provider.of<AdvertisingProvider>(context).jobAdList;
//    int tmp = 0;
//    for (int i = 1; i<=jobs.length; i++) {
//      // 当i>0为偶数时
//      if (i.isEven == true && jobAdList.length >= tmp) {
//        jobs.insert(i, jobAdList[tmp]);
//        tmp ++;
//      }
//    }
//    print(jobs);
//    return jobs;
//  }

}