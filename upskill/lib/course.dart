import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'errorpage.dart';
import 'floating_button.dart';

void initState() {
  controllerr_COURSE = WebViewController();
  controllerr_COURSE.clearCache();

  // ..loadRequest(Uri.parse('https://www.upskillcampus.com/'));
  //dynamic super.initState();
}

Future<void> _onLoadHtmlStringExample() {
  return controllerr_COURSE.loadHtmlString(kLocalExamplePage);
}

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
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
              controllerr_COURSE.goBack();
            }),
        ActionButton(
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onPressed: () {
            controllerr_COURSE.goForward();
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.replay,
            color: Colors.white,
          ),
          onPressed: () {
            controllerr_COURSE.loadRequest(
                Uri.parse('https://learn.upskillcampus.com/s/store'));
          },
        ),
      ], distance: 120),
      // appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: SafeArea(
          child: WillPopScope(
              onWillPop: () async {
                if (await controllerr_COURSE.canGoBack()) {
                  controllerr_COURSE.goBack();
                  return false;
                } else {
                  return true;
                }
              },
              child: WebViewWidget(controller: controllerr_COURSE))),
    );
  }
}

WebViewController controllerr_COURSE = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onUrlChange: (change) {},
      onPageFinished: (String url) {
        Uri.parse('https://www.upskillcampus.com/');
      },
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
  ..loadRequest(Uri.parse('https://learn.upskillcampus.com/s/store'));
