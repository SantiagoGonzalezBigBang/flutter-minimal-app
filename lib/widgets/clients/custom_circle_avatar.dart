import 'package:flutter/material.dart';

import 'package:transparent_image/transparent_image.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    Key? key,
    this.radius = 26,
    this.url = ''
  }) : super(key: key);

  final double radius;
  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: url != '' ? FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: url
        ) : Padding(
          padding: const EdgeInsets.all(8.0),
          child: FadeInImage(            
            placeholder: MemoryImage(kTransparentImage),
            height: radius,
            image: const AssetImage('assets/no_image.png')
          ),
        )
      )
    );
  }
}