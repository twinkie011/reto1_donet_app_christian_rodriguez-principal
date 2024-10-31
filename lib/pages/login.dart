// Importa las bibliotecas necesarias para construir la interfaz y manejar la autenticación.
import 'package:flutter/material.dart'; // Paquete principal para interfaces en Flutter.
import 'package:firebase_auth/firebase_auth.dart'; // Paquete para autenticación de usuarios con Firebase.
import 'package:google_sign_in/google_sign_in.dart'; // Paquete para autenticación con Google.
import 'package:reto1_donet_app_christian_rodriguez/pages/password.dart'; // Ruta de la página para recuperación de contraseña.
import 'package:reto1_donet_app_christian_rodriguez/pages/registro.dart'; // Ruta de la página de registro de usuario.
import 'home_page.dart'; // Ruta de la página de inicio de la aplicación.

class LoginPage extends StatefulWidget {
  const LoginPage({super.key}); // Constructor de la clase LoginPage.

  @override
  LoginPageState createState() => LoginPageState(); // Crea y devuelve el estado de la página de inicio de sesión.
}

// Clase que define el estado de LoginPage.
class LoginPageState extends State<LoginPage> {
  // Define controladores para manejar el texto ingresado en los campos de usuario y contraseña.
  final TextEditingController _usernameController = TextEditingController(); // Controlador para el campo de correo electrónico.
  final TextEditingController _passwordController = TextEditingController(); // Controlador para el campo de contraseña.
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instancia para gestionar la autenticación de Firebase.

  // Configura el inicio de sesión de Google, proporcionando un Client ID.
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '908843670295-u445d8ugr8d1vv7dhe7rndq7hubct9r4.apps.googleusercontent.com', // ID de cliente de Google.
  );

  // Función para iniciar sesión con Google.
  Future<void> signInWithGoogle() async {
    try {
      // Muestra la pantalla de inicio de sesión de Google.
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) { // Si el usuario se autentica correctamente:
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication; // Obtiene las credenciales.

        // Credenciales de autenticación para Google.
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, // Token de acceso de Google.
          idToken: googleAuth.idToken, // ID token de Google.
        );

        // Inicia sesión en Firebase usando las credenciales de Google.
        await _auth.signInWithCredential(credential);
        // Redirige a la página principal de la aplicación después del inicio de sesión exitoso.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()), // Navega a HomePage.
        );
      }
    } catch (e) { // Si ocurre algún error durante el proceso de inicio de sesión:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al iniciar sesión con Google: $e")), // Muestra el error en un Snackbar.
      );
    }
  }

  // Función para iniciar sesión con correo y contraseña.
  void _login() async {
    try {
      // Intenta iniciar sesión con correo y contraseña proporcionados en los controladores.
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _usernameController.text, // Utiliza el texto ingresado en el controlador de correo.
        password: _passwordController.text, // Utiliza el texto ingresado en el controlador de contraseña.
      );

      // Verifica si el correo del usuario está verificado.
      if (userCredential.user?.emailVerified == true) {
        // Si el correo está verificado, redirige a la página principal.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else { // Si el correo no está verificado:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor verifica tu correo electrónico')), // Solicita verificar el correo.
        );
      }
    } on FirebaseAuthException catch (e) { // Captura errores específicos de FirebaseAuth.
      // Define mensajes de error personalizados según el tipo de error.
      String message = 'Error desconocido'; // Mensaje predeterminado de error.
      if (e.code == 'user-not-found') { // Usuario no encontrado en Firebase.
        message = 'No hay ningún usuario registrado con este correo.';
      } else if (e.code == 'wrong-password') { // Contraseña incorrecta.
        message = 'Contraseña incorrecta.';
      }
      // Muestra el mensaje de error en un Snackbar.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  // Función para iniciar sesión de forma anónima.
  void _loginAnonymously() async {
    try {
      await _auth.signInAnonymously(); // Inicia sesión anónima en Firebase.
      // Redirige a la página principal de la aplicación después de iniciar sesión.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) { // Captura cualquier error de autenticación.
      // Muestra el error en un Snackbar.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de inicio de sesión.
    return Scaffold(
      backgroundColor: Colors.transparent, // Establece el fondo de pantalla en transparente.
      appBar: AppBar(
        title: const Text('Iniciar Sesión', style: TextStyle(color: Colors.white)), // Título en el AppBar.
        backgroundColor: Colors.pink, // Color de fondo del AppBar.
        elevation: 0, // Sin sombra en el AppBar.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Icono de "atrás" en el AppBar.
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior.
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.pinkAccent], // Gradiente de fondo.
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1), // Padding adaptable al ancho de la pantalla.
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente el contenido.
                  children: [
                    const SizedBox(height: 40), // Espacio superior.
                    const Icon(Icons.fastfood, size: 100, color: Colors.white), // Icono decorativo.
                    const SizedBox(height: 20), // Espacio entre icono y texto de bienvenida.
                    const Text(
                      "Bienvenido,", // Texto de bienvenida.
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10), // Espacio entre textos.
                    const Text(
                      "Inicia sesión para continuar", // Indicador de acción.
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30), // Espacio antes del formulario.
                    Container(
                      padding: EdgeInsets.all(constraints.maxWidth * 0.05), // Padding del contenedor del formulario.
                      decoration: BoxDecoration(
                        color: Colors.white, // Fondo blanco para el formulario.
                        borderRadius: BorderRadius.circular(15.0), // Bordes redondeados.
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Sombra suave alrededor del formulario.
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController, // Controlador para el correo electrónico.
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person), // Icono de usuario.
                              hintText: "Correo Electrónico", // Indicador de campo.
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20), // Espacio entre campos.
                          TextFormField(
                            controller: _passwordController, // Controlador para la contraseña.
                            obscureText: true, // Oculta el texto ingresado (contraseña).
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock), // Icono de candado.
                              hintText: "Contraseña", // Indicador de campo.
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20), // Espacio antes del botón de inicio.
                          SizedBox(
                            width: double.infinity, // Hace que el botón ocupe todo el ancho del contenedor.
                            child: ElevatedButton(
                              onPressed: _login, // Llama a la función _login para iniciar sesión.
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink, // Color de fondo del botón.
                                padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.025), // Ajuste de padding.
                              ),
                              child: const Text(
                                'Iniciar Sesión', // Texto del botón de inicio.
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10), // Espacio entre botones.
                          SizedBox(
                            width: double.infinity, // Hace que el botón de Google ocupe todo el ancho.
                            child: ElevatedButton(
                              onPressed: signInWithGoogle, // Llama a la función de inicio de sesión con Google.
                              child: const Text(
                                'Iniciar con Google',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent, // Color de fondo del botón de Google.
                                padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.025),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20), // Espacio entre botones.
                          SizedBox(
                            width: double.infinity, // Botón ancho completo.
                            child: ElevatedButton(
                              onPressed: _loginAnonymously, // Llama a la función de inicio de sesión anónimo.
                              child: const Text(
                                'Ingresar como Invitado',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[700],
                                padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.025),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Espacio entre formulario y enlaces.
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Registrate()), // Navega a la página de recuperación.
                        );
                      },
                      child: const Text('¿Olvidaste tu contraseña?', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
