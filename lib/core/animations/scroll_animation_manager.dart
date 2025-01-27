import 'package:flutter/material.dart';
import 'animation_config.dart';

mixin ScrollManager<T extends StatefulWidget> on State<T> {
  final scrollController = ScrollController();
  late final AnimationController scrollAnimationController;
  late final Map<String, Animation<double>> scrollAnimations;
  bool isCollapsed = false;

  void initScrollAnimations() {
    scrollAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this as TickerProvider,
    );

    scrollAnimations = {
      'spacing': scrollAnimationController.createAnimation(
        begin: 300,
        end: 20,
        interval: const Interval(0.0, 1.0),
        curve: Curves.easeOutCubic,
      ),
      'height': scrollAnimationController.createAnimation(
        begin: 80,
        end: 0,
        interval: const Interval(0.0, 1.0),
        curve: Curves.easeOutCubic,
      ),
      'opacity': scrollAnimationController.createAnimation(
        begin: 1.0,
        end: 0.0,
        interval: const Interval(0.0, 1.0),
      ),
    };

    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final double offset = scrollController.offset;
    final double maxScroll = 200;

    if (offset <= 0) {
      scrollAnimationController.animateTo(0.0);
      setState(() => isCollapsed = false);
    } else if (offset >= maxScroll) {
      scrollAnimationController.animateTo(1.0);
      setState(() => isCollapsed = true);
    } else {
      scrollAnimationController.animateTo(offset / maxScroll);
      setState(() => isCollapsed = false);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollAnimationController.dispose();
    super.dispose();
  }
}
