import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:minimal_app/ui/ui.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({
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
                left: 50.0,
                top: -40.0,
                child: FadeInRight(                  
                  child: LoginCustomPaint.getCustomPainterOne()
                )
              ),
              Positioned(
                left: 10.0,
                top: size.height * 0.4,
                child: FadeInLeft(
                  delay: const Duration(milliseconds: 400),
                  child: LoginCustomPaint.getCustomPainterTwo()
                )
              ),
              Positioned(
                bottom: 0.0,
                child: FadeInDown(
                  delay: const Duration(milliseconds: 800),
                  child: LoginCustomPaint.getCustomPainterThree()
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