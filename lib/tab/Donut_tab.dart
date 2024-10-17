import 'package:flutter/material.dart';

import '../utils/donut_tile.dart';

class DonutTab extends StatelessWidget {
  final List donutsOnsale = [
    ["Ice Cream","36", Colors.blue,"lib/images/chocolate_donut.png"],
    ["Strawberry","45", Colors.brown,"lib/images/grape_donut.png"],
    ["Grape Ape","84", Colors.red,"lib/images/icecream_donut.png"],
    ["Choco","95", Colors.pink,"lib/images/strawberry_donut.png"],

  ];

  DonutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: donutsOnsale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 1/1.5,
        // crossAxisSpacing: 5,
        // mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index){
        return DonutTile(
          donutFlavor: donutsOnsale[index][0],
          donutPrice: donutsOnsale[index][1],
          donutColor: donutsOnsale[index][2],
          imageName: donutsOnsale[index][3],
        );
      },
    );
  }
}