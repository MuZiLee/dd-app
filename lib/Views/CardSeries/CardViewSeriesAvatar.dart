
import 'dart:io';
import 'package:demo2020/Provider/StaffManager.dart';
import 'package:demo2020/utils/zeus_kit/zeus_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:path_provider/path_provider.dart';

import '../../config.dart';

class CardViewSeriesAvatar extends StatefulWidget {

  final String title;
  final String avatar;
  final bool isNotNull;
  final Function(String, String) onChanged; /// 返回选择的头 base64 字符串
  final ValueChanged<String> valueChanged;
  CardViewSeriesAvatar({
    this.title = "",
    this.avatar = "images/Avatar/avatar.png",
    this.isNotNull = false,
    this.onChanged,
    this.valueChanged
  });

  @override
  _CardViewSeriesAvatarState createState() => _CardViewSeriesAvatarState();
}
const String card_series_default_avatar = "images/Avatar/avatar.png";
class _CardViewSeriesAvatarState extends State<CardViewSeriesAvatar> {

  Widget image;

  @override
  Widget build(BuildContext context) {

    if (image == null) {
      if (widget.avatar.contains("http")) {
        image = Image.network(widget.avatar, width: 58, height: 58, fit: BoxFit.cover);
      } else if (widget.avatar.contains(card_series_default_avatar)) {
        image = Image.asset(widget.avatar, width: 58, height: 58, fit: BoxFit.cover);
      } else {
        image = Image.file(File(widget.avatar), width: 58, height: 58, fit: BoxFit.cover);
      }
    }

    return InkWell(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 10,top: 10, bottom: 10),
                    child: Text(widget.title,
                        style: TextStyle(fontSize: 14, color: Colors.black))),
                widget.isNotNull == true ? Text("*", style: TextStyle(color: Colors.red)) : Container(),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(10.0),
                            child: ClipRRect(
                                child: image, borderRadius: BorderRadius.all(Radius.circular(100.0))),
                        )
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.chevron_right),
                )
              ],
            ),
            Divider(height: 1)
          ],
        ),
      ),
      onTap: (){

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
  }

  Future<void> retrieveLostData() async {
    Navigator.of(context).pop();

    // ignore: deprecated_member_use
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    print(imageFile.path);
    Progresshud.show();
    ZKCommonUtils.showToast("开始压缩图片");
    var tmpimage = await compressImage(imageFile);
    ZKCommonUtils.showToast("开始上传图片");
    var url = await StaffManager.uploadImage(tmpimage);
    Progresshud.dismiss();
    image = Image.network(Config.BASE_URL+url, width: 58, height: 58, fit: BoxFit.cover);
    setState(() {
      widget.valueChanged(url);
    });

  }

  Future<void> cameraLostData() async {
    Navigator.of(context).pop();

    // ignore: deprecated_member_use
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    print(imageFile.path);
    Progresshud.show();
    ZKCommonUtils.showToast("开始压缩图片");
    var tmpimage = await compressImage(imageFile);
    ZKCommonUtils.showToast("开始上传图片");
    var url = await StaffManager.uploadImage(tmpimage);
    Progresshud.dismiss();
    image = Image.network(Config.BASE_URL+url, width: 58, height: 58, fit: BoxFit.cover);
    setState(() {
      widget.valueChanged(url);
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

  // /--------------------


}
