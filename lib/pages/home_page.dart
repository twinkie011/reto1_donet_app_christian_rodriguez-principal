import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Burger_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Donut_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Pancakes_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Pizza_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/tab/Smoothie_tab.dart';
import 'package:reto1_donet_app_christian_rodriguez/pages/login.dart';
import 'package:reto1_donet_app_christian_rodriguez/pages/update_password.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  int itemCount = 0;
  double totalAmount = 0.0;

  List<Tab> myTabs = [
    const Tab(
        icon: ImageIcon(AssetImage('lib/icons/donut.png')), text: 'Donuts'),
    const Tab(
        icon: ImageIcon(AssetImage('lib/icons/burger.png')), text: 'Burgers'),
    const Tab(
        icon: ImageIcon(AssetImage('lib/icons/smoothie.png')),
        text: 'Smoothies'),
    const Tab(
        icon: ImageIcon(AssetImage('lib/icons/pancakes.png')),
        text: 'Pancakes'),
    const Tab(
        icon: ImageIcon(AssetImage('lib/icons/pizza.png')), text: 'Pizzas'),
  ];

  void addItem(double price) {
    setState(() {
      itemCount++;
      totalAmount += price;
    });
  }

  void _checkUser() {
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        this.user = user;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.grey, size: 36),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),
          actions: [
            if (user == null)
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IconButton(
                  icon: const Icon(Icons.person, color: Colors.grey, size: 36),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
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
                decoration: BoxDecoration(color: Colors.pink.shade700),
                accountEmail: Text(
                  user?.email ?? "No email",
                  style: const TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : const AssetImage('lib/icons/default_avatar.png')
                          as ImageProvider,
                ),
                accountName: Text(
                  user?.displayName ?? "Anónimo",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              // Elementos del menú lateral
              _buildDrawerItem(
                  Icons.home, 'Inicio', () => Navigator.pop(context)),
              _buildDrawerItem(
                  Icons.fastfood, 'Comida', () => Navigator.pop(context)),
              _buildDrawerItem(
                  Icons.shopping_cart, 'Mercado', () => Navigator.pop(context)),
              _buildDrawerItem(Icons.card_giftcard, 'Método de Pago',
                  () => Navigator.pop(context)),
              _buildDrawerItem(Icons.lock, 'Actualizar Contraseña', () {
                Navigator.pop(context);
                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdatePasswordPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Debes iniciar sesión para actualizar la contraseña.')),
                  );
                }
              }),
              _buildDrawerItem(Icons.logout, 'Cerrar Sesión', () async {
                await _auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }),
            ],
          ),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Text("I want to ", style: TextStyle(fontSize: 32)),
                  Text("EAT",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
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
                                fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          const Text('Delivery Charges Included',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para ver el carrito
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[400],
                        ),
                        child: const Text('View Cart',
                            style: TextStyle(color: Colors.white)),
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

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink),
      title: Text(title),
      onTap: onTap,
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
