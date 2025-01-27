import 'package:flutter/material.dart';

class MapComponent extends StatelessWidget {
  const MapComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Container(
            color: Colors.grey.shade300, // Placeholder pour simuler la carte.
          ),
          Positioned(
              top: 200,
              left: 150,
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Cercle bleu clair
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Point de localisation vert
                    Icon(Icons.location_pin, size: 40, color: Colors.green),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
