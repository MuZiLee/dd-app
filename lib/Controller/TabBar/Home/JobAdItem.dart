
import 'package:one/Controller/WebBrowser/WebBrowserViewController.dart';
import 'package:one/Model/AdModel.dart';
import 'package:one/Views/SBImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

class JobAdItem extends StatefulWidget {

  final AdModel model;
  JobAdItem({this.model});


  @override
  _JobAdItemState createState() => _JobAdItemState();
}

class _JobAdItemState extends State<JobAdItem> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 146,
      child: Stack(
        alignment:Alignment.center ,
        fit: StackFit.expand, //未定位widget占满Stack整个空间
        children: <Widget>[

          InkWell(
            child: Card(
              elevation: 0.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: SBImage(url: widget.model.image),
              ),
            ),
            onTap: () {

              routePush(WebBrowserViewController(title: widget.model.title, url:widget.model.url));
            },
          ),
          Positioned(
            top: 3.0,
            left: 3.0,
            child: Container(
              width: 60,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 70, top: 5),
              child: Card(child: Center(child: Text("广告", style: TextStyle(fontSize: 10, color: Colors.white)),), color: Colors.deepOrangeAccent, elevation: 0.0),
            ),
          )
        ],
      ),
    );

  }
}

