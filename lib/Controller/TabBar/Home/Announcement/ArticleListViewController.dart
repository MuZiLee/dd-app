
import 'package:demo2020/Controller/TabBar/Home/Announcement/ReadDetailsViewController.dart';
import 'package:demo2020/Model/ArticlesModel.dart';
import 'package:demo2020/Provider/ArticleManager.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

/// 涨知识
class ArticleListViewController extends StatefulWidget {
  static const String routeName = "/home/articleList";

  @override
  _ArticleListViewControllerState createState() => _ArticleListViewControllerState();
}

class _ArticleListViewControllerState extends State<ArticleListViewController> {
  
  static List aricles = [];


  _onRefresh() async {
    aricles = await ArticleManager.getArticlelist(1);
    setState(() {
      
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      title: "涨知识",
      elevation: 0.0,
      child: buildCardRefresher(),
    );
  }

  CardRefresher buildCardRefresher() {
    return CardRefresher(
    onRefresh: _onRefresh,
    child: CardRefresherListView(
      itemCount: aricles.length,
      itemBuilder: (_, index) {
        ArticlesModel model = aricles[index];
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
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(model.desn, style: TextStyle(fontSize: 13),textAlign: TextAlign.left, maxLines: 2,),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(double.parse(model.much_money) > 0 ? "¥"+model.much_money : "¥0.0", style: TextStyle(fontSize: 13, color: Colors.redAccent)),
                        ),
                        Expanded(child: Container()),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(model.dandan_cost + "蛋币", style: TextStyle(fontSize: 13, color: Colors.redAccent),),
                        ),
                        SizedBox(width: 32.0),
                        Container(
                          padding: EdgeInsets.only(right: 5.0),
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            child: Text("购买"),
                            onPressed: () async{
                              if (await ArticleManager.buy(id: model.id)) {
                                routePush(ReadDetailsViewController(model.id, model.title));
                              }
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
                onTap: () {

                  // routePush(ReadDetailsViewController(model.id, model.title));
                },
              ),
            ),
            Divider(height: 1.0)
          ],
        );

      },
    ),
  );
  }
}
