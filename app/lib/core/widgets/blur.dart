import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatelessWidget {
  const Blur({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.white.withValues(
            red: 255,
            green: 255,
            blue: 255,
            alpha: 100,
          ),
          child: Center(child: child ?? const CircularProgressIndicator()),
        ),
      ),
    );
  }
}
