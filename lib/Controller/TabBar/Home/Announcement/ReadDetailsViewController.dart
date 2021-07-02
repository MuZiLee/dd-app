
import 'package:one/Model/ArticlesModel.dart';
import 'package:one/Views/bases/BaseScaffold.dart';
import 'package:one/config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadDetailsViewController extends StatefulWidget {
  static const routeName = "/tabbar/home/ReadDetails";

  int id = 0;
  String title = "";
  ReadDetailsViewController(this.id, this.title);

  @override
  _ReadDetailsViewControllerState createState() => _ReadDetailsViewControllerState();
}

class _ReadDetailsViewControllerState extends State<ReadDetailsViewController> {



  @override
  Widget build(BuildContext context) {

    var url = Config.BASE_URL + "/aritcle/aritcleRead.html?id=${widget.id}";
    print(url);
    return BaseScaffold(
      title: widget.title,
      elevation: 0.0,
      child: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true,
        userAgent: "User-Agent:Android",
        onPageFinished: (String url) {
          print('页面完成加载: $url');
        },
      ),
    );
  }
}
