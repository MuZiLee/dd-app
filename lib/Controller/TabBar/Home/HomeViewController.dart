import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:demo2020/Common/HomeFunctions.dart';
import 'package:demo2020/Controller/TabBar/Home/Announcement/AnnouncementListViewController.dart';
import 'package:demo2020/Controller/TabBar/Home/Announcement/ArticleListViewController.dart';
import 'package:demo2020/Controller/TabBar/Home/JobAdItem.dart';
import 'package:demo2020/Controller/TabBar/Home/JobItem.dart';
import 'package:demo2020/Controller/TabBar/Home/Search/JobsSearchViewController.dart';
import 'package:demo2020/Controller/TabBar/Home/Shop/ShopViewController.dart';
import 'package:demo2020/Controller/TabBar/Home/WordTime/WordTimeViewController.dart';
import 'package:demo2020/Controller/WebBrowser/WebBrowserViewController.dart';
import 'package:demo2020/Model/AdModel.dart';
import 'package:demo2020/Model/JobModel.dart';
import 'package:demo2020/Provider/API.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/FactoryManager.dart';
import 'package:demo2020/Provider/Location.dart';
import 'package:demo2020/Provider/ShopManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardHeaderTip.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherGridView.dart';
import 'package:demo2020/Views/CardSeries/CardRefresherListView.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:demo2020/Views/city_select_page.dart';
import 'package:demo2020/config.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amap_location_plugin/amap_location_option.dart';
import 'package:flutter_amap_location_plugin/flutter_amap_location_plugin.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:location_service_check/location_service_check.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeViewController extends StatefulWidget {
  @override
  _HomeViewControllerState createState() => _HomeViewControllerState();
}

class _HomeViewControllerState extends State<HomeViewController> {
  RefreshController _refreshController =
      new RefreshController(initialRefresh: true);

  String city = Location.city;

  JobType selectType = JobType(
    id: 1,
    title: "??????",
    sort: false,
    isHot: 0,
    minimum_search_range: 0,
    maximum_salary_range: 1000000,
  );
  static List titles = ["??????", "??????", "??????"];
  static List jobs = [];

  _onRefresh() async {
    _refreshController.refreshFailed();
    print(selectType.toJson());
    jobs = await FactoryManager.usableJobList(
      jtid: selectType.id,
      soty: selectType.sort,
      isHot: selectType.isHot,
      minimum_search_range: selectType.minimum_search_range,
      // maximum_salary_range: selectType.maximum_salary_range,
      city: city
    );
    if (widget != null) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await Location.updateCurrentLocations(false);
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
                if (item["title"] == "?????????") {
                  routePush(ArticleListViewController());
                } else if (item["title"] == "????????????") {
//                  var url = Config.BASE_URL +
//                      "/shop/index.html?id=" +
//                      Account.user.id.toString();
//                  routePush(WebBrowserViewController(title: "????????????", url: url));
                  await ShopManager.getBannerlist();
                  routePush(ShopViewController());
                } else if (item["title"] == "????????????") {
                  var url = Config.BASE_URL + "/signIn/?uid=" + Account.user.id.toString();
                  print(url);
                  routePush(WebBrowserViewController(title: "????????????", url: url));
                } else if (item["title"] == "??????") {
                  routePush(AnnouncementListViewController());
                } else if (item["title"] == "????????????") {
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
    /// ????????????
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
                  Text("????????????"),
                ],
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
          ),
        ),
        onTap: () {
          /// ?????? push
          JobType moel =
              JobType.fromJson({'id': 1, 'title': "????????????", 'isHot': 0});

          routePush(JobsSearchViewController());
        },
      ),
    );

    /// TODO : ?????????????????????????????????????????????
    if (Account.user.staff == null) {
      slivers.add(searchBar);
    }

    /// ----------------------------------
    /// ????????????
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

    /// TODO : ?????????????????????????????????????????????
    if (Account.user.staff == null) {
      slivers.add(filter);
    }

    /// ----------------------------------
    /// ????????????
    var jobsSliver;

    /// TODO : ?????????????????????????????????????????????
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
            text: Account.user.staff == null ? "????????????????????????" : "?????????",
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
      title: "??????",
      actions: <Widget>[
        CitySwitchButton(
          cityName: Location.city,
          onHighlightChanged: (data) async{
            city = data;
            await _onRefresh();

          },
        ),
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
              activeSize: 10.0)),
    );
  }

  showEventList(BuildContext context, int item) async {
    List<dynamic> types = [];
    if (item == 0) {
      // ????????????
      types = await FactoryManager.getJobTypes();
    } else if (item == 1) {
      // ????????????
      types = FactoryManager.jobWagesList();
    } else {
      // ??????
      types = [
        JobType(title: "??????", sort: false, index: 2),
        JobType(title: "??????", sort: true, index: 2),
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
                                /// ????????????

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
  ValueChanged<String> onHighlightChanged;

  CitySwitchButton({this.cityName, this.onHighlightChanged}) {
    if (this.cityName == null) {
      this.cityName = "????????????";
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
        routePush(CityListPage(
          onHighlightChanged: (city) async{
            Location.city = city;
            setState(() {
              widget.cityName = Location.city ?? "????????????";
              widget.onHighlightChanged(city);
            });
          },
        ));

        bool open = await LocationServiceCheck.checkLocationIsOpen;
        if (!open) {
          await LocationServiceCheck.openLocationSetting;
        }

        await Location.updateCurrentLocations(true);
        setState(() {
          widget.cityName = Location.city ?? "????????????";
        });
      },
    );
  }
}
