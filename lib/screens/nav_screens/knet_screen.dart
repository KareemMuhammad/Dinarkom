import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/constants.dart';
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
        title: header('${Utils.getTranslatedText(context, 'checkout')}'),
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
          onPageFinished: (url) async{
                if (url.contains("result=CAPTURED")) {
               //   log('success ' + url.toString());
                  await Utils.showSnack('', '${Utils.getTranslatedText(context, 'invoice_hint')}', context, Colors.black);
                  Navigator.pop(context);
                }else{
                  log('failed ' + url.toString());
                }
              },
            );
          },
        )
    );
  }

  Widget header(String text){
    return Text(text,style:
    TextStyle(color: light, fontSize: SizeConfig.blockSizeVertical! * 3,
        fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
  }

}
