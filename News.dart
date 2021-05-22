import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
     WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.zero,
        child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://www.accuweather.com/en/weather-news',
        ));
  }
}

