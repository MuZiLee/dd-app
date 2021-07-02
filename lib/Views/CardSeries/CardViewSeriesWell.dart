//
//  文件名：MemberCardWell
//  所在包名：Utils
//  所在项目名称：dandankj
//
//  开发者： lee
//  开发时间: 2019-10-29
//  版权所有 © 2019。 保留所有权利
//

import 'package:flutter/material.dart';

class CardViewSeriesWell extends StatelessWidget {
  final String imageLoc;
  final String title;
  final String subtitle;
  final GestureTapCallback onTap;

  CardViewSeriesWell({this.imageLoc, this.title, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Container(
          child: buildRow(context),
        ),
      ),
      onTap: onTap,
    );
  }

  Row buildRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Image.asset(imageLoc, width: 32.0, height: 32.0),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width - 20.0 - 32 - 10.0,
                  child: Text(title,
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                      textAlign: TextAlign.start)),
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width - 20.0 - 32 - 10.0,
                child: Text(subtitle,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    textAlign: TextAlign.start),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
