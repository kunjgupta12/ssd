import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upskill/course.dart';
import 'package:upskill/nav_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dialog.dart';
import 'errorpage.dart';
import 'floating_button.dart';

void initState() {
  controllerr_publicforum = WebViewController();
  controllerr_publicforum.clearCache();

  // ..loadRequest(Uri.parse('https://www.upskillcampus.com/'));
  //dynamic super.initState();
}

int _selectedIndex = 0;

Future<void> _onLoadHtmlStringExample() {
  return controllerr_publicforum.loadHtmlString(kLocalExamplePage);
}

class publicforum extends StatefulWidget {
  const publicforum({super.key});

  @override
  State<publicforum> createState() => _HomePageState();
}

class _HomePageState extends State<publicforum> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      floatingActionButton: ExpandableFab(children: [
        ActionButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              ////  if(document.data().value[]){
              controllerr_publicforum.goBack();
            }),
        ActionButton(
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onPressed: () {
            controllerr_publicforum.goForward();
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.replay,
            color: Colors.white,
          ),
          onPressed: () {
            controllerr_publicforum.loadRequest(
                Uri.parse('https://learn.upskillcampus.com/s/referandearn'));
          },
        ),
      ], distance: 120),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: <NavigationDestination>[
          NavigationDestination(
            // selectedIcon: Icon(Icons.person),
            icon: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyNavigationBar()));
                },
                child: Image.asset('assets/home.png')),
            label: 'Home',
          ),
          NavigationDestination(
            // selectedIcon: Icon(Icons.engineering),
            icon: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyNavigationBar()));
                },
                child: Image.asset('assets/e-learning.png')),

            label: 'Courses',
          ),
          NavigationDestination(
            //selectedIcon: Icon(Icons.bookmark),
            icon: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyNavigationBar()));
                },
                child: Image.asset('assets/chart-histogram.png')),
            label: 'Dashboard',
          ),
          NavigationDestination(
            label: 'Profile',
            //  selectedIcon: Icon(Icons.bookmark),
            icon: IconButton(
              onPressed: () {
                if (_selectedIndex == 3) {
                  customShowDialog(context);
                }
              },
              icon: Image.asset('assets/square-plus 1.png'),
            ),
          ),
        ],
      ),

      // appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: SafeArea(
          child: WillPopScope(
        onWillPop: () async {
          if (await controllerr_publicforum.canGoBack()) {
            controllerr_publicforum.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: Stack(
          children: [
            WebViewWidget(controller: controllerr_publicforum),
          ],
        ),
      )),
    );
  }
}

WebViewController controllerr_publicforum = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //..enableZoom(true)

  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onUrlChange: (change) {
        //  Uri.parse('https://www.upskillcampus.com/login');
      },
      onPageStarted: (String url) {
        // setStae((AboutDialog))
        //controllerr.reload();
        Uri.parse('https://www.forum.upskillcampus.com/');
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
  ..loadRequest(Uri.parse("https://www.forum.upskillcampus.com/"));
