import 'package:flutter/material.dart';

class DonutTile extends StatelessWidget {
  final String donutFlavor;
  final String donutPrice;
  final dynamic donutColor;
  final String imageName;


//valor fijo para el borde circular
  final double borderRadius = 24;


  const DonutTile({super.key, required this.donutFlavor,
   required this.donutPrice, this.donutColor,
    required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(12),
    child: Container(
      decoration: BoxDecoration(color: donutColor[50],
       borderRadius: BorderRadius.circular(borderRadius)),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Container(
            decoration: BoxDecoration(
              color: donutColor[100],
              borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadius),
              bottomLeft: Radius.circular(borderRadius))),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: Text('\$$donutPrice',
               style:
               TextStyle(fontWeight: FontWeight.bold,
              fontSize: 18,
              color: donutColor[800]),),
          )],
        )
      ],
    ) ,
    ),
    );
  }
}