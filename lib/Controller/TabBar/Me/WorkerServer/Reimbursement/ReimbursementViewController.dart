import 'dart:io';
import 'dart:math';

import 'package:demo2020/Provider/StaffManager.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesNumber.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesText.dart';
import 'package:demo2020/Views/CardSeries/CardViewSeriesTextView.dart';
import 'package:demo2020/Views/MyBehavior.dart';
import 'package:demo2020/Views/SBImage.dart';
import 'package:demo2020/config.dart';
import 'package:demo2020/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nav_router/nav_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ovprogresshud/progresshud.dart';

class ReimbursementViewController extends StatefulWidget {
  @override
  _reimbursementViewControllerState createState() =>
      _reimbursementViewControllerState();
}

class _reimbursementViewControllerState
    extends State<ReimbursementViewController> {
  ScrollController controller = new ScrollController();
  String remark = "";
  double cost = 0.0;
  List images = [
    Config.addImage,
    Config.addImage,
    Config.addImage,
    Config.addImage,
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "报销",
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            textColor: topColor,
            color: selectedIconColor,
            child: Text("提交", style: TextStyle(color: Colors.white)),
            onPressed: remark.length < 1 ? null : () async {
              var left_cost = cost;
              if (left_cost < 1) {
                ZKCommonUtils.showToast("这个费用报销有意义吗?");
                return ;
              }

              ZKCommonUtils.showToast("开始提交");
              List urls = [];
              images.map((e) {
                if (!e.toString().contains(Config.addImage)) {
                  urls.add(e.toString().substring(Config.BASE_URL.length, e.toString().length));
                }
              }).toList();
              if (urls.length < 1) {
                ZKCommonUtils.showToast("报销凭证是必需上传的");
                return;
              }


              if (await StaffManager.reimbursement(remark: remark, cost: left_cost, images: urls)) {
                ZKCommonUtils.showToast("报销已提交");
                Progresshud.dismiss();
                pop();
              }
            },
          ),
        )
      ],
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            CardViewSeriesText(
              title: "事件类型",
              subtitle: "报销",
              enabled: false,
            ),
            CardViewSeriesNumber(
              title: "报销金额",
              isNotNull: true,
              placeholder: "0.00",
              onChanged: (value) {
                cost = double.parse(value);
              },
            ),
            Container(
              height: 140,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text("报销凭证",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  decoration: TextDecoration.none)),
                        ),
                        Text("*",
                            style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.none)),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              "可以上传4张图片",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black38,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (_, int index) {
                                String url = images[index];
                                // ignore: deprecated_member_use
                                return FlatButton(
                                  color: Colors.white,
                                  child: SBImage(
                                    url: url,
                                    error: Image.asset("images/addImage.png"),
                                  ),
                                  onPressed: () {
                                    currentIndex = index;
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoActionSheet(
                                          title: Text('报销凭证', style: TextStyle(fontSize: 14)), //标题
                                          message: Text('请选择获取照片方式'), //提示内容
                                          actions: <Widget>[
                                            //操作按钮集合
                                            CupertinoActionSheetAction(
                                              child: Text('从相册获取',style: TextStyle(fontSize: 14)),
                                              onPressed: () {
                                                retrieveLostData();
                                              },
                                            ),
                                            CupertinoActionSheetAction(
                                              child: Text('拍照',style: TextStyle(fontSize: 14)),
                                              onPressed: () {
                                                cameraLostData();
                                              },
                                            ),
                                          ],
                                          cancelButton: CupertinoActionSheetAction(
                                            //取消按钮
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('取消',style: TextStyle(fontSize: 16)),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              childCount: images.length,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 0.0,
                                    crossAxisSpacing: 0.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(height: 1)
                ],
              ),
            ),
            CardViewSeriesTextView(
              title: "报销内容",
              isNotNull: true,
              placeholder: "",
              valueChanged: (value) {
                remark = value;
                setState(() {

                });
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> retrieveLostData() async {
    Navigator.of(context).pop();

    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    print(image.path);
    Progresshud.show();
    ZKCommonUtils.showToast("开始压缩图片");
    var tmpimage = await compressImage(image);
    ZKCommonUtils.showToast("开始上传图片");
    var url = await StaffManager.uploadImage(tmpimage);
    Progresshud.dismiss();
    images[currentIndex] = Config.BASE_URL+url;
    setState(() {

    });

  }

  Future<void> cameraLostData() async {
    Navigator.of(context).pop();

    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    print(image.path);
    Progresshud.show();
    ZKCommonUtils.showToast("开始压缩图片");
    var tmpimage = await compressImage(image);
    ZKCommonUtils.showToast("开始上传图片");
    var url = await StaffManager.uploadImage(tmpimage);
    Progresshud.dismiss();
    images[currentIndex] = Config.BASE_URL+url;
    setState(() {

    });
  }

  /**
   * 压缩图片
   */
  compressImage(File file) async{
    var tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CompressObject compressObject = CompressObject(
        imageFile: file,
        path: tempPath,
        mode: CompressMode.LARGE2SMALL
    );
    return await Luban.compressImage(compressObject);
  }




}
