import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upskill/errorpage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'floating_button.dart';

void initState() {
  controllerr_profile = WebViewController();
  controllerr_profile.clearCache();

  // ..loadRequest(Uri.parse('https://www.upskillcampus.com/'));
  //dynamic super.initState();
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              controllerr_profile.goBack();
            }),
        ActionButton(
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onPressed: () {
            controllerr_profile.goForward();
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.replay,
            color: Colors.white,
          ),
          onPressed: () {
            controllerr_profile.loadRequest(
                Uri.parse('https://learn.upskillcampus.com/s/myprofile'));
          },
        ),
      ], distance: 120),
      // appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: SafeArea(
          child: WillPopScope(
              onWillPop: () async {
                if (await controllerr_profile.canGoBack()) {
                  controllerr_profile.goBack();
                  return false;
                } else {
                  return true;
                }
              },
              child: WebViewWidget(controller: controllerr_profile))),
    );
  }
}

WebViewController controllerr_profile = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {
        Uri.parse('https://learn.upskillcampus.com/s/myprofile');
      },
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {
        Future<void> _onLoadHtmlStringExample() {
          return controllerr_profile.loadHtmlString(kLocalExamplePage);
        }
      },
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://learn.upskillcampus.com/s/myprofile'));
