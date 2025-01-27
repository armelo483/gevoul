import 'package:flutter/material.dart';
import 'animation_config.dart';

mixin PageAnimationManager<T extends StatefulWidget> on State<T> {
  late final AnimationController pageAnimationController;
  late final Map<String, Animation<double>> animations;
  
  bool get isReversed => false;

  void initPageAnimations() {
    pageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this as TickerProvider,
    );

    animations = {
      'map': pageAnimationController.createAnimation(
        begin: isReversed ? 0.0 : 0.3,
        end: isReversed ? 0.3 : 1.0,
        interval: const Interval(0.0, 0.5),
      ),
      'header': pageAnimationController.createAnimation(
        begin: isReversed ? 0.0 : -50.0,
        end: isReversed ? -50.0 : 0.0,
        interval: const Interval(0.2, 0.7),
      ),
      'search': pageAnimationController.createAnimation(
        begin: isReversed ? 0.0 : 100.0,
        end: isReversed ? 100.0 : 0.0,
        interval: const Interval(0.4, 0.9),
      ),
    };

    pageAnimationController.forward();
  }

  @override
  void dispose() {
    pageAnimationController.dispose();
    super.dispose();
  }
}
