
import 'package:demo2020/Controller/TabBar/Home/Announcement/ReadDetailsViewController.dart';
import 'package:demo2020/Model/AnnouncementModel.dart';
import 'package:demo2020/Model/ArticlesModel.dart';
import 'package:demo2020/Provider/ArticleManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

class AnnouncementListViewController extends StatefulWidget {
  static const String routeName = "/home/announcement";


  AnnouncementListViewController();

  @override
  _AnnouncementListViewControllerState createState() => _AnnouncementListViewControllerState();
}

class _AnnouncementListViewControllerState extends State<AnnouncementListViewController> {

  static List announcementList = [];
  _onRefresh() async {
    announcementList = await ArticleManager.getArticlelist(2);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "公告",
      elevation: 0.0,
      child: buildCardRefresher(),
    );
  }

  CardRefresher buildCardRefresher() {
    return CardRefresher(
      onRefresh: _onRefresh,
      child: buildCardRefresherListView(),
    );
  }

  buildCardRefresherListView() {
    if (announcementList.length < 1) {
      return Error404View();
    }

    return CardRefresherListView(
      itemCount: announcementList.length,
      itemBuilder: (_, index) {
        AnnouncementModel model = announcementList[index];

        return Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: ListTile(
                leading: SizedBox(
                  width: 48, height: 48,
                  child: SBImage(
                    url: model.image,
                  ),
                ),
                title: Text(model.title, style: TextStyle(fontSize: 15),),
                subtitle: Text(model.desn, style: TextStyle(fontSize: 13), maxLines: 2),
                onTap: () {
                  routePush(ReadDetailsViewController(model.id, model.title));
                },
              ),
            ),
            Divider(height: 1.0)
          ],
        );
      },
    );
  }

}
