import 'package:flutter/material.dart';
import 'package:gevoul/screens/home/components/_top_bar.dart';
import 'package:gevoul/screens/home/components/_map.dart';
import 'package:gevoul/screens/home/components/_search_and_presentation.dart';
import 'package:gevoul/core/animations/page_animation_manager.dart';
import 'package:gevoul/core/animations/scroll_animation_manager.dart';

class Body extends StatefulWidget {
  final bool isReversed;
  const Body({super.key, this.isReversed = false});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>
    with TickerProviderStateMixin, PageAnimationManager, ScrollManager {
  @override
  bool get isReversed => widget.isReversed;

  @override
  void initState() {
    super.initState();
    initPageAnimations();
    initScrollAnimations();
  }

  Widget _buildAnimatedHeader() {
    return Transform.translate(
      offset: Offset(0, animations['header']!.value),
      child: AnimatedBuilder(
        animation: scrollAnimationController,
        builder: (context, child) => Opacity(
          opacity: scrollAnimations['opacity']!.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: scrollAnimations['height']!.value,
            child: const TopBar(),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedContent() {
    return Transform.translate(
      offset: Offset(0, animations['search']!.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isCollapsed ? 0.1 : 0.05),
              blurRadius: isCollapsed ? 10 : 5,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              scrollAnimations['height']!.value,
        ),
        child: const SearchAndPresentation(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageAnimationController,
      builder: (context, _) => Stack(
        children: [
          Transform.scale(
            scale: animations['map']!.value,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isCollapsed ? 0.3 : 1.0,
              child: const MapComponent(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildAnimatedHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        AnimatedBuilder(
                          animation: scrollAnimationController,
                          builder: (_, __) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: scrollAnimations['spacing']!.value,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                        _buildAnimatedContent(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
