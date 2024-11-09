import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upskill/course.dart';
import 'package:upskill/nav_bar.dart';
import 'package:upskill/profile.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dashboard.dart';
import 'dialog.dart';
import 'errorpage.dart';
import 'floating_button.dart';
import 'homepage.dart';

void initState() {
  controllerr_blog = WebViewController();
  controllerr_blog.clearCache();

  // ..loadRequest(Uri.parse('https://www.upskillcampus.com/'));
  //dynamic super.initState();
}

Future<void> _onLoadHtmlStringExample() {
  return controllerr_blog.loadHtmlString(kLocalExamplePage);
}

class blog extends StatefulWidget {
  const blog({super.key});

  @override
  State<blog> createState() => _HomePageState();
}

int _selectedIndex = 0;
const List<Widget> _widgetOptions = <Widget>[
  HomePage(),
  Course(),
  DashBoard(),
  Profile()
//    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  //  Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  //   Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
];

class _HomePageState extends State<blog> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: ExpandableFab(children: [
        ActionButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              ////  if(document.data().value[]){
              controllerr_blog.goBack();
            }),
        ActionButton(
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onPressed: () {
            controllerr_blog.goForward();
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.replay,
            color: Colors.white,
          ),
          onPressed: () {
            controllerr_COURSE
                .loadRequest(Uri.parse('https://www.upskillcampus.com/blog'));
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
          child: Stack(
        children: [
          WillPopScope(
              onWillPop: () async {
                if (await controllerr_blog.canGoBack()) {
                  controllerr_blog.goBack();
                  return false;
                } else {
                  return true;
                }
              },
              child: WebViewWidget(controller: controllerr_blog)),
        ],
      )),
    );
  }
}

WebViewController controllerr_blog = WebViewController()
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
        Uri.parse('https://www.upskillcampus.com/blog');
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
  ..loadRequest(Uri.parse("https://www.upskillcampus.com/blog"));
