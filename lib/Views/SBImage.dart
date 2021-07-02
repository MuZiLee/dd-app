import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config.dart';


class SBImage extends StatefulWidget {
  String url = "";
  Widget placeholder;
  Widget error = Icon(Icons.error);
  BorderRadius borderRadius;
  GestureTapCallback onTap;
  double width;
  double height;
  BoxFit fit;

  SBImage(
      {Key key,
      this.url,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.placeholder,
      this.error,
      this.borderRadius,
      this.onTap})
      : super(key: key) {
    if (this.borderRadius == null) {
      this.borderRadius = BorderRadius.zero;
    }
  }

  @override
  _SBImageState createState() => _SBImageState();
}

class _SBImageState extends State<SBImage> {
  @override
  Widget build(BuildContext context) {

    Widget image = CachedNetworkImage(
      key: widget.key,
      fit: widget.fit,
      imageUrl: widget.url,
      width: widget.width,
      height: widget.height,
      filterQuality: FilterQuality.high,
      colorBlendMode: BlendMode.screen,
      fadeOutDuration: const Duration(seconds: 0, milliseconds: 0),
      fadeInDuration: const Duration(seconds: 0, milliseconds: 0),
      placeholder: (context, url) => widget.placeholder,
      errorWidget: (context, url, error) => widget.error,
    );



    // Config.LounchImage
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: InkWell(
        onTap: widget.onTap,
        child: image,
      ),
    );
  }
}
