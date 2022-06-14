import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:minimal_app/ui/ui.dart';

class ClientsBackground extends StatelessWidget {
  const ClientsBackground({
    Key? key, 
    required this.child
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                left: -300,
                top: -200.0,
                child: FadeInRight(                  
                  child: ClientCustomPaint.getCustomPainterOne()
                )
              ),
              Positioned(
                right: 0.0,
                top: size.height * 0.3,
                child: FadeInRight(     
                  delay: const Duration(milliseconds: 400),             
                  child: ClientCustomPaint.getCustomPainterFour()
                )
              ),
              Positioned(
                left: 10.0,
                top: size.height * 0.7,
                child: FadeInLeft(
                  delay: const Duration(milliseconds: 800),
                  child: ClientCustomPaint.getCustomPainterTwo()
                )
              ),
              Positioned(
                bottom: 0.0,
                right: -100,
                child: FadeInDown(
                  delay: const Duration(milliseconds: 1200),
                  child: ClientCustomPaint.getCustomPainterThree()
                )
              ),
            ],
          ),
        ),
        child
      ],
    );
  }
}