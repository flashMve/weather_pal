import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:weather_pal/ui/common/app_colors.dart';

class GlassEffect extends StatelessWidget {
  const GlassEffect({
    super.key,
    required this.child,
    this.size = const Size(200.0, 200.0),
    this.margin = const EdgeInsets.all(18),
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.all(18),
    this.color = kcBackgroundColor,
    this.decoration,
  });

  final Widget child;
  final Size? size;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Container(
          width: size!.width,
          height: size!.height,
          margin: margin,
          padding: padding,
          decoration: decoration ??
              BoxDecoration(
                color: (color ?? Colors.grey.shade200.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(borderRadius!),
              ),
          child: child,
        ),
      ),
    );
  }
}

class MeshGradientBackground extends StatelessWidget {
  const MeshGradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: AnimatedMeshGradient(
        colors: const [
          Color.fromARGB(255, 164, 164, 164),
          Color(0xff6903F9),
          Color.fromARGB(255, 162, 0, 143),
          Color.fromARGB(255, 181, 21, 255),
        ],
        options: AnimatedMeshGradientOptions(
          frequency: 6,
          amplitude: 50,
          speed: 0.2,
        ),
        child: child,
      ),
    );
  }
}
