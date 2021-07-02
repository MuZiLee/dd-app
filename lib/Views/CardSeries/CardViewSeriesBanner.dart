
import 'package:one/Views/SBImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardViewSeriesBanner extends StatefulWidget {

  final List urls;
  final SwiperOnTap onTap;
  CardViewSeriesBanner({this.urls,this.onTap});

  @override
  _CardViewSeriesBannerState createState() => _CardViewSeriesBannerState();
}

class _CardViewSeriesBannerState extends State<CardViewSeriesBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Swiper(
        itemCount: widget.urls.length,
        autoplay: true,
        onTap: (index){
          if (widget.onTap != null) {
            widget.onTap(index);
          }
        },
        onIndexChanged: (index){

        },
        scrollDirection: Axis.horizontal,
//        pagination: new SwiperPagination(
//          builder: DotSwiperPaginationBuilder(
//            color: Colors.white54,
//            activeColor: Colors.deepOrange,
//          ),
//        ),
        itemBuilder: (ctx, index) {

          return SBImage(
            url: widget.urls[index].image
          );
        },
      ),
    );
  }
}
