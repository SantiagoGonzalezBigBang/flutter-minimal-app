import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MinimalLogo extends StatelessWidget {
  const MinimalLogo({
    Key? key, 
    this.size = 120.0,
  }) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      height: size,
      image: const AssetImage('assets/logo.png')
    );
  }

}