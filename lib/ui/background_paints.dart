import 'dart:ui';

import 'package:flutter/material.dart';

class LoginCustomPaint {

  static Widget getCustomPainterOne() {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 60.0),
      child: CustomPaint(        
        size: const Size(
          400.0,
          500.0
        ),
        painter: CustomPainterOne(),
      ),
    );
  }

  static Widget getCustomPainterTwo() {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
      child: CustomPaint(        
        size: const Size(
          100.0,
          300.0
        ),
        painter: CustomPainterTwo(),
      ),
    );
  }

  static Widget getCustomPainterThree() {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
      child: CustomPaint(        
        size: const Size(
          500.0,
          300.0
        ),
        painter: CustomPainterThree(),
      ),
    );
  }

}

class CustomPainterOne extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
            
    Path path = Path();
    path.moveTo(size.width*0.8346179,size.height*-0.04702057);
    path.cubicTo(size.width*0.9789402,size.height*-0.06035573,size.width*1.128944,size.height*-0.1497453,size.width*1.250774,size.height*-0.08764766);
    path.cubicTo(size.width*1.378711,size.height*-0.02243581,size.width*1.401708,size.height*0.1190526,size.width*1.394887,size.height*0.2385562);
    path.cubicTo(size.width*1.388372,size.height*0.3527526,size.width*1.317638,size.height*0.4555182,size.width*1.215140,size.height*0.5368281);
    path.cubicTo(size.width*1.111930,size.height*0.6187057,size.width*0.9791229,size.height*0.7034818,size.width*0.8346179,size.height*0.6830130);
    path.cubicTo(size.width*0.6975781,size.height*0.6635990,size.width*0.6550897,size.height*0.5322865,size.width*0.5705847,size.height*0.4455182);
    path.cubicTo(size.width*0.5046910,size.height*0.3778568,size.width*0.4134950,size.height*0.3231823,size.width*0.4017674,size.height*0.2385562);
    path.cubicTo(size.width*0.3888704,size.height*0.1455013,size.width*0.4148704,size.height*0.04142188,size.width*0.5062292,size.height*-0.01885305);
    path.cubicTo(size.width*0.5938106,size.height*-0.07663464,size.width*0.7209336,size.height*-0.03651615,size.width*0.8346179,size.height*-0.04702057);
    path.close();

    Paint paint = Paint()..style=PaintingStyle.fill;
    paint.color = const Color(0xffE4F353).withOpacity(1.0);
    canvas.drawPath(path,paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}

class CustomPainterTwo extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
            
    Path path = Path();
    path.moveTo(size.width*-0.1381116,size.height*0.2639610);
    path.cubicTo(size.width*0.03230736,size.height*0.2545761,size.width*0.2094372,size.height*0.1916653,size.width*0.3532959,size.height*0.2353683);
    path.cubicTo(size.width*0.5043694,size.height*0.2812633,size.width*0.5315231,size.height*0.3808405,size.width*0.5234711,size.height*0.4649459);
    path.cubicTo(size.width*0.5157769,size.height*0.5453127,size.width*0.4322529,size.height*0.6176371,size.width*0.3112190,size.height*0.6748649);
    path.cubicTo(size.width*0.1893446,size.height*0.7324865,size.width*0.03252132,size.height*0.7921506,size.width*-0.1381116,size.height*0.7777452);
    path.cubicTo(size.width*-0.2999347,size.height*0.7640811,size.width*-0.3501066,size.height*0.6716680,size.width*-0.4498901,size.height*0.6106023);
    path.cubicTo(size.width*-0.5277008,size.height*0.5629846,size.width*-0.6353884,size.height*0.5245019,size.width*-0.6492372,size.height*0.4649459);
    path.cubicTo(size.width*-0.6644653,size.height*0.3994556,size.width*-0.6337645,size.height*0.3262054,size.width*-0.5258843,size.height*0.2837849);
    path.cubicTo(size.width*-0.4224669,size.height*0.2431193,size.width*-0.2723562,size.height*0.2713541,size.width*-0.1381116,size.height*0.2639610);
    path.close();

    Paint paint = Paint()..style=PaintingStyle.fill;
    paint.color = const Color(0xffE4F353).withOpacity(0.33);
    canvas.drawPath(path,paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}

class CustomPainterThree extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
            
    Path path = Path();
    path.moveTo(size.width*0.3877436,size.height*0.5391161);
    path.cubicTo(size.width*0.4991308,size.height*0.5199363,size.width*0.6149026,size.height*0.3913783,size.width*0.7089308,size.height*0.4806854);
    path.cubicTo(size.width*0.8076718,size.height*0.5744757,size.width*0.8254205,size.height*0.7779625,size.width*0.8201564,size.height*0.9498352);
    path.cubicTo(size.width*0.8151282,size.height*1.114071,size.width*0.7605359,size.height*1.261869,size.width*0.6814282,size.height*1.378809);
    path.cubicTo(size.width*0.6017718,size.height*1.496566,size.width*0.4992718,size.height*1.618491,size.width*0.3877436,size.height*1.589052);
    path.cubicTo(size.width*0.2819769,size.height*1.561131,size.width*0.2491838,size.height*1.372277,size.width*0.1839651,size.height*1.247487);
    path.cubicTo(size.width*0.1331077,size.height*1.150176,size.width*0.06272282,size.height*1.071543,size.width*0.05367103,size.height*0.9498352);
    path.cubicTo(size.width*0.04371795,size.height*0.8160037,size.width*0.06378436,size.height*0.6663146,size.width*0.1342951,size.height*0.5796255);
    path.cubicTo(size.width*0.2018890,size.height*0.4965243,size.width*0.3000026,size.height*0.5542247,size.width*0.3877436,size.height*0.5391161);
    path.close();

    Paint paint = Paint()..style=PaintingStyle.fill;
    paint.color = const Color(0xffE4F353).withOpacity(0.3);
    canvas.drawPath(path,paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}
