//
//  文件名：AddressManagerViewController
//  所在包名：Controller.Me.Personal
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-11-14
//  版权所有 © 2019。 保留所有权利
//

import 'package:demo2020/Controller/TabBar/Home/Shop/Addres/AddAddressViewController.dart';
import 'package:demo2020/Model/AddresModel.dart';
import 'package:demo2020/Provider/AddresManager.dart';
import 'package:demo2020/Provider/ShopManager.dart';
import 'package:demo2020/Views/404/Error404View.dart';
import 'package:demo2020/Views/CardSeries/CardRefresher.dart';
import 'package:demo2020/Views/bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 收货地址
class AddressManagerViewController extends StatefulWidget {
  static const routeName = "/me/personal/AddressManager";

  @override
  _AddressManagerViewControllerState createState() =>
      _AddressManagerViewControllerState();
}

class _AddressManagerViewControllerState
    extends State<AddressManagerViewController> {

  RefreshController refreshController = RefreshController(initialRefresh: true);
  static List addressList = [];
  static AddresModel currentAddres;

  _onRefresh() async {
    refreshController.refreshFailed();
    addressList = await AddresManager.getAddreslist();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {



    return BaseScaffold(
      title: "收货地址",
      elevation: 0.0,
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            color: Colors.deepOrangeAccent,
            child: Text("添加", style: TextStyle(color: Colors.white)),
            onPressed: () {

              routePush(AddAddressViewController()).then((value) {
                // 延时1s执行返回
                Future.delayed(Duration(seconds: 1), (){
                  _onRefresh();
                });
              });
            },
          ),
        )
      ],
      child: _buildListView()
    );
  }

  _buildListView() {

    return CardRefresher(
      onRefresh: _onRefresh,
      refreshController: refreshController,
      child: addressList.length < 1 ? Error404View() : ListView.separated(
          itemBuilder: (_, index) {

            AddresModel addres = addressList[index];
            if (currentAddres != null) {
              if (currentAddres.id == addres.id) {
                addres = currentAddres;
              } else {
                addres.isDefault = false;
              }
            } else {
              addres.isDefault = false;
            }

            return InkWell(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(addres.isDefault ? Icons.check_circle : Icons.check_circle_outline, color: Colors.deepOrangeAccent,),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.person, size: 21, color: Colors.deepOrangeAccent),
                                  Expanded(child: Text(addres.name)),
                                  Icon(Icons.more_vert, size: 21, color: Colors.deepOrangeAccent),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.phone, size: 21, color: Colors.deepOrangeAccent),
                                  Text(addres.phone)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.add_location, size: 21, color: Colors.deepOrangeAccent),
                                  Text(addres.province +" "+ addres.city +" "+ addres.district)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.add_location, size: 21, color: Colors.deepOrangeAccent),
                                  Text(addres.addres)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: <Widget>[
                        //操作按钮集合
                        CupertinoActionSheetAction(
                          child: Text('使用', style: TextStyle(fontSize: 14)),
                          onPressed: () async{
                            addres.isDefault = true;
                            currentAddres = addres;
                            await AddresManager.setAddresDefault(addres.id);
                            setState(() {
                              pop();
                            });
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: Text('删除', style: TextStyle(fontSize: 14)),
                          onPressed: () async{
                            bool succeed = await AddresManager.deleteAddres(id: addres.id);
                            if (succeed) {
                              if (currentAddres.id == addres.id) {
                                currentAddres = null;
                              }
                              addressList.removeAt(index);
                            }
                            setState(() {
                              pop();
                            });
                          },
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        //取消按钮
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('返回', style: TextStyle(fontSize: 14)),
                      ),
                    );
                  },
                );
              },
            );
          }, separatorBuilder: (_, index) => Divider(height: 0.5), itemCount: addressList.length),
    );

  }

}
