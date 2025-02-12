import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';
import 'package:gevoul/screens/home/components/_immo_item.dart';
import 'package:gevoul/screens/home/components/_filter_button.dart';

class SearchAndPresentation extends StatefulWidget {
  const SearchAndPresentation({super.key});

  @override
  _SearchAndPresentationState createState() => _SearchAndPresentationState();
}

class _SearchAndPresentationState extends State<SearchAndPresentation>
    with SingleTickerProviderStateMixin {
  String selectedType = 'Tous';
  final List<String> filterTypes = ['Tous', 'Maison', 'Terrain', 'Carrière'];
  final List<Map<String, String>> immoData = [
    {
      'title': 'Villa Moderne',
      'description': 'Magnifique villa moderne avec piscine et jardin paysager',
      'image': 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6',
      'type': 'Maison',
    },
    {
      'title': 'Terrain Constructible',
      'description': 'Terrain plat de 1000m² avec vue dégagée',
      'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef',
      'type': 'Terrain',
    },
    {
      'title': 'Carrière de Pierre',
      'description': 'Carrière en exploitation avec équipements',
      'image': 'https://images.unsplash.com/photo-1518780664697-55e3ad937233',
      'type': 'Carrière',
    },
    {
      'title': 'Maison de Campagne',
      'description': 'Charmante maison avec grand jardin',
      'image': 'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
      'type': 'Maison',
    },
    {
      'title': 'Terrain Agricole',
      'description': 'Terrain de 5 hectares avec source d\'eau',
      'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef',
      'type': 'Terrain',
    },
    {
      'title': 'Villa Contemporaine',
      'description': 'Villa moderne avec vue panoramique',
      'image': 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6',
      'type': 'Maison',
    },
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = selectedType == 'Tous'
        ? immoData
        : immoData.where((item) => item['type'] == selectedType).toList();
    return Container(
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
            FadeInLeft(
                config: BaseAnimationConfig(
                    repeat: true,
                    duration: 800.milliseconds,
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filterTypes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: FilterButton(
                              label: filterTypes[index],
                              isActive: selectedType == filterTypes[index],
                              onPressed: () {
                                setState(() {
                                  selectedType = filterTypes[index];
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ))),
            SizedBox(height: 20),
            // Property presentation
            ...filteredItems.asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;

              return SlideInUp(
                config: BaseAnimationConfig(
                  //repeat: true,
                  duration: 2.seconds,
                  delay: Duration(seconds: 2 * index + 1),
                  child: ImmoItem(
                    title: item['title']!,
                    description: item['description']!,
                    image: item['image']!,
                    type: item['type']!,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
