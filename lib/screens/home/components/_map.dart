import 'package:flutter/material.dart';

class MapComponent extends StatelessWidget {
  const MapComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Container(
            color: Color(0xFFD3F8E2),
            //color: Colors.redAccent,
            height: 470,
            child: Align(
              alignment: Alignment
                  .centerLeft, // Change this to centerRight to move the image to the right
              child: Image.asset(
                'images/kribi.png',
                fit: BoxFit.cover, // L'image couvre tout le container
              ),
            ),
          ),
          Positioned(
              top: 200,
              left: 282,
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Cercle bleu clair
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(206, 206, 240, 0.39),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Point de localisation vert
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_pin, size: 40, color: Colors.green),
                        Text('Le site ici')
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
