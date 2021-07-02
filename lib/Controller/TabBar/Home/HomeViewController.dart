import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:one/Common/HomeFunctions.dart';
import 'package:one/Controller/TabBar/Home/Announcement/AnnouncementListViewController.dart';
import 'package:one/Controller/TabBar/Home/Announcement/ArticleListViewController.dart';
import 'package:one/Controller/TabBar/Home/JobAdItem.dart';
import 'package:one/Controller/TabBar/Home/JobItem.dart';
import 'package:one/Controller/TabBar/Home/Search/JobsSearchViewController.dart';
import 'package:one/Controller/TabBar/Home/Shop/ShopViewController.dart';
import 'package:one/Controller/TabBar/Home/WordTime/WordTimeViewController.dart';
import 'package:one/Controller/WebBrowser/WebBrowserViewController.dart';
import 'package:one/Model/AdModel.dart';
import 'package:one/Model/JobModel.dart';
import 'package:one/Provider/API.dart';
import 'package:one/Provider/Account.dart';
import 'package:one/Provider/FactoryManager.dart';
import 'package:one/Provider/Location.dart';
import 'package:one/Provider/ShopManager.dart';
import 'package:one/Views/404/Error404View.dart';
import 'package:one/Views/CardSeries/CardHeaderTip.dart';
import 'package:one/Views/CardSeries/CardRefresherGridView.dart';
import 'package:one/Views/CardSeries/CardRefresherListView.dart';
import 'package:one/Views/SBImage.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/config.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeViewController extends StatefulWidget {
  @override
  _HomeViewControllerState createState() => _HomeViewControllerState();
}

class _HomeViewControllerState extends State<HomeViewController> {
  RefreshController _refreshController = new RefreshController(initialRefresh: true);

  JobType selectType = JobType(
    id: 1,
    title: "全部",
    sort: false,
    isHot: 0,
    minimum_search_range: 0,
    maximum_salary_range: 1000000,
  );
  static List titles = ["全部", "不限", "正序"];
  static List jobs = [];

  _onRefresh() async {
    _refreshController.refreshFailed();
    print(selectType.toJson());
    jobs = await FactoryManager.usableJobList(
      jtid: selectType.id,
      soty: selectType.sort,
      isHot: selectType.isHot,
      minimum_search_range: selectType.minimum_search_range,
      maximum_salary_range: selectType.maximum_salary_range,
    );
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = [];

    /// ----------------------------------
    /// banner
    SliverFixedExtentList header = SliverFixedExtentList(
      itemExtent: 180,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _buildSwiper(context);
      }, childCount: 1),
    );
    slivers.add(header);

    /// ----------------------------------
    /// items
    SliverStickyHeader items = SliverStickyHeader(
      sticky: false,
      header: CardHeaderTip(""),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (_, int index) {
            Map item = HomeFunctions.items[index];
            return CardRefresherGridViewItem(
              url: item["url"],
              title: item["title"],
              onTap: () async {
                if (item["title"] == "涨知识") {
                  routePush(ArticleListViewController());
                } else if (item["title"] == "商城购物") {
//                  var url = Config.BASE_URL +
//                      "/shop/index.html?id=" +
//                      Account.user.id.toString();
//                  routePush(WebBrowserViewController(title: "商城购物", url: url));
                  await ShopManager.getBannerlist();
                  routePush(ShopViewController());
                } else if (item["title"] == "天天金蛋") {
                  var url = Config.BASE_URL +
                      "/signin/index.html?id=" +
                      Account.user.id.toString();
                  routePush(WebBrowserViewController(title: "天天金蛋", url: url));
                } else if (item["title"] == "公告") {
                  routePush(AnnouncementListViewController());
                } else if (item["title"] == "工时录入") {
                  routePush(WordTimeViewController());
                }
              },
            );
          },
          childCount: HomeFunctions.items.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 0.0, crossAxisSpacing: 0.0),
      ),
    );
    slivers.add(items);

