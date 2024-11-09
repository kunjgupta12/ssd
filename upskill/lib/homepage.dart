import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upskill/floating_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'errorpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey webViewKey = GlobalKey();

  late InAppWebViewController control;
  final ReceivePort _port = ReceivePort();
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    Permission.storage.request();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (kDebugMode) {
        print("Download progress: $progress%");
      }
      if (status == DownloadTaskStatus.complete) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Download $id completed!"),
        ));
      }
    });
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

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
              control.goBack();
            }),
        ActionButton(
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          onPressed: () {
            control.goForward();
          },
        ),
        ActionButton(
          icon: const Icon(
            Icons.replay,
            color: Colors.white,
          ),
          onPressed: () {
            control.reload();
          },
        ),
      ], distance: 120),
      /*     appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              await control.loadUrl(
                  urlRequest: URLRequest(
                      url: WebUri(
                          "                    https://www.w3schools.com/tags/tryit.asp?filename=tryhtml5_a_download")));
            },
            icon: Icon(Icons.abc))
      ]),*/
      body: SafeArea(
          child: WillPopScope(
        onWillPop: () async {
          if (await control.canGoBack()) {
            control.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: InAppWebView(
          key: webViewKey,
          initialUrlRequest:
              URLRequest(url: WebUri('https://www.upskillcampus.com/')),
          onWebViewCreated: (InAppWebViewController controller) {
            control = controller;
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
              final shouldPerformDownload =
                  navigationAction.shouldPerformDownload ?? false;
              final url = navigationAction.request.url;
              if (shouldPerformDownload && url != null) {
                await downloadFile(url.toString());
                return NavigationActionPolicy.DOWNLOAD;
              }
            }
            return NavigationActionPolicy.ALLOW;
          },
          onDownloadStartRequest: (controller, url) async {
            print("Download Start: $url");

            // You can add logic here to filter specific file types or URLs
            // For simplicity, we'll download any file for this example
            final fileName = Uri.parse('$url').pathSegments.last;
            /*  try {
              // Download the file using the dio package
              await _dio.download('$url', url.suggestedFilename);

              // Display a notification or perform additional actions as needed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("File downloaded successfully"),
                ),
              );
            } catch (e) {
              print("Error downloading file: $e");
            }*/
            // Download the file using Flutter's dio package or any other download method
            // For simplicity, we'll use the in_app_webview plugin's download method

            // Display a notification or perform additional actions as needed
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File downloaded successfully"),
              ),
            );
            await downloadFile(url.url.toString(), url.suggestedFilename);
          },
          onReceivedHttpError: (controller, request, error) {
            var isForMainFrame = request.isForMainFrame ?? false;
            if (!isForMainFrame) {
              return;
            }
            control.loadData(data: kLocalExamplePage);
            final snackBar = SnackBar(
              content: Text(
                  'HTTP error for URL: ${request.url} with Status: ${error.statusCode} ${error.reasonPhrase ?? ''}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          onReceivedError: (controller, request, error) async {
            // Handle web page loading errors here
            control.loadData(data: kLocalExamplePage);
          },
        ),
      )),
    );
  }

  Future<void> downloadFile(String url, [String? filename]) async {
    var hasStoragePermission = await Permission.storage.isGranted;
    if (!hasStoragePermission) {
      final status = await Permission.storage.request();
      hasStoragePermission = status.isGranted;
    }
    if (hasStoragePermission) {
      final taskId = await FlutterDownloader.enqueue(
          url: url,
          headers: {},
          // optional: header send with url (auth token etc)
          savedDir: (await getTemporaryDirectory()).path,
          saveInPublicStorage: true,
          fileName: filename);
    }
  }
}
