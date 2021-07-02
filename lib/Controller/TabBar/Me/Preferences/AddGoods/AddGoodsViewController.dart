import 'dart:io';

import 'package:one/Model/ShopCategory.dart';
import 'package:one/Provider/ShopManager.dart';
import 'package:one/Provider/StaffManager.dart';
import 'package:one/Views/CardSeries/CardRefresherListView.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:one/Views/card_settings/card_settings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:one/Views/CardSeries/CardViewSeriesNumber.dart';
import 'package:one/Views/CardSeries/CardViewSeriesRight.dart';
import 'package:one/Views/CardSeries/CardViewSeriesText.dart';
import 'package:one/Views/CardSeries/CardViewSeriesTextView.dart';
import 'package:one/Views/MyBehavior.dart';
import 'package:one/Views/SBImage.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/config.dart';
import 'package:one/utils/zeus_kit/utils/zk_common_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nav_router/nav_router.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:provider/provider.dart';

/// 发布商品
class AddGoodsViewController extends StatefulWidget {
  static String routeName = "me/preferences/uploadIssued";

  @override
  _AddGoodsViewControllerState createState() => _AddGoodsViewControllerState();
}

class _AddGoodsViewControllerState extends State<AddGoodsViewController> {
//  CategoryGoodsModel category;

  int index = 0;
  String title = "";
  String details = "";
  double price = 0.0;

  ShopCategory currentCategory;
  int currentIndex = 0;
  List images = [
    Config.addImage,
    Config.addImage,
    Config.addImage,
    Config.addImage,
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "发布商品",
      actions: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: FlatButton(
            color: Colors.deepOrangeAccent,
            child: Text("发布", style: TextStyle(color: Colors.white)),
            onPressed: () async{
              if (currentCategory == null) {
                ZKCommonUtils.showToast("请选择分类");
                return;
              }
              if (title.length <= 0) {
                ZKCommonUtils.showToast("缺少标题");
                return;
              }
              List _imags = [];
              images.map((e) {
                if (!e.contains(Config.addImage)) {
                  _imags.add(e.substring(Config.BASE_URL.length, e.length));
                }
              }).toList();

              if (_imags.length < 1) {
                ZKCommonUtils.showToast("请添加商品图");
                return;
              }

              if (details.length <= 0) {
                ZKCommonUtils.showToast("缺少商品介绍");
                return;
              }
              if (price == 0.0) {
                ZKCommonUtils.showToast("请给商品开个价");
                return;
              }
              var arguments = {
                "tid" : currentCategory.id,
                "images" : _imags,
                "name" : title,
                "text" : details,
                "price" : price,
              };
              print(arguments);
              if (await ShopManager.arrProducts(arguments)) {
                pop();
              }
            },
          ),
        )
      ],
      child: Consumer<ShopManager>(builder: (_, provider, chld) {
        return CardSettings(
          cardElevation: 0.0,
          // padding: 0.0,
          children: <Widget>[
            CardViewSeriesRight(
              title: "商品类型",
              subtitle: currentCategory != null ? currentCategory.name : "点击选择",
              isNotNull: true,
              onTap: () async {
                List categorylist = await ShopManager.categorylist();

                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (c) {
                    return DraggableScrollableSheet(
                      initialChildSize: 1.0,
                      maxChildSize: 1.0,
                      minChildSize: 0.5,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          color: Colors.white,
                          child: StatefulBuilder(
                            builder: (BuildContext context2, setter) {
                              return CardRefresherListView(
                                itemCount: categorylist.length,
                                itemBuilder: (_, index) {
                                  ShopCategory category = categorylist[index];

                                  return Column(
                                    children: <Widget>[
                                      InkWell(
                                          child: ListTile(
                                            title: Text(category.name),
                                            trailing:
                                                Icon(Icons.panorama_fish_eye),
                                          ),
                                          onTap: () {
                                            /// 搜索职位
                                            currentCategory = category;
                                            setState(() {});
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
              },
            ),
            CardViewSeriesText(
              title: "标题",
              placeholder: "标题名称",
              isNotNull: true,
              onChanged: (value) {
                title = value;
                setState(() {

                });
              },
            ),
            CardViewSeriesTextView(
              title: "介绍",
              placeholder: "宝贝介绍...",
              text: details.length > 0 ? "${details}¥" : null,
              isNotNull: true,
              valueChanged: (value) {
                setState(() {
                  details = value;
                });
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
                          child: Text("实物图",
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
                              "首张图片为封面",
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
                                          title: Text('上传头像', style: TextStyle(fontSize: 14)), //标题
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
            CardViewSeriesNumber(
              title: "价格",
              isNotNull: true,
              placeholder: "开个价",
              onChanged: (value) {
                var onePointOne = double.parse(value);
                print(onePointOne);
                price = onePointOne;
                setState(() {});
              },
            ),
          ],
        );
      }),
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
