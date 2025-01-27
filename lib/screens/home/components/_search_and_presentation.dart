import 'package:flutter/material.dart';
import 'package:gevoul/screens/home/components/_immo_item.dart';
import 'package:gevoul/screens/home/components/_filter_button.dart';

class SearchAndPresentation extends StatelessWidget {
  const SearchAndPresentation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Recherchez un lotissement..',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
            ),
            // Filter buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterButton(label: 'Carrière', isActive: true),
                FilterButton(label: 'Terrain'),
                FilterButton(label: 'Maison'),
              ],
            ),
            SizedBox(height: 20),
            // Property presentation
            ImmoItems(),
          ],
        )),
      ),
    );
  }
}
