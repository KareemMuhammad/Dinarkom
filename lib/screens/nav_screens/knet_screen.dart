import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/shared.dart';

class KeyNetScreen extends StatefulWidget {
  final String? url;
  const KeyNetScreen({Key? key, required this.url}) : super(key: key);

  @override
  _KeyNetScreenState createState() => _KeyNetScreenState();
}

class _KeyNetScreenState extends State<KeyNetScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.url);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: light,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: white,
        title: header('Checkout'),
      ),
      body: Builder(builder: (BuildContext context) {
        return widget.url == 'You Cannot buy this photo again!'?
          Center(
            child: header(widget.url!),
          )
            :WebView(
          initialUrl: widget.url,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (_) async{
          var control = await _controller.future;
          control.currentUrl().then(
                  (url) {
                if (url!.contains("NOT CAPTURED")) {
                  control.clearCache();
                  Navigator.pop(context);
                }
              },
            );
          },
        );
      }),
    );
  }

  Widget header(String text){
    return Text(text,style:
    TextStyle(color: light, fontSize: SizeConfig.blockSizeVertical! * 3,
        fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
  }

}
