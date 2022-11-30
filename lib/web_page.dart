import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class wikiPedia extends StatefulWidget {
  final String link;
  const wikiPedia(this.link,{Key? key}) : super(key: key);

  @override
  State<wikiPedia> createState() => _wikiPediaState();
}

class _wikiPediaState extends State<wikiPedia> {
  String initial_link="";
  @override
  void initState() {
    setState(() {
      initial_link=widget.link;
    });
    super.initState();
  }
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(),
        body:
        WebView(
          backgroundColor: Colors.cyan,
          zoomEnabled: true,
          initialUrl: initial_link,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webViewController) {
            _controller=webViewController;
          },
          onPageStarted: (String url){
            Future.delayed(Duration(milliseconds: 500),(){
              _controller.runJavascript("document.getElementsByTagName('header')[0].style.display='none'");
              _controller.runJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
            });

          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(initial_link)) {
              print('blocking navigation to $request}');
              return NavigationDecision.navigate;
            }
            print('allowing navigation to $request');
            return NavigationDecision.prevent;
          },
        )
    );
  }
}