import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_trip_challenger/utils/hex_color.dart';

class CustomPaintPage extends StatefulWidget {
  @override
  _CustomPaintPageState createState() => _CustomPaintPageState();
}

class _CustomPaintPageState extends State<CustomPaintPage> {
  List<ChartData> listData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listData.add(ChartData(hexColor: '#FE7A16', title: 'Cycle', percent: 25));
    listData.add(ChartData(hexColor: '#FFA018', title: 'Run', percent: 40));
    listData.add(ChartData(hexColor: '#FFBBBB', title: 'Sleep', percent: 20));
    listData.add(ChartData(hexColor: '#FFAAAA', title: 'Walk', percent: 15));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: CustomPaint(
            painter: CustomCircle(datas: listData),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class CustomCircle extends CustomPainter {
  final List<ChartData> datas;
  double startAngle = 0;

  CustomCircle({this.datas});

  @override
  void paint(Canvas canvas, Size size) {
    final textBoldStyle = TextStyle(
        color: HexColor('#696969'), fontSize: 15, fontWeight: FontWeight.w500);
    Offset center = Offset(0, 0);
    var rect = Rect.fromCircle(center: center, radius: 100);

    var paintOrangeCircle = Paint()..color = HexColor('#FE7A16');

    var offsetChartData = Offset(0, 0);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(toRadian(-90));

    _drawArc(
      canvas: canvas,
      rect: rect,
      startAngle: 0,
      sweepAngle: 360,
      hexColor: '#6F6F6F',
      strokeWidth: 50,
    );

    //draw chart
    for (int i = 0; i < datas.length; i++) {
//      print('i $i, ${datas[i].hexColor}, ${datas[i].percent},');
      double sweepAngle = 360 * datas[i].percent / 100;

      // draw arc with blur
      _drawArc(
          canvas: canvas,
          rect: rect,
          startAngle: startAngle,
          sweepAngle: sweepAngle,
          hexColor: '#b0ada0',
          blankAngleWithRadian: 0.1,
          strokeWidth: 90,
          blurWidth: 10);
      _drawArc(
        canvas: canvas,
        rect: rect,
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        hexColor: datas[i].hexColor,
        blankAngleWithRadian: 0.1,
        strokeWidth: 90,
      );
      _drawPieChartLabel(
          canvas: canvas,
          prevAngle: startAngle,
          sweepAngle: sweepAngle,
          textStyle: textBoldStyle,
          text: '${datas[i].title} ${datas[i].percent}%',
          offset: offsetChartData);
      startAngle += sweepAngle;
    }

    canvas.drawCircle(center, 30, paintOrangeCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  toRadian(double degree) {
    return (pi * degree) / 180;
  }

  _paintText(Canvas canvas, TextStyle textStyle, String text, Offset offset) {
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    var textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.rtl,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  _drawArc(
      {Canvas canvas,
      Rect rect,
      double startAngle,
      double sweepAngle,
      bool useCenter,
      double blankAngleWithRadian,
      String hexColor,
      double strokeWidth,
      double blurWidth}) {
    var paintArc;
    if (useCenter == null) useCenter = false;
    if (blankAngleWithRadian == null) blankAngleWithRadian = 0;
    if (blurWidth == null) {
      paintArc = Paint()
        ..shader = RadialGradient(
          colors: [HexColor(hexColor), HexColor(hexColor)],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
    } else {
      //paint arc shadow
      var maskFilterBlur = MaskFilter.blur(BlurStyle.outer, blurWidth);
      paintArc = Paint()
        ..shader = RadialGradient(
          colors: [HexColor(hexColor), HexColor(hexColor)],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..maskFilter = maskFilterBlur;
    }
    canvas.drawArc(rect, toRadian(startAngle) + blankAngleWithRadian,
        toRadian(sweepAngle) - 2 * blankAngleWithRadian, useCenter, paintArc);
  }

  _drawPieChartLabel(
      {Canvas canvas,
      double prevAngle,
      double sweepAngle,
      TextStyle textStyle,
      String text,
      Offset offset}) {
    canvas.save();
    double rotateRange = (prevAngle + sweepAngle / 2).toDouble();
    canvas.rotate(toRadian((rotateRange)));
    canvas.translate(60, -5); //move text position
    if (rotateRange >= 180) {
      canvas.translate(80, 10); //move text position
      canvas.rotate(toRadian(180));
    }
    _paintText(canvas, textStyle, text, offset);
    canvas.restore();
  }
}

class ChartData {
  final String hexColor;
  final double percent;
  final String title;

  ChartData({this.hexColor, this.percent, this.title});
}
