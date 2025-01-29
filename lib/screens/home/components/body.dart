import 'package:flutter/material.dart';
import 'package:gevoul/screens/home/components/_top_bar.dart';
import 'package:gevoul/screens/home/components/_map.dart';
import 'package:gevoul/screens/home/components/_search_and_presentation.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TopBar(),
            Expanded(
              child: MapComponent(),
            ),
          ],
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.2,
          maxChildSize: 0.9,
          snap: true,
          snapSizes: [0.4, 0.9],
          builder: (context, scrollController) {
            return SearchAndPresentation(
              parentScrollController: scrollController,
            );
          },
        ),
      ],
    );
  }
}
