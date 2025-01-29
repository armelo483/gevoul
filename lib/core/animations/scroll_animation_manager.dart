import 'package:flutter/material.dart';
import 'animation_config.dart';

extension AnimationControllerExtension on AnimationController {
  Animation<double> createAnimation({
    required double begin,
    required double end,
    required Interval interval,
    required Curve curve,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        parent: this,
        curve: interval,
      ),
    );
  }
}

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
    final double maxScroll = 100.0;

    if (offset <= 0) {
      if (!isCollapsed) {
        scrollAnimationController.animateTo(0.0, duration: Duration(milliseconds: 200), curve: Curves.easeOut);
        setState(() => isCollapsed = false);
      }
    } else if (offset >= maxScroll) {
      if (!isCollapsed) {
        scrollAnimationController.animateTo(1.0, duration: Duration(milliseconds: 200), curve: Curves.easeOut);
        setState(() => isCollapsed = true);
      }
    } else {
      final double progress = (offset / maxScroll).clamp(0.0, 1.0);
      scrollAnimationController.animateTo(progress, duration: Duration(milliseconds: 100), curve: Curves.linear);
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
