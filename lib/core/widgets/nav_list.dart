import 'package:brelax/core/widgets/nav_item.dart';
import 'package:flutter/material.dart';

class NavList extends StatelessWidget {
  final String selectedPage;
  final Function(String) onItemSelected;
  final List<Map<String, dynamic>> navItems = [
    {
      'svgPath': 'assets/images/bolt.svg',
      'label': 'tES',
      'color': const Color(0xFFFFCD45)
    },
    {
      'svgPath': 'assets/images/breath.svg',
      'label': 'BREATHING',
      'color': const Color(0xFF2FB3FF)
    },
    {
      'svgPath': 'assets/images/neurology.svg',
      'label': 'NIRS',
      'color': const Color(0xFFFF9898)
    },
    {
      'svgPath': 'assets/images/person.svg',
      'label': 'USER',
      'color': const Color(0xFFFFA237)
    },
  ];

  NavList(
      {super.key, required this.selectedPage, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 265,
        height: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(42)),
          color: Color.fromRGBO(255, 255, 255, 0.75),
        ),
        child: Center(
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: navItems.length,
            itemBuilder: (context, index) {
              final item = navItems[index];
              final bool isSelected = selectedPage == item['label'];
              final Color itemColor =
                  isSelected ? item['color'] : const Color(0xFF585858);

              return IconButton(
                onPressed: () {
                  onItemSelected(item['label']);
                  switch (item['label']) {
                    case 'BREATHING':
                      Navigator.pushReplacementNamed(context, '/brhome');
                      break;
                    case 'tES':
                      Navigator.pushReplacementNamed(context, '/teshome');
                      break;
                    case 'NIRS':
                      Navigator.pushReplacementNamed(context, '/nirshome');
                      break;
                    case 'USER':
                      Navigator.pushReplacementNamed(context, '/teshome');
                      break;
                  }
                },
                icon: NavItem(
                  label: item['label'],
                  svgPath: item['svgPath'],
                  isSelected: isSelected,
                  color: itemColor,
                ),
                iconSize: 20, // 圖示大小
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 2),
          ),
        ));
  }
}
