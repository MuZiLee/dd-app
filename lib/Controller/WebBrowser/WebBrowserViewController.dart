//
//  文件名：WebBrowserViewController
//  所在包名：Controller.Start
//  所在项目名称：dandankj_cupertino
//
//  开发者： lee
//  开发时间: 2019-11-02
//  版权所有 © 2019。 保留所有权利
//


import 'dart:async';
import 'dart:io';

import 'package:demo2020/Views/Bases/BaseScaffold.dart';
import 'package:flutter/material.dart';
import 'package:ovprogresshud/progresshud.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBrowserViewController extends StatefulWidget {
  static var routeName = "/launch/web_browser";

  String title = "正在加载...";
  String url = "";
  WebBrowserViewController({this.title, this.url});

  @override
  _WebBrowserViewControllerState createState() => _WebBrowserViewControllerState();
}

class _WebBrowserViewControllerState extends State<WebBrowserViewController> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    if (arguments != null) {
      widget.url = arguments["url"];
      widget.title = arguments["title"];
    }


    return BaseScaffold(
      title: (widget.title != null && widget.title != "") ? widget.title : widget.url,
      child: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: false,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
//       child: WebView(
//         initialUrl: widget.url,
//         javascriptMode: JavascriptMode.disabled,
//         gestureNavigationEnabled: false,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller.complete(webViewController);
//         },
//         javascriptChannels: <JavascriptChannel>[
//           _toasterJavascriptChannel(context),
//         ].toSet(),
//         navigationDelegate: (NavigationRequest request) {
// //          if (request.url.startsWith('https://www.youtube.com/')) {
// //            print('阻止导航到 $request}');
// //            return NavigationDecision.prevent;
// //          }
//           print('导航到 $request');
//           return NavigationDecision.navigate;
//         },
//         onPageStarted: (String url) {
//           print('页面开始装载: $url');
// //          Progresshud.show();
//         },
//         onPageFinished: (String url) {
// //          Progresshud.dismiss();
//           print('页面完成加载: $url');
//         },
//       ),
    );
  }

  // JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  //   return JavascriptChannel(
  //       name: 'Toaster',
  //       onMessageReceived: (JavascriptMessage message) {
  //         print('Javascript $message');
  //         Scaffold.of(context).showSnackBar(
  //           SnackBar(content: Text(message.message)),
  //         );
  //       });
  // }

}
