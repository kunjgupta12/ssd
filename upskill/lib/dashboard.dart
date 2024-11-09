import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'errorpage.dart';
import 'floating_button.dart';

void initState() {
  controllerr_dashboard = WebViewController();
  controllerr_dashboard.clearCache();

  // ..loadRequest(Uri.parse('https://www.upskillcampus.com/'));
  //dynamic super.initState();
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

Future<void> _onLoadHtmlStringExample() {
  return controllerr_dashboard.loadHtmlString(kLocalExamplePage);
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ExpandableFab(children: [
        ActionButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              ////  if(document.data().value[]){
              controllerr_dashboard.goBack();
            }),
        ActionButton(
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onPressed: () {
            controllerr_dashboard.goForward();
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.replay,
            color: Colors.white,
          ),
          onPressed: () {
            controllerr_dashboard.loadRequest(
                Uri.parse('https://learn.upskillcampus.com/s/mycourses'));
          },
        ),
      ], distance: 120),
      // appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: SafeArea(
          child: WillPopScope(
              onWillPop: () async {
                if (await controllerr_dashboard.canGoBack()) {
                  controllerr_dashboard.goBack();
                  return false;
                } else {
                  return true;
                }
              },
              child: WebViewWidget(controller: controllerr_dashboard))),
    );
  }
}

WebViewController controllerr_dashboard = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {
        Uri.parse('https://www.upskillcampus.com/');
      },
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {
        _onLoadHtmlStringExample();
      },
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://learn.upskillcampus.com/s/mycourses'));
