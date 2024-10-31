import 'package:flutter/material.dart'; // Paquete de Material Design para crear la interfaz.
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication para gestionar autenticación.
import 'package:google_sign_in/google_sign_in.dart'; // Autenticación con Google Sign-In.
import 'package:reto1_donet_app_christian_rodriguez/tab/Burger_tab.dart'; // Pestaña de hamburguesas.
import 'package:reto1_donet_app_christian_rodriguez/tab/Donut_tab.dart'; // Pestaña de donuts.
import 'package:reto1_donet_app_christian_rodriguez/tab/Pancakes_tab.dart'; // Pestaña de pancakes.
import 'package:reto1_donet_app_christian_rodriguez/tab/Pizza_tab.dart'; // Pestaña de pizzas.
import 'package:reto1_donet_app_christian_rodriguez/tab/Smoothie_tab.dart'; // Pestaña de smoothies.
import 'package:reto1_donet_app_christian_rodriguez/pages/login.dart'; // Página de inicio de sesión.
import 'package:reto1_donet_app_christian_rodriguez/pages/update_password.dart'; // Página de actualización de contraseña.

class HomePage extends StatefulWidget {
  const HomePage({super.key}); // Constructor de la página principal, usa la key para identificar el widget.

  @override
  State<HomePage> createState() => _HomePageState(); // Crea el estado de la página principal.
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Llave global para acceder al scaffold y poder abrir el drawer.
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instancia de FirebaseAuth para autenticación.
  User? user; // Variable que almacena el usuario actualmente autenticado.
  int itemCount = 0; // Contador de artículos en el carrito de compras.
  double totalAmount = 0.0; // Total del monto en el carrito.

  List<Tab> myTabs = [ // Lista de pestañas con íconos y texto para cada categoría.
    Tab(icon: const ImageIcon(AssetImage('lib/icons/donut.png')), text: 'Donuts'),
    Tab(icon: const ImageIcon(AssetImage('lib/icons/burger.png')), text: 'Burgers'),
    Tab(icon: const ImageIcon(AssetImage('lib/icons/smoothie.png')), text: 'Smoothies'),
    Tab(icon: const ImageIcon(AssetImage('lib/icons/pancakes.png')), text: 'Pancakes'),
    Tab(icon: const ImageIcon(AssetImage('lib/icons/pizza.png')), text: 'Pizzas'),
  ];

  void addItem(double price) { // Función para agregar artículos al carrito.
    setState(() {
      itemCount++; // Incrementa el número de artículos.
      totalAmount += price; // Añade el precio del artículo al total.
    });
  }

  void _checkUser() { // Función que se activa cuando el estado de autenticación cambia.
    _auth.authStateChanges().listen((User? user) { // Escucha el estado de autenticación.
      setState(() {
        this.user = user; // Actualiza la variable `user` con el usuario actual.
      });
    });
  }

  @override
  void initState() { // Método que se ejecuta cuando el widget se inicializa.
    super.initState();
    _checkUser(); // Llama a _checkUser para verificar el usuario actual.
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( // Controlador de tabs para manejar las pestañas.
      length: myTabs.length, // Número total de pestañas.
      child: Scaffold(
        key: _scaffoldKey, // Asigna la llave al scaffold para abrir el drawer.
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Fondo transparente para el AppBar.
          leading: Padding( // Botón de menú que abre el drawer.
            padding: const EdgeInsets.only(left: 24.0),
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.grey[800], size: 36), // Icono de menú.
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer(); // Abre el drawer al presionar.
              },
            ),
          ),
          actions: [
            if (user == null) // Si no hay usuario autenticado.
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IconButton(
                  icon: Icon(Icons.person, color: Colors.grey[800], size: 36), // Icono de perfil.
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()), // Navega a la página de login.
                    );
                  },
                ),
              ),
          ],
        ),
        drawer: Drawer( // Menú lateral (drawer) que se muestra al abrir.
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.pink.shade700), // Fondo del encabezado.
                accountEmail: Text( // Muestra el correo del usuario.
                  user != null ? user!.email ?? "" : "",
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar( // Muestra la foto de perfil del usuario o un avatar por defecto.
                  backgroundImage: user != null && user!.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : const AssetImage('lib/icons/default_avatar.png') as ImageProvider,
                ),
                accountName: Text( // Muestra el nombre del usuario o "Anónimo" si no tiene nombre.
                  user != null ? user!.displayName ?? "" : "Anonimo",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile( // Opción de "Inicio".
                leading: const Icon(Icons.home, color: Colors.pink),
                title: const Text('Inicio'),
                onTap: () {
                  Navigator.pop(context); // Cierra el drawer.
                },
              ),
              ListTile( // Opción de "Comida".
                leading: const Icon(Icons.fastfood, color: Colors.pink),
                title: const Text('Comida'),
                onTap: () {
                  Navigator.pop(context); // Cierra el drawer.
                },
              ),
              ListTile( // Opción de "Mercado".
                leading: const Icon(Icons.shopping_cart, color: Colors.pink),
                title: const Text('Mercado'),
                onTap: () {
                  Navigator.pop(context); // Cierra el drawer.
                },
              ),
              ListTile( // Opción de "Método de Pago".
                leading: const Icon(Icons.card_giftcard, color: Colors.pink),
                title: const Text('Método de Pago'),
                onTap: () {
                  Navigator.pop(context); // Cierra el drawer.
                },
              ),
              ListTile( // Opción para actualizar contraseña.
                leading: const Icon(Icons.lock, color: Colors.pink),
                title: const Text('Actualizar Contraseña'),
                onTap: () {
                  Navigator.pop(context); // Cierra el drawer.
                  if (user != null) { // Si el usuario está autenticado.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UpdatePasswordPage()), // Navega a la página de actualización de contraseña.
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Debes iniciar sesión para actualizar la contraseña.')), // Mensaje de error.
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()), // Navega a la página de inicio de sesión.
                    );
                  }
                },
              ),
              ListTile( // Opción para cerrar sesión.
                leading: const Icon(Icons.logout, color: Colors.pink),
                title: const Text('Cerrar Sesión'),
                onTap: () async {
                  await _auth.signOut(); // Cierra la sesión.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()), // Regresa a la página de inicio de sesión.
                  );
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Text("I want to ", style: TextStyle(fontSize: 32)), // Texto que indica "I want to".
                  Text(
                    "EAT", // Texto "EAT" subrayado y en negrita.
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            TabBar( // Barra de pestañas con los iconos de categorías.
              tabs: myTabs,
              labelColor: Colors.black, // Color de la etiqueta seleccionada.
              indicatorColor: Colors.pink, // Color del indicador de la pestaña activa.
            ),
            Expanded(
              child: TabBarView( // Contenido de cada pestaña.
                children: [
                  DonutTab(addItem: addItem), // Pestaña de Donuts.
                  BurgerTab(addItem: addItem), // Pestaña de Burgers.
                  SmoothieTab(addItem: addItem), // Pestaña de Smoothies.
                  PancakeTab(addItem: addItem), // Pestaña de Pancakes.
                  PizzaTab(addItem: addItem), // Pestaña de Pizzas.
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuye el espacio entre los elementos del Row.
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pink.shade600,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: const [
                            Text(
                              'Total', // Texto "Total" en blanco y en negrita.
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
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
