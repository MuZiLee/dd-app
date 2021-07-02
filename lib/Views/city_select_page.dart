import 'dart:convert';
import 'dart:ffi';

import 'package:azlistview/azlistview.dart';
import 'package:common_utils/common_utils.dart';
import 'package:demo2020/Provider/Account.dart';
import 'package:demo2020/Provider/Location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:nav_router/nav_router.dart';

import 'Bases/BaseScaffold.dart';

class CityModel extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;

  CityModel({
    this.name,
    this.tagIndex,
    this.namePinyin,
  });

  CityModel.fromJson(Map<String, dynamic> json) : name = json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
//        'tagIndex': tagIndex,
//        'namePinyin': namePinyin,
//        'isShowSuspension': isShowSuspension
      };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => json.encode(this);
}

class CityListPage extends StatefulWidget {
  ValueChanged<String> onHighlightChanged;

  CityListPage({ValueChanged<String> onHighlightChanged}) {
    this.onHighlightChanged = onHighlightChanged;
  }

  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  List<CityModel> cityList = List();
  List<CityModel> _hotCityList = List();

  @override
  void initState() {
    super.initState();
    _hotCityList.add(CityModel(name: '广州市', tagIndex: '★'));
    _hotCityList.add(CityModel(name: '深圳市', tagIndex: '★'));
    _hotCityList.add(CityModel(name: '东莞市', tagIndex: '★'));
    cityList.addAll(_hotCityList);
    SuspensionUtil.setShowSuspensionStatus(cityList);

    Future.delayed(Duration(milliseconds: 500), () {
      loadData();
    });
  }

  void loadData() async {
    //加载城市列表
    rootBundle.loadString('assets/data/china.json').then((value) {
      cityList.clear();
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      list.forEach((v) {
        cityList.add(CityModel.fromJson(v));
      });
      _handleList(cityList);
    });
  }

  void _handleList(List<CityModel> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);

    // add hotCityList.
    cityList.insertAll(0, _hotCityList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(cityList);

    setState(() {});
  }

  Widget header() {
    return Container(
      color: Colors.white,
      height: 44.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              autofocus: false,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                  labelStyle: TextStyle(fontSize: 16),
                  hintText: '切换城市',
                  hintStyle: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Container(
            width: 0.33,
            height: 14.0,
            color: Color(0xFFEFEFEF),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "取消",
                style: TextStyle(color: Color(0xFF999999), fontSize: 14),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getSusItem(BuildContext context, String tag, {double susHeight = 40}) {
    if (tag == '★') {
      tag = '★ 热门城市';
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  Widget getListItem(BuildContext context, CityModel model,
      {double susHeight = 40}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Offstage(
          offstage: !(model.isShowSuspension == true),
          child: getSusItem(context, model.getSuspensionTag(),
              susHeight: susHeight),
        ),
        ListTile(
          title: Text(model.name),
          onTap: () {
            LogUtil.e("onItemClick : $model");
            widget.onHighlightChanged(model.name);
            pop();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("搜索城市", style: TextStyle(fontSize: 17)),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.black),
          subtitle: TextStyle(color: Colors.black38),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Material(
              color: Color(0x80000000),
              child: Card(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 15.0),
                      height: 50.0,
                      child: Text(
                        "当前城市: " + Location.city,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Expanded(
                      child: AzListView(
                        data: cityList,
                        itemCount: cityList.length,
                        itemBuilder: (BuildContext context, int index) {
                          CityModel model = cityList[index];
                          return getListItem(context, model);
                        },
                        padding: EdgeInsets.zero,
                        susItemBuilder: (BuildContext context, int index) {
                          CityModel model = cityList[index];
                          String tag = model.getSuspensionTag();
                          return getSusItem(context, tag);
                        },
                        indexBarData: ['★', ...kIndexBarData],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
