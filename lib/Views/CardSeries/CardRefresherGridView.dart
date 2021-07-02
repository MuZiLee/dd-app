import 'package:auto_size_text/auto_size_text.dart';
import 'package:one/Views/MyBehavior.dart';
import 'package:one/Views/SBImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardRefresherGridView extends StatefulWidget {
  @required
  IndexedWidgetBuilder itemBuilder;
  @required
  int itemCount;
  EdgeInsetsGeometry padding;
  final int crossAxisCount;
  bool isScrollable = true;

  CardRefresherGridView(
      {this.itemBuilder,
      this.itemCount,
      this.padding,
      this.crossAxisCount = 4,
      this.isScrollable}) {
    if (this.padding == null) {
      this.padding = EdgeInsets.only(top: 10);
    }
  }

  @override
  _CardRefresherGridViewState createState() => _CardRefresherGridViewState();
}

class _CardRefresherGridViewState extends State<CardRefresherGridView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: GridView.builder(
          primary: false,
          padding: EdgeInsets.all(0.0),
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: false,
          physics: widget.isScrollable == true
              ? new NeverScrollableScrollPhysics()
              : null,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount, //横轴三个子widget
              childAspectRatio: 1.2 //宽高比为1时，子widget
              ),
          itemCount: widget.itemCount,
          itemBuilder: widget.itemBuilder,
        ),
      ),
    );
  }
}

class CardRefresherGridViewItem extends StatelessWidget {
  final String url;
  final String title;
  final VoidCallback onTap;

  CardRefresherGridViewItem({this.url, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FlatButton(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            this.url.contains("http")
                ? SBImage(url: this.url)
                : Image.asset(
              this.url,
              width: 28,
              height: 28,
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(this.title,
                  style: TextStyle(fontSize: 12.0),
                  textAlign: TextAlign.center,
                  maxLines: 2),
            ),
          ],
        ),
        onPressed: this.onTap,
      ),
    );
  }
}
