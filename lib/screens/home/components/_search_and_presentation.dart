import 'package:flutter/material.dart';
import 'package:gevoul/screens/home/components/_immo_item.dart';
import 'package:gevoul/screens/home/components/_filter_button.dart';
import 'package:gevoul/core/animations/scroll_animation_manager.dart';

class SearchAndPresentation extends StatefulWidget {
  final ScrollController parentScrollController;

  const SearchAndPresentation({
    required this.parentScrollController,
    super.key,
  });

  @override
  State<SearchAndPresentation> createState() => _SearchAndPresentationState();
}

class _SearchAndPresentationState extends State<SearchAndPresentation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController scrollAnimationController;
  late Map<String, Animation<double>> scrollAnimations;
  bool isCollapsed = false;

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    scrollAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
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
          curve: Curves.easeOutCubic),
    };

    widget.parentScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final double offset = widget.parentScrollController.offset;
    final double maxScroll = 100.0;

    if (offset <= 0) {
      if (!isCollapsed) {
        scrollAnimationController.animateTo(0.0,
            duration: Duration(milliseconds: 200), curve: Curves.easeOut);
        setState(() => isCollapsed = false);
      }
    } else if (offset >= maxScroll) {
      if (!isCollapsed) {
        scrollAnimationController.animateTo(1.0,
            duration: Duration(milliseconds: 200), curve: Curves.easeOut);
        setState(() => isCollapsed = true);
      }
    } else {
      final double progress = (offset / maxScroll).clamp(0.0, 1.0);
      scrollAnimationController.animateTo(progress,
          duration: Duration(milliseconds: 100), curve: Curves.linear);
      setState(() => isCollapsed = false);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    scrollAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = selectedType == 'Tous'
        ? immoData
        : immoData.where((item) => item['type'] == selectedType).toList();

    return AnimatedBuilder(
      animation: scrollAnimationController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isCollapsed ? 0.1 : 0.05),
                blurRadius: isCollapsed ? 10 : 5,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: widget.parentScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Recherchez un lotissement..',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
                // Filter buttons
                SizedBox(
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
                ),
                const SizedBox(height: 20),
                // Immo items
                ...filteredItems.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ImmoItem(
                        title: item['title']!,
                        description: item['description']!,
                        image: item['image']!,
                        type: item['type']!,
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
