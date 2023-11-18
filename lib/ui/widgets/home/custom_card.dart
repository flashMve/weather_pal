import 'package:flutter/material.dart';

class CustomWeatherCard extends CustomPainter {
  CustomWeatherCard(
      {this.color = const Color(0xff1BAECE), this.isFliped = false});

  final Color color;
  final bool isFliped;

  @override
  void paint(Canvas canvas, Size size) {
    if (isFliped) {
      Path path_0 = Path();
      path_0.moveTo(0, size.height * 0.07412760);
      path_0.cubicTo(
          0,
          size.height * 0.02718376,
          size.width * 0.01963915,
          size.height * -0.007346878,
          size.width * 0.03999838,
          size.height * 0.003800072);
      path_0.lineTo(size.width * 0.9753515, size.height * 0.5159186);
      path_0.cubicTo(
          size.width * 0.9898222,
          size.height * 0.5238371,
          size.width,
          size.height * 0.5528824,
          size.width,
          size.height * 0.5862443);
      path_0.lineTo(size.width, size.height * 0.9276018);
      path_0.cubicTo(
          size.width,
          size.height * 0.9675882,
          size.width * 0.9855293,
          size.height,
          size.width * 0.9676768,
          size.height);
      path_0.lineTo(size.width * 0.03232323, size.height);
      path_0.cubicTo(size.width * 0.01447162, size.height, 0,
          size.height * 0.9675882, 0, size.height * 0.9276018);
      path_0.lineTo(0, size.height * 0.07412760);
      path_0.close();

      Paint paint0Fill = Paint()..style = PaintingStyle.fill;
      paint0Fill.color = color.withOpacity(0.47);
      canvas.drawPath(path_0, paint0Fill);
    } else {
      Path path_0 = Path();
      path_0.moveTo(size.width, size.height * 0.06588105);
      path_0.cubicTo(
          size.width,
          size.height * 0.02286403,
          size.width * 0.9793071,
          size.height * -0.008104597,
          size.width * 0.9586182,
          size.height * 0.003949790);
      path_0.lineTo(size.width * 0.02326545, size.height * 0.5489435);
      path_0.cubicTo(size.width * 0.009477899, size.height * 0.5569758, 0,
          size.height * 0.5822056, 0, size.height * 0.6108750);
      path_0.lineTo(0, size.height * 0.9354839);
      path_0.cubicTo(0, size.height * 0.9711169, size.width * 0.01447160,
          size.height, size.width * 0.03232323, size.height);
      path_0.lineTo(size.width * 0.9676768, size.height);
      path_0.cubicTo(size.width * 0.9855293, size.height, size.width,
          size.height * 0.9711169, size.width, size.height * 0.9354839);
      path_0.lineTo(size.width, size.height * 0.06588105);
      path_0.close();

      Paint paint0Fill = Paint()..style = PaintingStyle.fill;
      paint0Fill.color = color.withOpacity(0.47);
      canvas.drawPath(path_0, paint0Fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File
class CustomWeatherCard2 extends CustomPainter {
  CustomWeatherCard2({this.color = const Color(0xff1BAECE), this.colors})
      : assert(colors == null || colors.length == 2);

  /// The fill color of this shape.
  ///
  /// If [colors] are specified this color will be ignored.
  ///
  /// Defaults to [Color(0xff1BAECE)].
  final Color color;

  /// A list of two colors that will be used to create a Radial gradient
  ///
  /// If this is specified [color] will be ignored.
  ///
  /// Defaults to `null`.
  ///
  final List<Color>? colors;

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4184452, size.height * 0.006433073);
    path_0.lineTo(size.width * 0.08590137, size.height * 0.003769916);
    path_0.cubicTo(
        size.width * 0.01823435,
        size.height * 0.01824402,
        size.width * 0.001988435,
        size.height * 0.1095570,
        size.width * 0.002323842,
        size.height * 0.1534045);
    path_0.lineTo(size.width * 0.003013479, size.height * 0.7855754);
    path_0.cubicTo(
        size.width * -0.001988199,
        size.height * 0.9445866,
        size.width * 0.03917945,
        size.height * 0.9940894,
        size.width * 0.08732979,
        size.height * 0.9940168);
    path_0.cubicTo(
        size.width * 0.3279545,
        size.height * 0.9936480,
        size.width * 0.8273493,
        size.height * 0.9938659,
        size.width * 0.8999247,
        size.height * 0.9977039);
    path_0.cubicTo(
        size.width * 0.9725034,
        size.height * 1.001542,
        size.width * 0.9939247,
        size.height * 0.8983575,
        size.width * 0.9955616,
        size.height * 0.8462849);
    path_0.cubicTo(
        size.width * 0.9960445,
        size.height * 0.8127598,
        size.width * 0.9969486,
        size.height * 0.7149441,
        size.width * 0.9967055,
        size.height * 0.5918547);
    path_0.cubicTo(
        size.width * 0.9964623,
        size.height * 0.4687682,
        size.width * 0.9358048,
        size.height * 0.4385179,
        size.width * 0.9055034,
        size.height * 0.4387788);
    path_0.lineTo(size.width * 0.6277705, size.height * 0.4379061);
    path_0.cubicTo(
        size.width * 0.5382842,
        size.height * 0.4483162,
        size.width * 0.5064349,
        size.height * 0.3662168,
        size.width * 0.5050342,
        size.height * 0.3017687);
    path_0.cubicTo(
        size.width * 0.5048870,
        size.height * 0.3064184,
        size.width * 0.5043151,
        size.height * 0.2854860,
        size.width * 0.5026336,
        size.height * 0.1645162);
    path_0.cubicTo(
        size.width * 0.5009521,
        size.height * 0.04354642,
        size.width * 0.4458082,
        size.height * 0.008723352,
        size.width * 0.4184452,
        size.height * 0.006433073);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;

    Paint paintShadow = Paint()
      ..color = Colors.black.withOpacity(0.3) // Shadow color and opacity
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 150);

    final paint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Colors.pink,
          Colors.purple,
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 4, size.height / 2),
        radius: size.width / 2,
      ));

    if (colors != null) {
      canvas.drawPath(path_0, paintShadow);

      canvas.drawPath(path_0, paint);
    } else {
      canvas.drawPath(path_0, paintShadow);

      canvas.drawPath(path_0, paint0Fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
