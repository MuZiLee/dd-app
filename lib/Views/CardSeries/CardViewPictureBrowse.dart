

import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yin_drag_sacle/core/drag_scale_widget.dart';

import '../SBImage.dart';

class CardViewPictureBrowse extends StatefulWidget {

  List images = [];
  CardViewPictureBrowse(this.images);

  @override
  _CardViewPictureBrowseState createState() => _CardViewPictureBrowseState();
}

class _CardViewPictureBrowseState extends State<CardViewPictureBrowse> {

  int current = 1;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "${current.toString()}/${widget.images.length.toString()}",
      child: _buildSwiper(context),
    );
  }

  Swiper _buildSwiper(BuildContext context) {
    return new Swiper(
      itemBuilder: (BuildContext context, int index) {
        return DragScaleContainer(
          doubleTapStillScale: true,
          child: SBImage(url: widget.images[index], width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth,),
        );},
      itemCount: widget.images.length,
      autoplay: false,
      containerHeight: MediaQuery.of(context).size.width * 1.5,
      onIndexChanged:(int page) {
        setState(() {
          current = page + 1;
        });
      },
    );
  }

}
