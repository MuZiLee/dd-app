

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardChatTableViewCell extends StatefulWidget {

  final String title;
  final String subTitle;
  final String avatar;
  final Widget trailing;
  final GestureTapCallback onTap;
  final GestureTapCallback onAvatarTap;
  CardChatTableViewCell({this.avatar, this.title = "title", this.subTitle = "subTitle", this.trailing, this.onTap, this.onAvatarTap});

  @override
  _CardChatTableViewCellState createState() => _CardChatTableViewCellState();
}

class _CardChatTableViewCellState extends State<CardChatTableViewCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: ListTile(
                leading: ClipOval(
                  child: InkWell(
                    child: Container(
                      height: 48, width: 48,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: ExactAssetImage("images/Avatar/avatar.png")),
                        color: Colors.deepOrange,
                      ),
                      child: widget.avatar != null ? _image() : null,
                    ),
                    onTap: widget.onAvatarTap,
                  ),
                ),
                title: Text(widget.title),
                subtitle: Text(widget.subTitle, style: TextStyle(fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                trailing: widget.trailing != null ? Container(
                  width: 38,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: widget.trailing,
                      )
                    ],
                  ),
                ) : Icon(Icons.chevron_right, size: 21),
                onTap: widget.onTap,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5, child: Container(color: Colors.grey[100])),
      ],
    );
  }

  _image() {
    if (widget.avatar.contains("http://")) {
      return Image.network(widget.avatar, fit: BoxFit.cover);
    } else {
      return Image.asset(widget.avatar, fit: BoxFit.cover);
    }
  }

}
