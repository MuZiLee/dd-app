import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';


enum CardFavoriteType {

  link

}

class CardViewSeriesFavorite extends StatefulWidget {

  final String image;
  final String title;
  final String subtitle;
  String timestamp;
  final String frome;
  final int type;
  final String id;
  final GestureTapCallback onTap; //把自己返回

  CardViewSeriesFavorite({
    this.image,
    this.title = "Title",
    this.subtitle = "subtitle",
    this.timestamp,
    this.frome,
    this.type = 2,
    this.onTap,
    this.id = "0",
  });

  @override
  _CardViewSeriesFavoriteState createState() => _CardViewSeriesFavoriteState();
}

class _CardViewSeriesFavoriteState extends State<CardViewSeriesFavorite> {

  String favoriteType = "职位收藏";

  @override
  void initState() {

    if (widget.type == 2) {
      favoriteType = "职位收藏";
    } else {
      favoriteType = "涨知识";
    }


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 5, right: 10),
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        color: Colors.black12,
                        padding:widget.image != null ? null : EdgeInsets.all(10),
                        child: widget.image != null ? Image.network(widget.image, fit: BoxFit.cover) : Icon(Icons.insert_link, color: Colors.black54),
                        width: 48,
                        height: 58),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text(widget.title,
                              maxLines: 1,
                              style: TextStyle(color: Colors.black, fontSize: 14)),
                          Text(
                              widget.subtitle,
                              maxLines: 2,
                              style: TextStyle(color: Colors.black38, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.timestamp,
                        style: TextStyle(color: Colors.black38, fontSize: 10),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "类型:${favoriteType}",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.black38, fontSize: 10),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
