

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Webviewscreen extends StatelessWidget {

  final url;
  Webviewscreen(this.url);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: WebView(
      //   initialUrl: url,
      // ),
    );
  }
}
