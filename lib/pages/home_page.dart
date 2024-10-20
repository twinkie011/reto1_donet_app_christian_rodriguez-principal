import 'package:flutter/material.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Burger_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Donut_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Pancakes_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Pizza_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Smoothie_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/utils/my_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de tabs usando MyTab
List<Tab> myTabs = [
    // Donut tab
    Tab(
      icon: const ImageIcon(AssetImage('lib/icons/donut.png')),
      text: 'Donuts', ),

    // Burger tab
    Tab(
      icon: const ImageIcon(AssetImage('lib/icons/burger.png')),
      text: 'Burgers',),

    // Smoothie tab
    Tab(
      icon: const ImageIcon(AssetImage('lib/icons/smoothie.png')),
      text: 'Smoothies',),

    // Pancake tab
    Tab(
      icon: const ImageIcon(AssetImage('lib/icons/pancakes.png')),
      text: 'Pancakes', ),

    // Pizza tab
    Tab(
      icon: const ImageIcon(AssetImage('lib/icons/pizza.png')),
      text: 'Pizzas',),
  ];


  // Variables para controlar el número de items y el monto total
  int itemCount = 0;
  double totalAmount = 0.0;

  // Función para agregar productos
  void addItem(double price) {
    setState(() {
      itemCount++;
      totalAmount += price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.grey[800],
                size: 36,
              ),
              onPressed: () {
                print('boton menu');
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.grey[800],
                  size: 36,
                ),
                onPressed: () {
                  print('otra cosa');
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text(
                    'I want to ',
                    style: TextStyle(fontSize: 32),
                  ),
                  Text(
                    'Eat ',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            // Tab bar con myTabs
            TabBar(
              tabs: myTabs,
              labelColor: Colors.black,
              indicatorColor: Colors.pink,
            ),
            // Tab bar view
            Expanded(
              child: TabBarView(
                children: [
                  // Donut tab
                  DonutTab(addItem: addItem),

                  // Burger tab
                  BurgerTab(addItem: addItem),

                  // Smoothie tab
                  SmoothieTab(addItem: addItem),

                  // Pancake tab
                  PancakeTab(addItem: addItem),

                  // Pizza tab
                  PizzaTab(addItem: addItem),
                ],
              ),
            ),
            // New Section: Items Summary and View Cart Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text for items and price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$itemCount Items | \$$totalAmount',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Delivery Charges Included',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      // View Cart button
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para ver el carrito
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400], // Color rosa
                        ),
                        child: const Text(
                          'View Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}
