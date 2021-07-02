
import 'package:flutter/material.dart';


class CardNavBarMenuItem extends StatefulWidget {

  final List<NavBarMenuItemModel> items;
  final Function(int value) onSelected;
  CardNavBarMenuItem({
    this.items,
    this.onSelected
  });

  @override
  _CardNavBarMenuItemState createState() => _CardNavBarMenuItemState();
}

class _CardNavBarMenuItemState extends State<CardNavBarMenuItem> {


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (BuildContext context) {


      List<PopupMenuItem<int>> items = [];
      for (int index = 0; index < widget.items.length; index++) {
        NavBarMenuItemModel model = widget.items[index];
        items.add(popupMenuItem(index, model));
      }
      return items;
    }, onSelected: widget.onSelected);
  }

  PopupMenuItem<int> popupMenuItem(int index, NavBarMenuItemModel item) {
    return PopupMenuItem<int>(
        child: Row(
          children: <Widget>[
            Icon(item.icon, size: 18),
            SizedBox(width: 10),
            Text(item.title, style: TextStyle(fontSize: 14)),
          ],
        ),
        value: index);
  }

}


class NavBarMenuItemModel {
  final IconData icon;
  final String   title;
  NavBarMenuItemModel({this.icon, this.title});
}