import 'dart:io';

import 'package:one/Views/CardSeries/CardRefresherGridView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CardViewSeriesImages extends StatefulWidget {
  final String title;
  final String placeholder;
  final bool isNotNull;
  final ValueChanged valueOnTap;
  final ValueChanged indexOnTap;
  Color color = Colors.grey[100];

  CardViewSeriesImages(
      {this.title = "Title",
      this.placeholder = "支持4张",
      this.valueOnTap,
      this.indexOnTap,
      this.isNotNull = false,
      this.color}) {

  }

  @override
  _CardViewSeriesImagesState createState() => _CardViewSeriesImagesState();
}

class _CardViewSeriesImagesState extends State<CardViewSeriesImages> {

  List<dynamic> items = [
    "images/addImage.png",
    "images/addImage.png",
    "images/addImage.png",
    "images/addImage.png"
  ];
  List<dynamic> images = [];

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Text(widget.title,
                      style: TextStyle(fontSize: 14, color: Colors.black, decoration: TextDecoration.none)),
                ),
                widget.isNotNull == true
                    ? Text("*", style: TextStyle(color: Colors.red, decoration: TextDecoration.none))
                    : Container(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      widget.placeholder,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 10, color: Colors.black38, decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 10),
              child: CardRefresherGridView(
                itemCount: 4,
                itemBuilder: (_, index) {

                  String url = items[index];
                  
                  return Container(
                    width: 58.0,
                    height: 58.0,
                    child: FlatButton(
                      child: url.startsWith("http") ? Image.network(url, fit: BoxFit.cover) : Image.asset(url, fit: BoxFit.cover),
                      onPressed: () {
                        if (widget.indexOnTap != null) {
                          widget.indexOnTap(index);
                        }
                        retrieveLostData(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(height: 1)
        ],
      ),
    );
  }

  Future<void> retrieveLostData(int index) async {

    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }



//    Provider.of<UploadManager>(context).uploadImage(file: image, valueChanged: (url) {
//      items.insert(0, kURL + '/' + url);
//      items.sort();
//      items.removeRange(items.length-1, items.length);
//      setState(() {
//        if (widget.valueOnTap != null) {
//          widget.valueOnTap(url);
//        }
//      });
//    });

  }

}
