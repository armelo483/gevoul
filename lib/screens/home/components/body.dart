import 'package:flutter/material.dart';
import 'package:gevoul/screens/home/components/_top_bar.dart';
import 'package:gevoul/screens/home/components/_map.dart';
import 'package:gevoul/screens/home/components/_search_and_presentation.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MapComponent(),
        Container(
          child: Column(
            children: <Widget>[
              TopBar(),
              SizedBox(height: 300),
              SearchAndPresentation(),
            ],
          ),
        )
      ],
    );
  }
}
