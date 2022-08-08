import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../utils/shared.dart';

class LargeScreenImage extends StatefulWidget {
  final String? image;

  const LargeScreenImage({Key? key, this.image}) : super(key: key);

  @override
  State<LargeScreenImage> createState() => _LargeScreenImageState();
}

class _LargeScreenImageState extends State<LargeScreenImage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: () {
            return Future.value(true);
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: black,
            ),
            body: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                decoration: BoxDecoration(
                  color: black,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(widget.image!),
                  )
                ),
              ),
            ),
          ),
        );
  }

}