//    if (Account.user.isJob == true) {
    /// ----------------------------------
    /// 搜索职位
    SliverToBoxAdapter searchBar = SliverToBoxAdapter(
      child: InkWell(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: ClipRRect(
            child: Container(
              height: 42,
              padding: EdgeInsets.all(5),
              color: Colors.black12,
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  Text("职位搜索"),
                ],
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
          ),
        ),
        onTap: () {
          /// 搜索 push
          JobType moel =
              JobType.fromJson({'id': 1, 'title': "职位搜索", 'isHot': 0});

          routePush(JobsSearchViewController());
        },
      ),
    );

    /// TODO : 如果用户已入职就不进行下面操作
    if (Account.user.staff == null) {
      slivers.add(searchBar);
    }

    /// ----------------------------------
    /// 条件过滤
    List<Widget> filterItems = [];

    for (int i = 0; i < titles.length; i++) {
      filterItems.add(Container(
        color: Colors.white,
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.arrow_drop_down),
              AutoSizeText(titles[i], minFontSize: 5, maxFontSize: 14),
            ],
          ),
          onTap: () => showEventList(context, i),
        ),
      ));
    }
    SliverStickyHeader filter = SliverStickyHeader(
      sticky: false,
      header: CardHeaderTip(""),
      sliver: SliverGrid.extent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
        childAspectRatio: 3.0,
        children: filterItems,
      ),
    );

    /// TODO : 如果用户已入职就不进行下面操作
    if (Account.user.staff == null) {
      slivers.add(filter);
    }

    /// ----------------------------------
    /// 职位列表
    var jobsSliver;

    /// TODO : 如果用户已入职就不进行下面操作
    if (jobs.length > 0 && Account.user.staff == null) {
      jobsSliver = SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        if (jobs[index].runtimeType.toString() == "AdModel") {
          AdModel model = jobs[index];
          return JobAdItem(model: model);
        } else {
          JobModel job = jobs[index];
          return JobItem(job: job);
        }
      }, childCount: jobs.length));
    } else {
      jobsSliver = SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(64),
          child: Error404View(
            text: Account.user.staff == null ? "没有数据" : "已入职",
          ),
        );
      }, childCount: 1));
    }

    SliverStickyHeader jobList = SliverStickyHeader(
      sticky: false,
      header: CardHeaderTip(""),
      sliver: jobsSliver,
    );
    slivers.add(jobList);

    return BaseScaffold(
      title: "首页",
      actions: <Widget>[
        CitySwitchButton(cityName: Location.amap?.city),
      ],
      child: CupertinoScrollbar(
        child: LayoutBuilder(
          builder: (i, c) {
            return SmartRefresher(
//              enablePullUp: true,
              enablePullDown: true,
              onTwoLevel: () {},
              controller: _refreshController,
              header: MaterialClassicHeader(),
              onRefresh: _onRefresh,
              child: CustomScrollView(
                slivers: slivers,
              ),
//              onLoading: _onLoading,
            );
          },
        ),
      ),
    );
  }

  Swiper _buildSwiper(BuildContext context) {
    return new Swiper(
      itemBuilder: (BuildContext context, int index) {
        AdModel banner = API.bannerAdlist[index];
        return SBImage(url: banner.image);
      },
      itemCount: API.bannerAdlist.length,
      autoplay: false,
      onTap: (index) {
        AdModel banner = API.bannerAdlist[index];
        routePush(WebBrowserViewController(
          title: banner.title,
          url: banner.url,
        ));
      },
      pagination: new SwiperPagination(
          alignment: Alignment.bottomLeft,
          builder: DotSwiperPaginationBuilder(
              color: Color.fromRGBO(200, 200, 200, 0.5),
              activeColor: Colors.deepOrange,
              size: 8.0,
              activeSize: 10.0
          )
      ),
    );
  }

  showEventList(BuildContext context, int item) async {
    List<dynamic> types = [];
    if (item == 0) {
      // 职位类型
      types = await FactoryManager.getJobTypes();
    } else if (item == 1) {
      // 过滤金额
      types = FactoryManager.jobWagesList();
    } else {
      // 排序
      types = [
        JobType(title: "正序", sort: false, index: 2),
        JobType(title: "倒序", sort: true, index: 2),
      ];
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (c) {
        return DraggableScrollableSheet(
          initialChildSize: 1.0,
          maxChildSize: 1.0,
          minChildSize: 0.5,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              child: StatefulBuilder(
                builder: (BuildContext context2, setter) {
                  return CardRefresherListView(
                    itemCount: types.length,
                    itemBuilder: (_, index) {
                      JobType type = types[index];

                      return Column(
                        children: <Widget>[
                          InkWell(
                              child: ListTile(
                                title: Text(type.title),
                                trailing: Icon(Icons.panorama_fish_eye),
                              ),
                              onTap: () {
                                /// 搜索职位

                                if (type.index == 0) {
                                  selectType.id = type.id;
                                  titles[0] = type.title;
                                  if (type.id == 7) {
                                    selectType.isHot = 1;
                                  } else {
                                    selectType.isHot = 0;
                                  }
                                } else if (type.index == 1) {
                                  selectType.minimum_search_range =
                                      type.minimum_search_range;
                                  selectType.maximum_salary_range =
                                      type.maximum_salary_range;
                                  titles[1] = type.title;
                                } else if (type.index == 2) {
                                  selectType.sort = type.sort;
                                  titles[2] = type.title;
                                }
                                _onRefresh();
                                pop();
                              }),
                          Divider(height: 1),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class CitySwitchButton extends StatefulWidget {
  String cityName;

  CitySwitchButton({this.cityName}) {
    if (this.cityName == null) {
      this.cityName = "未知位置";
    }
  }

  @override
  _CitySwitchButtonState createState() => _CitySwitchButtonState();
}

class _CitySwitchButtonState extends State<CitySwitchButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          children: <Widget>[
//            Icon(Icons.expand_more, size: 18, color: Colors.black),
            AutoSizeText(
              widget.cityName,
              style: TextStyle(fontSize: 12, color: Colors.black),
              minFontSize: 9,
            ),
            Image.asset(
              "images/home/city.png",
              width: 24.0,
              height: 24.0,
              color: Colors.deepOrangeAccent,
            ),
//            SizedBox(width: 10.0),
          ],
        ),
      ),
      onTap: () async {
        await Location.updateCurrentLocations();
        ZKCommonUtils.showToast("位置已更新");
        setState(() {
          widget.cityName =
              Location.amap?.city != null ? Location.amap?.city : "未知位置";
        });
      },
    );
  }
}
