import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CardRefresher extends StatefulWidget {
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final Widget child;
  final Widget header = MaterialClassicHeader(distance: 80.0);
  RefreshController refreshController;

  CardRefresher({
    this.onRefresh,
    this.onLoading,
    this.child,
    header,
    this.refreshController,
  }) {
    if (this.refreshController == null) {
      this.refreshController = RefreshController(initialRefresh: true);
    }
  }

  @override
  _CardRefresherState createState() => _CardRefresherState();
}

class _CardRefresherState extends State<CardRefresher> {


  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: widget.header,
      footer: widget.onLoading != null
          ? MaterialClassicHeader(distance: 80.0)
          : null,
      controller: widget.refreshController,
      onRefresh: _onRefresh,
      onLoading: widget.onLoading != null ? _onLoading : null,
      child: widget.child,
    );
  }

  _onRefresh() async {
    if (widget.onRefresh != null) {
      widget.onRefresh();
    }
    await Future.delayed(Duration(milliseconds: 500));
    widget.refreshController.refreshCompleted();
  }

  _onLoading() async {
    if (widget.onLoading != null) {
      widget.onLoading();
    }
    await Future.delayed(Duration(milliseconds: 500));
    widget.refreshController.refreshCompleted();
  }
}
