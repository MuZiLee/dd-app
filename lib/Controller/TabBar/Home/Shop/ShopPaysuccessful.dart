
import 'package:demo2020/Views/404/SuccessfulView.dart';
import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:flutter/cupertino.dart';

class ShopPaysuccessful extends StatefulWidget {
  @override
  _ShopPaysuccessfulState createState() => _ShopPaysuccessfulState();
}

class _ShopPaysuccessfulState extends State<ShopPaysuccessful> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "支付成功",
      elevation: 0.0,
      child: SuccessfulView(text: "支付成功"),
    );
  }
}
