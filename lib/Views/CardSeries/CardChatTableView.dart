
import 'package:one/Views/CardSeries/expanded_viewport.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CardChatTableView extends StatefulWidget {

  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final int itemCount;
  final bool enablePullDown;
  final bool enablePullUp;
  final bool enableTwoLevel;
  final IndexedWidgetBuilder builder;
  CardChatTableView({
    this.onRefresh,
    this.onLoading,
    this.itemCount = 0,
    this.builder,
    this.enablePullDown = true,
    this.enablePullUp = false,
    this.enableTwoLevel = false,
  });

  @override
  _CardChatTableViewState createState() => _CardChatTableViewState();
}

class _CardChatTableViewState extends State<CardChatTableView> {

  final RefreshController controller = RefreshController(initialRefresh: true);
  final ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      enableTwoLevel: widget.enableTwoLevel,
      controller: controller,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      header: MaterialClassicHeader(),
      footer: CustomFooter(
        loadStyle: LoadStyle.HideAlways,
        builder: (context, mode) {
          if (mode == LoadStatus.loading) {
            return Container(
              height: 64.0,
              child: Container(
                height: 20.0,
                width: 20.0,
                child: CupertinoActivityIndicator(),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      child: Scrollable(
          controller: scrollController,
          axisDirection: AxisDirection.up,
          viewportBuilder: (context, offset) {
            return ExpandedViewport(
              offset: offset,
              axisDirection: AxisDirection.up,
              slivers: <Widget>[
                SliverExpanded(),
                SliverList(delegate: SliverChildBuilderDelegate(widget.builder, childCount: widget.itemCount))
              ],
            );
          }
      )
    );
  }

  _onRefresh() async {
    if (widget.onRefresh != null) {
      widget.onRefresh();
    }
    await Future.delayed(Duration(milliseconds: 600));
    controller.refreshCompleted();
  }

  _onLoading() async {
    if (widget.onLoading != null) {
      widget.onLoading();
    }
    await Future.delayed(Duration(milliseconds: 600));
    controller.refreshCompleted();
  }
}
