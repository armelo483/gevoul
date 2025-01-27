import 'package:flutter/material.dart';

extension AnimationConfig on AnimationController {
  Animation<double> createAnimation({
    required double begin,
    required double end,
    required Interval interval,
    Curve curve = Curves.easeOut,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: this, curve: interval),
    );
  }
}
