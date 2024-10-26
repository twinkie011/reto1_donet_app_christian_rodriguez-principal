import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Burger_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Donut_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Pancakes_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Pizza_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Smoothie_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tab> myTabs = [
    Tab(
      icon: const ImageIcon(AssetImage('lib/icons/donut.png')),
      text: 'Donuts',
    ),
    Tab(
      icon: const ImageIcon(AssetImage('lib/icons/burger.png')),
      text: 'Burgers',
    ),
    Tab(
      icon: const ImageIcon(AssetImage('lib/icons/smoothie.png')),
      text: 'Smoothies',
    ),
    Tab(
      icon: const ImageIcon(AssetImage('lib/icons/pancakes.png')),
      text: 'Pancakes',
    ),
    Tab(
      icon: const ImageIcon(AssetImage('lib/icons/pizza.png')),
      text: 'Pizzas',
    ),
  ];

  int itemCount = 0;
  double totalAmount = 0.0;

  void addItem(double price) {
    setState(() {
      itemCount++;
      totalAmount += price;
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    // Redirigir al usuario a la pantalla de login después de cerrar sesión
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: IconButton(
                icon: Icon(Icons.person, color: Colors.grey[800], size: 36),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text(user != null ? user.email ?? "Correo no disponible" : "Usuario no autenticado"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    user != null ? user.email![0].toUpperCase() : "U",
                    style: const TextStyle(fontSize: 40.0, color: Colors.blue),
                  ),
                ),
                accountName: null,
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.fastfood),
                title: const Text('Comida'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Mercado'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.card_giftcard),
                title: const Text('Método de Pago'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // Botón de cerrar sesión
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar Sesión'),
                onTap: () {
                  signOut(); // Llamada a la función para cerrar sesión
                },
              ),
            ],
          ),
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
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              tabs: myTabs,
              labelColor: Colors.black,
              indicatorColor: Colors.pink,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  DonutTab(addItem: addItem),
                  BurgerTab(addItem: addItem),
                  SmoothieTab(addItem: addItem),
                  PancakeTab(addItem: addItem),
                  PizzaTab(addItem: addItem),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para ver el carrito
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400],
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
