import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:newsapp/constant/objects.dart';

class MyAboutScreen extends StatelessWidget {
  const MyAboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "About",
            style: textStyle.h5BText(context),
          ),
        ),
        body: Container(
          child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse('http://localhost:8080/assets/html/term.html'),
            ),
          ),
        ),
      ),
    );
  }
}
